//
//  Business.swift
//  revielicious
//
//  Created by Jaspal Singh on 14/11/22.
//

import Foundation

class BusinessModel {
    private var myDataTask: URLSessionDataTask?
    func updateBusinessData() {
        let api_url = "http://localhost:8000/api/business"
        
        if let url = URL(string: api_url) {
            let dataTask = URLSession.shared.dataTask(with: url){
                data, response, error in
                if let dataReceived = data {
                    let jsonString = String(data: dataReceived, encoding: .utf8)
            
                    do {
                        let json = try JSON(data: dataReceived)
                        let businessData = json["businesses"]
                    }
                    catch let error{
                        print("Failed to create json object \(error)")
                    }
                }
               
            }
            dataTask.resume()
        }
    }
    
    func fetchBusinessData(completion: @escaping (Result<BusinessData, Error>) -> Void) {
        let api_url = "http://localhost:8000/api/business"
        guard let url = URL(string: api_url) else {return}
        
        myDataTask = URLSession.shared.dataTask(with: url) {(data, response, error) in
            // Handle Error
            if let error = error {
                completion(.failure(error))
                print("Data task error \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Empty response")
                return
            }
            
            print("Response Code \(response.statusCode)")
            
            guard let data = data else {
                print("Empty Data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(BusinessData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        myDataTask?.resume()
    }
}

struct BusinessData: Decodable {
    let businesses: [Business]
    
    private enum CodingKeys: String, CodingKey {
        case businesses = "businesses"
    }
}

struct Business: Decodable {
    let name: String?
    let image_url: String?
    
    private enum CodingKeys: String, CodingKey {
        case name, image_url
    }
}
