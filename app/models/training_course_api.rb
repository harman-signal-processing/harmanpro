class TrainingCourseApi
    include HTTParty
    
    format :xml
    
    def self.courses
        get('http://trade.amx.com/webservice/proxyservice.asmx/GetTrainingCourseCatalog')
    end
end
