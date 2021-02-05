class Emea::EmployeeContactsController < EmeaController

  # Returns all departments
  def departments
    @contacts = EmeaEmployeeContact.order(Arel.sql("department")).pluck(:department).uniq

    render_json
  end

  # Returns job functions in the department
  def job_functions
    @contacts = EmeaEmployeeContact.where(
      department: params[:department_id]
    ).order(Arel.sql("job_function")).pluck(:job_function).uniq

    render_json
  end

  # All the contacts for the given department and job function
  def contacts
    @contacts = EmeaEmployeeContact.where(
      department: params[:department_id],
      job_function: params[:job_function_id]
    ).order(Arel.sql("name"))

    render_json
  end

  private

  def render_json
    respond_to do |format|
      format.json { render json: { "employee_contacts" => @contacts } and return }
    end
  end
end
