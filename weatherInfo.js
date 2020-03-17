import { LightningElement, track, api } from 'lwc';
import getCityWeather from '@salesforce/apex/weatherInfoManager.getCityWeather';
import geoLocation from '@salesforce/apex/weatherInfoManager.geoLocation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class WeatherInfo extends LightningElement {

    @track city;
    @track spinner;
    @track infoFromResponse;
    @track weatherData;
    @track weatheDescription;
    @track temperature;
    @track humidity;
    @track maxTemp;
    @track minTemp;
    @track options = {
        enableHighAccuracy: true,
        timeout: 5000,
        maximumAge: 0
      };
    @track location;

    handleCity(event) {
        this.city = (event.target.value).toUpperCase();
    }

    handleRetrieveWeather() {
        
        if(this.city)
        {
        this.spinner = true;
        //pass input city value to apex to get corresponding response from API
        getCityWeather({ cityName: this.city })
            .then((data) => {
                //data contains weather informations obtained from api for the input city
                this.infoFromResponse = data.main;
                this.weatherData = data.weather[0];
                this.temperature = (this.infoFromResponse.temp - 273.15).toFixed(1);
                this.humidity = this.infoFromResponse.humidity;
                this.maxTemp = (this.infoFromResponse.temp_max- 273.15).toFixed(1);
                this.minTemp = (this.infoFromResponse.temp_min- 273.15).toFixed(1);
                this.weatheDescription = this.weatherData.description;
                this.spinner = false;
            })
            .catch(error => {
                this.spinner = false;
                
                const showError = new ShowToastEvent({
                    title: 'Error',
                    message: 'City data unavailable' ,
                    variant: 'error',
                });
                this.dispatchEvent(showError);
            });
        }
        if (!this.city) 
        {
            const showError = new ShowToastEvent({
                title: 'Error',
                message: 'Please enter a city name' ,
                variant: 'error',
            });
            this.dispatchEvent(showError);
        }  
        
    }

    handleGeolocation()
    {
        if (navigator.geolocation) {
            // Get the user's current position
            navigator.geolocation.getCurrentPosition(this.showPosition,this.errorHandler,this.options);
        } else {
            alert('Geolocation is not supported in your browser');
        }
    }

    showPosition(position) {
        //get latitude and longitude info and pass to apex to get endpoint
        geoLocation({ latitude : (position.coords.latitude).toString(),
            longitude : (position.coords.longitude).toString() })
            .then((data) => {
                //Data has map endpoint that will redirect user to current location based on browser data obtained
                window.open(data);
                
            })
                
        }

        errorHandler(error)
        {
            if (error.code == 1) {
                alert('Permission Denied')                
             }
             if (error.code == 2) {
                alert('Location cannot be determined')                
             }
        }

}