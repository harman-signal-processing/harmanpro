class TrainingCourseApi
    include HTTParty
    base_uri 'trade.amx.com/webservice/proxyservice.asmx'
    format :xml
    
    def self.courses
        get('/GetTrainingCourseCatalog')
    end
end
