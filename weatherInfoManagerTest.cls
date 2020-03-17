@isTest
global class weatherInfoManagerTest {
    
     @istest static void getCityWeatherTestPass()
    {
        Map<String, Object> weatherInfo = new Map<String, Object>();
        //Test.setMock(HttpCalloutMock.class, new weatherInfoManagerMock());
        System.Test.setMock(HttpCalloutMock.class, new weatherInfoManagerMock());
        weatherInfo = weatherInfoManager.getCityWeather('Chennai');
        System.assert(!weatherInfo.isEmpty());       
        
    }
    
    @istest static void getCityWeatherTestFail()
    {
        Map<String, Object> weatherInfo = new Map<String, Object>();
        weatherInfo = weatherInfoManager.getCityWeather('');
        system.assert(weatherInfo.isEmpty());
    }
    
    @istest static void geoLocationPass()
    {
        string lat = '32.345';
        string longi = '12.453';
        string url = weatherInfoManager.geoLocation(lat,longi);  
        system.assert(!string.isEmpty(url));
    }

}