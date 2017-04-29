//
//  ForecastWeather.swift
//  RainyShiny
//
//  Created by Hitender Thejaswi on 4/19/17.
//  Copyright © 2017 Hitender Thejaswi. All rights reserved.
//

import UIKit
import Alamofire

class ForecastWeather {
    
    private var _date : String!
    private var _weatherType : String!
    private var _highTemp : String!
    private var _lowTemp : String!
        
    var date : String {
    
        get {
            return _date
        }
        
        set{
            if _date == nil {
                _date = ""
            }
        }
    }
    
    
    var weatherType : String {
        
        get {
            return _weatherType
        }
        
        set{
            if _weatherType == nil {
                _weatherType = ""
            }
        }
        
    }
    
    var highTemp : String {
    
        get{
        return _highTemp}
        set{
            if _highTemp == nil {
                _highTemp = ""
            }
        }
    }
    
    
    var lowTemp : String {
        get {
        return _lowTemp}
        set{
            if _lowTemp == nil {
                _lowTemp = ""
            }}
        
    }
    
    // Initializer starts here ------->
    
    init(weatherDict : Dictionary<String, AnyObject> ){
        
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject> {
            
            if let minTemp = temp["min"] as? Double {
            
            let kelvinToCelsius = Double(round(minTemp - 273.15))
            
            self._lowTemp = "\(kelvinToCelsius)"
            }
            
            
            if let highTemp = temp["max"] as? Double {
                
                let kelvinToCelsius = Double(round(highTemp - 273.15))
                
                self._highTemp = "\(kelvinToCelsius)"
            }
            
            
        }

        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            
            if let main = weather[0]["main"] as? String {
                
                self._weatherType = main
            }
        }
        
        if let date = weatherDict["dt"] as? Double{
        
        let unixConvertedDate = Date(timeIntervalSince1970: date)
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .full
        
        dateFormatter.dateFormat = "EEEE"
        
        dateFormatter.timeStyle = .none
        
        self._date = unixConvertedDate.dayOfTheWeek()
        
        }
    }
    
    
    // Initializer ends here <---------
    
 

}


extension Date {
    
    func dayOfTheWeek() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: self)
    }
    
}


