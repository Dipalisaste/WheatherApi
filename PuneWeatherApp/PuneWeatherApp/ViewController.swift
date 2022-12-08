//
//  ViewController.swift
//  PuneWeatherApp
//
//  Created by Felix-ITS015 on 16/09/1944 Saka.
//  Copyright © 1944 Felix. All rights reserved.
//

import UIKit

struct Youtube: Decodable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
}

// MARK: - Clouds
struct Clouds: Decodable {
    let all: Int
}

// MARK: - Coord
struct Coord: Decodable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Decodable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity, seaLevel, grndLevel: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

// MARK: - Sys
struct Sys: Decodable {
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Weather
struct Weather: Decodable {
    let id: Int
    let main, weatherDescription, icon: String
    
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct Wind: Decodable {
    let speed: Double
    let deg: Int
    let gust: Double
}

class ViewController: UIViewController {
    
   // @IBOutlet weak var wheathertableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var latLabel: UILabel!
    
    @IBOutlet weak var lonLabel: UILabel!
    
    @IBOutlet weak var disLabel: UILabel!
    var weatherArr:Youtube?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchAPI()
    }
    func fetchAPI(){
        
        let str = "https://api.openweathermap.org/data/2.5/weather?lat=18.51&lon=73.85&appid=161c3f12e9087e24afdaaf4a2fc30248"
    
        let url = URL(string: str)
        
        URLSession.shared.dataTask(with: url!) {[unowned self] (data, response, error) in
            if error == nil{
                do{
                    self.weatherArr = try JSONDecoder().decode(Youtube.self
                        , from: data!)
                    DispatchQueue.main.async {
                       //self.wheathertableView.reloadData()
                        print(self.weatherArr!.name)
                        self.nameLabel.text = self.weatherArr!.name
                        self.latLabel.text = String(self.weatherArr!.coord.lat)
                        self.lonLabel.text = String(self.weatherArr!.coord.lon)
                        self.disLabel.text = String(self.weatherArr!.main.humidity)
                
                    }
                }catch let error{
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }

}

/*extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let obj = weatherArr[indexPath.row]
        cell?.textLabel?.text = obj.base
        
        return cell!
    }
   
    
}*/
