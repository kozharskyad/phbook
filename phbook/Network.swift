//
//  Network.swift
//  phbook
//
//  Created by Alexander Kozharsky on 21.01.17.
//  Copyright © 2017 Alexander Kozharsky. All rights reserved.
//

import Alamofire
import ObjectMapper

/** Network controller */
class Network {
    //MARK: Public properties
    static let shared = Network()
    static var apiUrl: String {
        get {
            if UserDefaults.standard.bool(forKey: "serverState") {
                return "http://192.168.1.66:3000/api/"
            } else {
                return "http://92.43.0.71:8080/api/"
            }
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "serverState")
        }
    }
    
    //MARK: Public class methods
    /**
     Network request
     - Parameter apiCommand: API command to execute
     - Parameter model: Model type for JSON response
     - Parameter method: HTTP response method
     - Parameter parameters: JSON dictionary for send
     - Parameter completion: Completion closure contains 3 parameters:
     - Parameter completion #1: JSON response string
     - Parameter completion #2: Array of requested models
     - Parameter completion #3: Error object contains network request error
    */
    class func request<T: Mappable>(apiCommand: String, model: T.Type, method: HTTPMethod = .get, parameters: Parameters = [:], completion: @escaping ((String?, [T]?, Error?) -> Void)) -> Request {
        let url = "\(self.apiUrl)\(apiCommand)"
        let request = Alamofire.request(url, method: method, parameters: parameters, encoding: method == .get ? URLEncoding.default : JSONEncoding.default)
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .failure(let error):
                    completion(nil, nil, error)
                case .success(let value):
                    if let json = value as? [[String: Any]] {
                        guard let jsonData = try? JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions()), let jsonString = String(data: jsonData, encoding: .utf8) else {
                            completion(nil, nil, nil)
                            return
                        }
                        
                        var retArray: [T] = []
                        
                        for dict in json {
                            if let mod = model.init(JSON: dict) as T! {
                                retArray.append(mod)
                            }
                        }
                        
                        completion(jsonString, retArray, nil)
                    } else if let json = value as? [String: Any] {
                        guard let jsonData = try? JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions()), let jsonString = String(data: jsonData, encoding: .utf8) else {
                            completion(nil, nil, nil)
                            return
                        }
                        
                        if let mod = model.init(JSON: json) as T! {
                            completion(jsonString, [mod], nil)
                        } else {
                            completion(nil, nil, nil)
                        }
                    }
                }
            })
        return request
    }
}
