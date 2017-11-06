FactoryBot.define do
  factory :contact_message do
    name "MyString"
    email "me@me.com"
    message "MyText"
    product "MyString"
    operating_system "MyString"
    message_type "MyString"
    company "MyString"
    account_number "MyString"
    billing_address "MyString"
    billing_city "MyString"
    billing_state "MyString"
    billing_zip "MyString"
    shipping_address "MyString"
    shipping_city "MyString"
    shipping_state "MyString"
    shipping_zip "MyString"
    product_sku "MyString"
    product_serial_number "MyString"
    warranty false
    purchased_on 2.weeks.ago
    part_number "MyString"
    shipping_country "MyString"
    brand
  end
end
