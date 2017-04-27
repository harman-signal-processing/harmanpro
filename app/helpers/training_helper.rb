module TrainingHelper

    def training_sso_link(url)
        #url + '/sso/step1HarmanCallAbsorb/?ud=' + encodedUserData
        "/training/sso"
    end  #training_sso_link
    
    def haveEncodedUserData
        encodedUserData.present?
    end  #  haveEncodedUserData
    
    def encodedUserData
        params[:ud] || session[:training_user_encoded]
    end  #  encodedUserData
    
end  #  TrainingHelper