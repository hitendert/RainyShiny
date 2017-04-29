//
//  Location.swift
//  RainyShiny
//
//  Created by Hitender Thejaswi on 4/19/17.
//  Copyright © 2017 Hitender Thejaswi. All rights reserved.
//


import CoreLocation


class Location {

    static var sharedInstance = Location()
    private init() {}
    
    var latitude : Double!
    var longitude : Double!

}
