class TrainingCourseApi
  include HTTParty
  base_uri 'trade.amx.com/webservice/proxyservice.asmx'
  format :xml

  def self.courses
    get('/GetTrainingCourseCatalog')
  end
  
  def self.calendar
    #get('/GetTrainingCalendar?fromDate=1-1-0001&toDate=1-1-0001&resultFormat=JSON')
    fromDate = Date.today.month.to_s + "-" + Date.today.day.to_s + "-" + Date.today.year.to_s
    plusOneYear = Date.today + 1.year
    toDate = plusOneYear.month.to_s + "-" + plusOneYear.day.to_s + "-" + plusOneYear.year.to_s
    begin
      JSON.parse(get('/GetTrainingCalendar?fromDate=' + fromDate + '&toDate=' + toDate + '&resultFormat=JSON')["string"])
    rescue
      {}
    end
  end
  
end
