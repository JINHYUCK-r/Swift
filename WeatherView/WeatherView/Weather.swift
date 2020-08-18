//
//  Weather.swift
//  WeatherView
//
//  Created by 류진혁 on 2020/08/18.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import Foundation

struct Weather:Codable {
    
    let city_name : String
    let state : Int
    let celsius : Int
    let rainfall_probability : Int
   
}
