//  CurrentWeather.swift


import UIKit
import Alamofire

class CurrentWeather {
    private var _cityName : String!
    private var _date : String!
    private var _weatherType : String!
    private var _currentTemp : Double!
    
    var cityName : String {
        get {
            return _cityName
        }
        set {
            if _cityName == nil
            {
                _cityName = ""
            }
        }
    }
    
    var date : String {
        if _date == nil {
            _date = ""
        }
        
// Date formatter starts here
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        let currentDate = dateFormatter.string(from: Date())
        
        self._date = "Today, \(currentDate)"
        return _date
// Date formatter ends here
    }
    
    var weatherType : String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp : Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    
    // Download Weather Details
    
    
    func downloadWeatherDetails(completed : @escaping DownloadComplete) {
     
        
// Using AlamoFire get the response in JSON Format.
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON { response in
            
//Save the response in a variable called result
            let result = response.result
            
// Put the reponse result into a dictionary
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let name = dict["name"] as? String  {
                    self._cityName = name.capitalized
                    print(self._cityName)
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    
                    if let main = weather[0]["main"] as? String {
                        
                        self._weatherType = main.capitalized
                        
                        print(self._weatherType)
                    }
                    
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    
                    if let currentTemp = main["temp"] as? Double {
                    
                        let kelvinToCelsius = Double(round(currentTemp - 273.15))
                        
                        self._currentTemp = kelvinToCelsius
                        
                        print(self.currentTemp)
                    }
                    
                }
                
            }
            completed()
        }
// Indicate the download is completed.
    
    }
    
}
