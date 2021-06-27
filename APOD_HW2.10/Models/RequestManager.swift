//
//  RequestManager.swift
//  APOD_HW2.10
//
//  Created by Дарья Яровая on 25.06.2021.
//

import Foundation

protocol MainRequestManagerDelegate {
    func didUpdateData(responseData: ResponseData)
    func didGetError(isError: Bool)
}

protocol ImageRequestManagerDelegate {
    func didUpdateImage(image: Data)
}

struct RequestManager {
    let apiUrl = "https://api.nasa.gov/planetary/apod"
    let apiKey = "DEMO_KEY"
    var mainRequestManagerDelegate: MainRequestManagerDelegate?
    var imageRequestManagerDelegate: ImageRequestManagerDelegate?
    
    
    func fetchMainRequest(date: String) {
        let urlString = "\(apiUrl)?date=\(date)&api_key=\(apiKey)"
        perfomeMainRequest(urlString: urlString)
    }
    
    func perfomeMainRequest(urlString: String) {
        if let url = URL(string: urlString) {
            //Create a URLSession
            let session = URLSession(configuration: .default)
            let request = URLRequest(url: url)
            
            //Give the session a task
            let task = session.dataTask(with: request) { (data, response, error) in
                if error != nil {
                    print(error!)
                    self.mainRequestManagerDelegate?.didGetError(isError: true)
                    return
                }
                if let safeData = data {
                    if let response = self.parseJSON(data: safeData) {
                        self.mainRequestManagerDelegate?.didUpdateData(responseData: response)
                    }
                }
                
            }
            task.resume()
        }
    }
    
    func fetchImage(url: String) {
        guard let url = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("error \(error)")
                self.mainRequestManagerDelegate?.didGetError(isError: true)
                return
            }
            
            if let response = response {
                print("response\(response)")
            }
            
            if let data = data {
                print("data \(data)")
                self.imageRequestManagerDelegate?.didUpdateImage(image: data)
            }
        }.resume()
    }
    
    func parseJSON(data: Data) -> ResponseData? {
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ResponseData.self, from: data)
            return ResponseData(date: decodedData.date, media_type: decodedData.media_type, service_version: decodedData.service_version, title: decodedData.title, explanation: decodedData.explanation, url: decodedData.url, hdurl: decodedData.hdurl)
        } catch{
            self.mainRequestManagerDelegate?.didGetError(isError: true)
            return nil
        }
    }
}
