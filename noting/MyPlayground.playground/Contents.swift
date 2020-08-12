import UIKit

struct WeatherManger {
    
let url = "http://api.openweathermap.org/data/2.5/weather?q="
var cityName = "Taegu"
let appId = "&appid=92863a6e6b49757727ca29249892156c"

func makingUrlString(){
    
    print("\(url)\(cityName)\(appId)")
    
}
}
var wearher: WeatherManger = WeatherManger()
wearher.cityName = "Seoul"
wearher.makingUrlString()
