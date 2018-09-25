class MediaLibraryAccessRequestsController < ApplicationController
  def new
    @landing_page = LandingPage.where(slug: 'request-media-library-access').first_or_initialize
    @media_library_access_request = MediaLibraryAccessRequest.new
  end

  def create
    @media_library_access_request = MediaLibraryAccessRequest.new(media_library_access_request_params)
    if @media_library_access_request.save
      redirect_to media_library_path, notice: "Your request has been sent."
    else
      @landing_page = LandingPage.where(slug: 'request-media-library-access').first_or_initialize
      render action: :new
    end
  end

  private

  def media_library_access_request_params
    params.require(:media_library_access_request).permit(:first_name,
                                                         :last_name,
                                                         :email,
                                                         :relationship,
                                                         :employee_csu,
                                                         :employee_office,
                                                         :job_title,
                                                         :company,
                                                         :region,
                                                         :other_relationship,
                                                         :reason_for_request,
                                                         :what_assets)
  end
end
