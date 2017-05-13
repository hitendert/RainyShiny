//
//  WeatherVC.swift
//  RainyShiny
//
//  Created by Hitender Thejaswi on 4/17/17.
//  Copyright © 2017 Hitender Thejaswi. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var currentTempLabel: UILabel!

    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var currentWeatherImage: UIImageView!
    
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    
    @IBOutlet weak var myTableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation : CLLocation!
    
    
    
    var currentWeather : CurrentWeather!
    var forecastWeather : ForecastWeather!
    
    var forecastArray = [ForecastWeather]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
    
        currentWeather = CurrentWeather()
        
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    
    func locationAuthStatus() {
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            currentWeather.downloadWeatherDetails {
                self.downloadForecastData {
                    
                    self.updateMainUI()
                }
            }
            
            
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            
            let forecast = forecastArray[indexPath.row]
            
            cell.configureCell(forecast: forecast)
            return cell
            
        }
        
        return WeatherCell()
    }
    
    func updateMainUI() {
        
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather.currentTemp)"
        locationLabel.text = currentWeather.cityName
        currentWeatherTypeLabel.text = currentWeather.weatherType
        
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
        
    }
    
    func downloadForecastData(completed : @escaping DownloadComplete)
    {
        
        // Use AlamoFire to get the JSON data.
        Alamofire.request(FORECAST_WEATHER_URL).responseJSON{ response in
            
            // Store the data in Result.
            let result = response.result
            
            // Store the result into a Dictionary
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>]{
                    
                    
                    for obj in list {
                        
                        let forecast = ForecastWeather(weatherDict : obj)
                        
                        self.forecastArray.append(forecast)
                        
                        print(obj)
                    }
                    self.forecastArray.remove(at: 0)
                    self.myTableView.reloadData()
                }
                
            }
            
            
        }
        completed()
        
    }
}

