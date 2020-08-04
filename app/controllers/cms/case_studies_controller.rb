class Cms::CaseStudiesController < CmsController
  before_action :set_locale_for_translator

  def index
    @case_studies = CaseStudy.all
    if @available_locale
      render template: 'cms/available_locales/case_studies/index' and return false
    end
  end

  def show
    @case_study = CaseStudy.find(params[:id])
    if @available_locale
      render template: 'cms/available_locales/case_studies/edit' and return false
    end
  end

  def edit
    @case_study = CaseStudy.find(params[:id])
    if @available_locale
      render template: 'cms/available_locales/case_studies/edit' and return false
    end
  end

  def update
    @case_study = CaseStudy.find(params[:id])
    if @case_study.update(case_study_params)
      if @available_locale
        redirect_to [:cms, @available_locale, @case_study.class], notice: 'Update successful'
      end
    else
      if @available_locale
        render template: 'cms/available_locales/case_studies/edit'
      end
    end
  end

  private

  def case_study_params
    params.require(:case_study).permit(
      :headline,
      :description,
      :content,
      :vertical_market_id,
      :banner
    )
  end
end
