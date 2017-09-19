module CaseStudiesHelper

  def vertical_markets_with_case_studies
    VerticalMarket.where(live: true).with_translations(I18n.locale).order("name").select do |vm|
      vm if vm.case_studies.count > 0
    end
  end

end
