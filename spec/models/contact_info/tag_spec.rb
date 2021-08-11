require 'rails_helper'

RSpec.describe ContactInfo::Tag, type: :model do
  before :all do
    @tag = FactoryBot.create(:contact_info_tag)
    @contact = FactoryBot.create(:contact_info_contact)
  end  #  before do

  context 'Validate Tag attributes' do
  	it 'Tag should have expected attributes' do
  		expect(@tag.name).to match(/Tag \d/)
  	end  #  it 'Tag should have expected attributes' do

  	it 'Tag should be unique' do
      tag = ContactInfo::Tag.new(name: @tag.name)
  	  expect(tag).not_to be_valid
  	  expect(tag.errors[:name]).to include("has already been taken")
  	end  # it 'Tag name should be unique' do
  end  #  context 'Validate Tag attributes' do

  context 'Validate Tag associations' do
  	it 'Tag should allow Contact associations' do
  		@tag.contacts << @contact
  		expect(@tag.contacts.size).to eq(1)
  	end
  	it 'Tag should allow removal of Contact associations' do
			@tag.contacts << @contact
  		expect(@tag.contacts.size).to eq(1)
  		@tag.contacts.destroy(@contact)
  		expect(@tag.contacts.size).to eq(0)
  	end
  end  #  context 'Validate Tag associations' do

end  #  RSpec.describe ContactInfo::Tag, type: :model do
