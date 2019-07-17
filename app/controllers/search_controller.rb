class SearchController < ApplicationController

  def search
    @query = params[:query]
    if pdf_only_search_results?
      fetch_thunderstone_pdf_results
    else
      fetch_thinking_sphinx_results
    end
  end

  private

  def indices
    indices = ["site_setting", "case_study", "vertical_market", "landing_page"].map do |elem|
      "#{elem}_#{I18n.locale.to_s.gsub(/\-/, '_')}_core"
    end
    indices
  end
  
  def fetch_thinking_sphinx_results
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
  end  #  def fetch_thinking_sphinx_results

  def pdf_only_search_results?
    # The user wants PDF only search if they check the box or they are clicking the pagination links after they have submitted a PDF only search.
    # If they want to exit the PDF only search they will just need to uncheck the box and click search
    checkbox_pdf_only = [true,'true','yes',1,'1','on'].include?(params[:pdf_only])
    paginate_pdf_only = [true,'true','yes',1,'1','on'].include?(params[:paginate_pdf_only])
    if checkbox_pdf_only == true || paginate_pdf_only == true
      @pdf_only = true
    else
      @pdf_only = false
    end    
    @pdf_only
  end

  def fetch_thunderstone_pdf_results
    current_page = params[:page].nil? ? 1 : params[:page].to_i
    per_page = 10
    #jump tells Thunderstone where to start the next fetch
    jump = current_page == 1 ? 0 : (current_page-1)*per_page
    
    if @query.present?
      thunderstone_search_profile = "hpro_pdfs"
      @pdf_results = ThunderstoneSearch.find(@query, thunderstone_search_profile, jump)
      paginatable_array = Kaminari.paginate_array(@pdf_results[:ResultList], total_count: @pdf_results[:Summary][:Total].to_i).page(current_page).per(10)
      @results = paginatable_array
    end     
  end  #  def fetch_thunderstone_pdf_results

end
