class Emea::EmployeeContactsController < EmeaController
  respond_to :json

  # Returns all departments
  def departments
    respond_with EmeaEmployeeContact.order(Arel.sql("department")).pluck(:department).uniq
  end

  # Returns job functions in the department
  def job_functions
    respond_with EmeaEmployeeContact.where(
      department: params[:department_id]
    ).order(Arel.sql("job_function")).pluck(:job_function).uniq
  end

  # All the contacts for the given department and job function
  def contacts
    respond_with EmeaEmployeeContact.where(
      department: params[:department_id],
      job_function: params[:job_function_id]
    ).order(Arel.sql("name"))
  end

end
