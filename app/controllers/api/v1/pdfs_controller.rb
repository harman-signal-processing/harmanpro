module Api
  module V1
    class PdfsController < ApplicationController
        respond_to :xml, :json, :html
        layout "minimal"
        
        def index
            @pdfs_to_index = []
            @pdfs = Resource.where("resource_type is not null and include_in_pdf_search=1")
            @pdfs_to_index = @pdfs.map{|item|
                {id: item.id, name: item.name, file: item.attachment_file_name, url: item.attachment.url}
            }
            respond_with @pdfs_to_index.uniq
        end  #  index
    end  #  class PdfsController < ApplicationController
  end  #  module V1
end  #  module Api