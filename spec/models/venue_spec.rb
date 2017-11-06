require 'rails_helper'

RSpec.describe Venue, type: :model do

  before(:all) do
    @venue = FactoryBot.create :venue
  end

  subject { @venue }
  it { should respond_to :name }
  it { should respond_to :description }
  it { should respond_to :left }
  it { should respond_to :top }
  it { should respond_to :friendly_id }

end
