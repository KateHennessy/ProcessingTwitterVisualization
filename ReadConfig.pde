     class ReadConfig{
      private  String _consumerKey;
      private  String _consumerSecret;
      private  String _accessToken;
      private  String _accessTokenSecret;
      
      public ReadConfig(String pathToFile){
        String[] lines = loadStrings(pathToFile);
        for (int i = 0 ; i < lines.length; i++) {
          String[] aLine = lines[i].split(":");
          try{
          if(aLine != null){
            switch(aLine[0]){
              case "consumerkey":
                this._consumerKey = aLine[1]; 
                break;
              case "consumersecret": 
                this._consumerSecret = aLine[1]; 
                break;
              case "accesstoken": 
                this._accessToken = aLine[1]; 
                break;
              case "accesstokensecret":
                this._accessTokenSecret = aLine[1]; 
                break;
              default :
                System.out.println("Error parsing line in config");
                System.exit(1);
              
            }
          }
          
        }catch(NullPointerException e){
          System.out.println("Error with config file format, please review the file");
           System.exit(1);
        }
       
        }
        
      }
      
      
      public String getConsumerKey(){
        return _consumerKey;
      }
      
      public String getConsumerSecret(){
        return _consumerSecret;
      }
      
      public String getAccessToken(){
        return _accessToken;
      }
      
      public String getAccessTokenSecret(){
        return _accessTokenSecret;
      }
     
    }