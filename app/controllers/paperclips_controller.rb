class PaperclipsController < ApplicationController

  # This redirects old URLs for paperclip attachments to their new location on the CDN.
  # It should only kick in if the file in the filesystem is missing. So, keep old files
  # on the filesystem until you're ready for this to do its thing.
  #
  def redirects
    model = params[:model].classify
    new_path_interpolation = ":class/:attachment/:id_:timestamp/:basename_:style.:extension"

    if params[:id1].present? && params[:id2].present? && params[:id3].present?
      id_partition = []
      id_partition << params[:id1]
      id_partition << params[:id2]
      id_partition << params[:id3]
      record_id = id_partition.join.to_i.to_s
    elsif params[:id_and_timestamp].present?
      params[:id_and_timestamp].to_s.match(/^(\d{1,})\_+/)
      record_id = $1
      new_path_interpolation = ":class/:attachment/:id_:timestamp/:basename.:extension"
    end

    record = model.constantize.find(record_id)
    attachment = record.send(params[:attachment].singularize)

    begin
      new_url = []
      new_url << ENV['FOG_HOST_ALIAS']
      new_url << Paperclip::Interpolations.interpolate(new_path_interpolation, attachment, params[:style])

      redirect_to new_url.join("/"), status: :moved_permanently and return false
    rescue TypeError
      raise ActiveRecord::RecordNotFound
    end
  end

end
