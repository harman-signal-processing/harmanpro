class SearchController < ApplicationController

  def search
    @query = params[:query]
    page_num = params[:page] || 1
    if @query.to_s.match(/union\s{1,}select/i) || @query.to_s.match(/(and|\&*)\s{1,}sleep/i) || @query.to_s.match(/order\s{1,}by/i)
      render plain: "Not allowed", status: 400 and return false
    end
    query = @query.to_s.gsub(/[\/\\]/, " ")
    initial_results = ThinkingSphinx.search(
      ThinkingSphinx::Query.escape(query),
      indices: indices,
      field_weights: {consultant_content: 100} # making sure consultant contacts rank high with relevant searches
    )

    consultant_dup_count = initial_results.grep(SiteSetting).count
    last_consultant_dup = initial_results.grep(SiteSetting).last if consultant_dup_count > 1
    initial_results.delete(last_consultant_dup)
    initial_results.delete_if {|result| result.respond_to?(:live?) && !result.live? }

    # https://github.com/kaminari/kaminari#paginating-a-generic-array-object
    paginatable_array = Kaminari.paginate_array(initial_results).page(page_num).per(10)
    
    @results = paginatable_array
  end

  private

  def indices
    indices = ["site_setting", "case_study", "vertical_market", "landing_page"].map do |elem|
      "#{elem}_#{I18n.locale.to_s.gsub(/\-/, '_')}_core"
    end
    indices
  end

end
