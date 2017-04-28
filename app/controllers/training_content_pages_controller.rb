class TrainingContentPagesController < ApplicationController
  def show
    slug = params[:id].nil? ? "training-home" : params[:id]
    
    #This is a total hack to hide the ud parameter
    if params[:ud].present? && slug == "training-home"
      redirect_to "/training" and return false
    end
    
    render_training_content_page(slug)
  end # def show

  private

  def render_training_content_page(slug)
    get_training_content_page(slug)
    render "training_content_pages/show"
  end # def render_training_content_page(slug)
end
