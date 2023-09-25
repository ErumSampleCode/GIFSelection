//
//  ServiceClass.swift
//  GIFSelection
//
//  Created by Erum Naz on 22/09/23.
//

import Foundation

public class GifService {
    // Used different logics such as async await and normal escaping closure for api calls to show that latest
    
    let apiKey = "zMTHmMoS0UsJv4mP8d2RorDDmUIXO4co"
    
    func poTrendingData() async throws -> [Gif] {
        let session = URLSession.shared
        let serviceurl = URL(string: "https://api.giphy.com/v1/gifs/trending?api_key=\(apiKey)")!
        do {
            let (data, response) = try await session.data(from: serviceurl)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { return []}
            let jsonData = try JSONSerialization.jsonObject(with: data)
                print(jsonData)
            let decoder = JSONDecoder()
            let  decodedResponse = try decoder.decode(GifArray.self, from: data)
           // print(decodedResponse.data!)
            return decodedResponse.gifs
          
        } catch let error {
            throw error
        }
    }
    
    func fetchGifs(searchTerm: String, completion: @escaping (_ response: GifArray?) -> Void) {
        // Create a GET url request
        let url = URL(string: "https://api.giphy.com/v1/gifs/search?api_key=\(apiKey)&q=\(searchTerm)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error {
                print("Error fetching from Giphy: ", err.localizedDescription)
            }
            do {
                // Decode the data into array of Gifs
                DispatchQueue.main.async {
                    let object = try! JSONDecoder().decode(GifArray.self, from: data!)
                    completion(object)
                }
            }
        }.resume()
    }
}

