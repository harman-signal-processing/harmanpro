class Contacts
    
    def self.get_all_contacts
        contact_data_file_path = Rails.root.join("public/contacts.json")
        contact_data_file_timestamp = File.mtime(contact_data_file_path)
        cache_key = ["contacts.cache", contact_data_file_timestamp].join('-')
        Rails.cache.fetch(cache_key, expires_in: 1.day) do
            contacts = File.read(contact_data_file_path)
            JSON.parse(contacts)
        end
    end  #  def get_all_contacts
    
    def self.get_all_contact_slugs
        contact_data_file_path = Rails.root.join("public/contact.slugs.json")
        contact_data_file_timestamp = File.mtime(contact_data_file_path)
        cache_key = ["contact.slugs.cache", contact_data_file_timestamp].join('-')
        Rails.cache.fetch(cache_key, expires_in: 1.day) do
            contacts = File.read(contact_data_file_path)
            JSON.parse(contacts)
        end        
    end  #  def self.get_all_contact_slugs
    
    def self.get_all_contact_nav_list
        contact_data_file_path = Rails.root.join("public/contacts.nav.json")
        contact_data_file_timestamp = File.mtime(contact_data_file_path)
        cache_key = ["contacts.nav.cache", contact_data_file_timestamp].join('-')
        Rails.cache.fetch(cache_key, expires_in: 1.day) do
            contacts = File.read(contact_data_file_path)
            JSON.parse(contacts)
        end        
    end  #  def self.get_all_contact_nav_list    
    
end  # class Contacts