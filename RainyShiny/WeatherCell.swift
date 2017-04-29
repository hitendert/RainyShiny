//
//  WeatherCell.swift
//  RainyShiny
//
//  Created by Hitender Thejaswi on 4/19/17.
//  Copyright © 2017 Hitender Thejaswi. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
    
    func configureCell(forecast : ForecastWeather) {
        
        lowTemp.text = "\(forecast.lowTemp)"
        highTemp.text = "\(forecast.highTemp)"
        weatherType.text = "\(forecast.weatherType)"
        dayLabel.text = "\(forecast.date)"
        
        weatherIcon.image = UIImage(named: forecast.weatherType)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

}
