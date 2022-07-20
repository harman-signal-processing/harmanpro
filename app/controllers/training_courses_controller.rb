class TrainingCoursesController < ApplicationController
  respond_to :json, :xml, :html

  def index
    get_training_content_page('classroom-courses')
    @courses = TrainingCourseApi.courses
    respond_with(@courses)

    #respond_with(@courses) do |format|
    #    debugger

    #    format.xml { render :xml => @courses.to_xml }
    #    format.json { render :json => @courses.to_json }
    #end  #  respond_with(@courses) do |format|

  end  #  def index

  def sso
    encodedUserData = session[:training_user_encoded]
    if encodedUserData.present?
      redirect_to("https://traininglogin.harmanpro.com/sso/step1HarmanCallAbsorb/?ud=" + encodedUserData, allow_other_host: true) and return false
    else
      redirect_to "https://training.harmanpro.com/", allow_other_host: true and return false
    end
  end  #  def sso

end  #  class TrainingCoursesController < ApplicationController
