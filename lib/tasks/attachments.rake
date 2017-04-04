namespace :attachments do

  desc "copy paperclip attachments to a new scheme"
  task :move_paperclips => :environment do
    # Rackspace cloud files connection
    rackspace = Fog::Storage.new({
      provider:           'Rackspace',
      rackspace_username: ENV['RACKSPACE_USERNAME'],
      rackspace_api_key:  ENV['RACKSPACE_API_KEY'],
      rackspace_region:   :ord
    })

    @container = rackspace.directories.new(key: ENV['FOG_PAPERCLIP_CONTAINER'])

    [Artist, Brand, CaseStudy, Event, Feature, LandingPage, NewsArticle, OnlineRetailer,
     Product, ReferenceSystem, Slide, TrainingContentPage, VerticalMarket, Resource].each do |klass|
      puts " #{ klass.to_s } ================= "
      klass.attachment_definitions.keys.each do |att|
        if att == "attachment" # && klass == Resource
          old_path_interpolation = ":rails_root/public/system/:class/:attachment/:id_:timestamp/:basename.:extension"
          new_path_interpolation = ":class/:attachment/:id_:timestamp/:basename.:extension"
        else
          old_path_interpolation = ":rails_root/public/system/:class/:attachment/:id_partition/:style/:basename.:extension"
          new_path_interpolation = ":class/:attachment/:id_:timestamp/:basename_:style.:extension"
        end
        klass.all.each do |i|
          if i.send(att).present?
            attachment = i.send(att)
            styles = [:original] + attachment.styles.map{|k,v| k}
            styles.each do |style|
              old_file_path = Paperclip::Interpolations.interpolate(old_path_interpolation, attachment, style) #see paperclip docs
              new_file_path = Paperclip::Interpolations.interpolate(new_path_interpolation, attachment, style)

              puts "== Current file path:  #{old_file_path}"
              puts "== New file path:  #{new_file_path}"

              if File.exists?(old_file_path)
                file = @container.files.new(key: new_file_path, body: File.read(old_file_path), content_type: attachment.content_type)
                file.save
              else
                puts "==== ! Real File Not Found ! "
              end
            end
          end
        end
      end
    end
  end

end
