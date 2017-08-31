class SearchController < ApplicationController

  def search
    @query = params[:query]
    if @query.to_s.match(/union\s{1,}select/i) || @query.to_s.match(/and|\&*\s{1,}sleep/i) || @query.to_s.match(/order\s{1,}by/i)
      render plain: "Not allowed", status: 400 and return false
    end
    query = @query.to_s.gsub(/[\/\\]/, " ")
    @results = ThinkingSphinx.search(
      ThinkingSphinx::Query.escape(query)
    ).page(params[:page]).per(10)
  end

end
