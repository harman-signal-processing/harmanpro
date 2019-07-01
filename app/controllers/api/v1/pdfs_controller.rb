module Api
  module V1
    class PdfsController < ApplicationController
        respond_to :xml, :json, :html
        layout "minimal"
        
        def index
            @pdfs_to_index = []
            @pdfs = Resource.where("resource_type is not null and include_in_pdf_search=1").pluck(:id, :name, :attachment_file_name)
            @pdfs_to_index = @pdfs.map{|item|
            # binding.pry
                {id: item[0], name: item[1], file: item[2], url: resource_permalink_url(item)}
            }
            # resource_permalink_url(resource)
            respond_with @pdfs_to_index.uniq
        end  #  index
    end  #  class PdfsController < ApplicationController
  end  #  module V1
end  #  module Api