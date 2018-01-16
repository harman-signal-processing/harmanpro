class Contacts
    # include HTTParty
    # base_uri 'https://trade.amx.com/_contactsTest'
    
    def self.get_all_contacts
        # contacts = get('/contacts.json')
        
        contact_data_file_path = Rails.root.join("public/contacts.json")
        contact_data_file_timestamp = File.mtime(contact_data_file_path)

        cache_key = ["contacts.cache", contact_data_file_timestamp].join('-')
        Rails.cache.fetch(cache_key, expires_in: 1.day) do
            contacts = File.read(contact_data_file_path)
            JSON.parse(contacts)
        end
        
    end  #  def get_all_contacts
    
end  # class Contacts