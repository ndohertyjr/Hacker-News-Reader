//
//  NetworkManager.swift
//  Hacker News Reader
//
//  Created by user220431 on 7/28/22.
//

import Foundation

class NetworkManager: ObservableObject {
    
    let session = URLSession(configuration: .default)
    @Published var posts = [Post]()
    
    func fetchNewStories() {
        if let url = URL(string: "https://hn.algolia.com/api/v1/search_by_date?tags=story") {
            sendRequest(for: url)
        } else {
            print("Error sending request for https://hn.algolia.com/api/v1/search_by_date?tags=story")
        }
    }
    
    func fetchFrontPageStories() {
        if let url = URL(string: "https://hn.algolia.com/api/v1/search?tags=front_page") {
            sendRequest(for: url)
        } else {
            print("Error trying to begin request for https://hn.algolia.com/api/v1/search?tags=front_page")
        }
    }
    
    func sendRequest(for url: URL) {
        let task = session.dataTask(with: url) { (data, response, error) in
            if error == nil {
                guard data != nil else {
                    print("No data found for URL: \(url)")
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    print("Attempting to decode \(data)")
                    let result = try decoder.decode(Results.self, from: data!)
                    print("Decoded!!!")
                    DispatchQueue.main.async {
                        self.posts = result.hits
                    }
                    
                } catch {
                    print("Error occured while decoding. Error \(error)")
                }
                
            } else {
                print("Error received when requesting data from URL: \(url)")
                print("Error: \(error!)")
            }
            
        }
        task.resume()
    }
}
