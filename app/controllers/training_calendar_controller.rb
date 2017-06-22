class TrainingCalendarController < ApplicationController
  respond_to :json, :xml, :html
  
  def index
        get_training_content_page('classroom-schedules')
        @calendar = TrainingCourseApi.calendar
        @countryList = uniqueCountryList(@calendar)
        @scheduleByCountry = {}
        loadSchedulesByCountry(@calendar, @scheduleByCountry)
        respond_with(@calendar)
  end  #  def index
  
  def uniqueCountryList(calendarData)
    countries = []
    calendarData.each do |item|
      unless item["VenueCountry"].blank? 
        countries << item["VenueCountry"] 
      end
    end  #  calendarData.each do |item|
    countries.to_set.to_a.sort
  end  #  uniqueCountryList
  
  def loadSchedulesByCountry(calendarData, countryScheduleHash)
    
    calendarData.each do |item|
      country = item["VenueCountry"]
      
      # if the country hash is not present create it and add the current item, otherwise add the current item to the existing country hash
      countryScheduleHash[country].nil? ? countryScheduleHash[country] = [item] : countryScheduleHash[country] << item

    end  #  calendarData.each do |item|
    
  end  #  def loadSchedulesByCountry(calendarData, countryScheduleHash)
  
end  #  class TrainingCalendarController < ApplicationController
