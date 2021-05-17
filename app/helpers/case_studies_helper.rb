module CaseStudiesHelper

  def vertical_markets_with_case_studies
    VerticalMarket.where(live: true).with_translations(I18n.locale).order(Arel.sql("name")).select do |vm|
      vm if vm.case_studies.size > 0
    end
  end

end
