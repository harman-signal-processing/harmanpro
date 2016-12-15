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
    
end
