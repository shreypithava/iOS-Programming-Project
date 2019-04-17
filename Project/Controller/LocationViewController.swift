//
//  LocationViewController.swift
//  Project
//
//  Created by Shrey Pithava on 3/30/19.
//  Copyright © 2019 Shrey Pithava. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON


class LocationViewController: UIViewController, CLLocationManagerDelegate {
    
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "5835299e0290e950d93097d1994444ab"
    
    let locationManager = CLLocationManager()
    let locationPlace = LocationClass()

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        // Do any additional setup after loading the view.
    }
    
    func getLocation(url: String, parameters: [String : String]) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                print("Success")
                
                let weatherJSON : JSON = JSON(response.result.value!)
                self.updateLocation(json: weatherJSON)
                
            } else {
                print("Error \(String(describing: response.result.error))")
                self.cityLabel.text = "Connection Issues"
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.startUpdatingLocation()
            locationManager.delegate = nil
            
            print("Longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
            
            getLocation(url: WEATHER_URL, parameters: params)
        }

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func updateLocation(json: JSON) {
        if let tempResult = json["main"]["temp"].double {
            locationPlace.temperature = Int(tempResult - 273.15)
            
            locationPlace.city = json["name"].stringValue
            locationPlace.condition = json["weather"][0]["id"].intValue
            updateView()
        } else {
            cityLabel.text = "Weather Unavailable"
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text! = "City unavailable"
    }
    
    
    func updateView() {
        cityLabel.text = locationPlace.city
        temperatureLabel.text = "\(locationPlace.temperature)°"
    }
    
}
