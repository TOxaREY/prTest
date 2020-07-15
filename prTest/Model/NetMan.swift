//
//  NetMan.swift
//  prTest
//
//  Created by REYNIKOV ANTON on 14.07.2020.
//  Copyright © 2020 REYNIKOV ANTON. All rights reserved.
//

import Foundation

class NetMan {
    
    func request(completion: @escaping (Prjson) -> Void)  {
        guard let url = URL(string: "https://pryaniky.com/static/json/sample.json".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!) else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
                let prjson = try JSONDecoder().decode(Prjson.self, from: data)
                completion(prjson)
            } catch let jsonError {
                print(jsonError)
            }
        }
        task.resume()
    }
}
