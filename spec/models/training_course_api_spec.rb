require 'rails_helper'

RSpec.describe TrainingCourseApi do

  it "should return courses data" do
     expect(TrainingCourseApi.courses).not_to be_nil
  end

end  #  RSpec.describe TrainingCourseApi
