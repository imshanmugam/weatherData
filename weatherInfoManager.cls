public without sharing class weatherInfoManager {
    
    @AuraEnabled
    public static Map<String, Object> getCityWeather(String cityName){
        
        Map<String, Object> responseMap = new Map<String, Object>();
        if(String.isEmpty(cityName))
        {
            return responseMap;
        }
        //frame the endpoint with city value
        String restAPIURL = String.valueOf(System.Label.openWeatherAPI_Endpoint);
        restAPIURL += '?q='+cityName;
        restAPIURL += '&APPID='+String.valueOf(System.Label.OpenWeatherMapApikey);
        String response = '';
        
        HttpRequest httpRequest = new HttpRequest(); 
        httpRequest.setMethod('GET');  
        httpRequest.setEndpoint(restAPIURL);
        
        
        Http http = new Http();  
        //make api request and capture response
        HttpResponse httpResponse = http.send(httpRequest);
        
        if (httpResponse.getStatusCode() == 200 ) { 
            //deserialize and type cast response into a map and pass data to js controller
            responseMap = (Map<String, Object>) JSON.deserializeUntyped(httpResponse.getBody());
            
            return responseMap;
        }
                
        return responseMap;
    }

    @AuraEnabled
    public static string geoLocation(string latitude, string longitude){

        //frame endpoint url with lat and long values captured from HTML geolocation
        String mapAPIURL = String.valueOf(System.Label.googleMaps);
        mapAPIURL += '?q='+latitude+','+longitude;
        //pass back endpoint for redirection
        return mapAPIURL;
        
    }
}