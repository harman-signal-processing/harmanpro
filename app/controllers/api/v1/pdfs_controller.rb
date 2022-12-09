module Api
  module V1
    class PdfsController < ApplicationController
      layout "minimal"

      def index
        @pdfs_to_index = []
        @pdfs = Resource.where("resource_type is not null and include_in_pdf_search=1")
        @pdfs_to_index = @pdfs.map{|item|
          {id: item.id, name: item.name, file: item.attachment_file_name, url: item.attachment.url}
        }.uniq
        @pdfs_for_text_list = @pdfs_to_index.pluck(:url)

        respond_to do |format|
          format.html
          format.xml { render xml: @pdfs_to_index }
          format.json { render json: { "pdfs" => @pdfs_to_index } }
          format.text
        end

      end  #  def index

    end  #  class PdfsController < ApplicationController
  end  #  module V1
end  #  module Api
