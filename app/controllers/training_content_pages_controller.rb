class TrainingContentPagesController < ApplicationController
    def show
      slug = params[:id].nil? ? "training-home" : params[:id]
      render_training_content_page(slug)
    end
    
    private
    
    def render_training_content_page(slug)
      get_training_content_page(slug)
      render "training_content_pages/show"
    end 
end
