//
//  DataLoader.swift
//  Homework14
//
//  Created by Bagrat Arutyunov on 06.07.2021.
//

import Foundation
import Alamofire

class DataLoader {
    
    static let shared: DataLoader = DataLoader()
    private let API_KEY = "15bd268399be175bd78bbdb25030a9ce"
    //http://api.openweathermap.org/data/2.5/forecast?q=Moscow&units=metric&lang=ru&appid=15bd268399be175bd78bbdb25030a9ce
    public func load(city: String, result: @escaping((RequestModel?) -> ())) {
        AF.request("http://api.openweathermap.org/data/2.5/forecast?q=\(city)&units=metric&lang=ru&appid=\(API_KEY)").responseDecodable(of: RequestModel.self) { response in
            result(response.value)
        }
    }
    
}
