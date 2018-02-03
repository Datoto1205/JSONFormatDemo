//
//  ViewController.swift
//  JSONFormatDemo
//
//  Created by Frank.Chen on 2017/9/15.
//  Copyright © 2017年 frank.chen. All rights reserved.
//

import UIKit

struct JSONData: Codable {
    var result: Meteorological
    
    struct Meteorological: Codable {
        var count: Double
        var limit: Double
        var offset: Double
        var results: [Result]
        var sort: String
    }
    
    struct Result: Codable {
        var _id: String
        var endTime: String
        var locationName: String
        var parameterName1: String
        var parameterName2: String
        var parameterName3: String
        var parameterUnit2: String
        var parameterUnit3: String
        var parameterValue1: String
        var startTime: String
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=e6831708-02b4-4ef8-98fa-4b4ce53459d9")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response , error) in
            let decoder = JSONDecoder()
            
            if let data = data, let dataList = try? decoder.decode(JSONData.self, from: data) {
                
                print("count: \(dataList.result.count)") // 總比數
                print("limit: \(dataList.result.limit)") // 限制比數
                print("offset: \(dataList.result.offset)") // 抵銷
                print("sort: \(dataList.result.sort)") // 排序
                print("")
                
                // 一週氣象資訊
                for result in dataList.result.results {
                    print("result: \(result)")
                    print("")
                }
            } else {
                print("Error...")
            }
        }
        
        task.resume()
    }

}

