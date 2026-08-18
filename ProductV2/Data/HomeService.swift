//
//  HomeService.swift
//  ProductV2
//
//  Created by Design on 17/8/26.
//

import Foundation

final class HomeService {
    static let shared = HomeService()

    func fetchSections(completion: @escaping ([HomeSection]) -> Void) {
        let urlString = "\(APIConfig.baseURL)/prerelease/api/v2/pages/homepage/layout?platform=mobile&locale=en"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion([])
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            // THIS block finally executes now, whenever the response arrives
            guard let data = data else {
                print(" No data:", error?.localizedDescription ?? "unknown error")
                completion([])
                return
            }

            // ── STEP 2: Try to decode the raw data into your Swift model ──
           do {
               let decoded = try JSONDecoder().decode(HomeResponse.self, from: data)
               let sections = decoded.data?.sections ?? []
               
               // ── STEP 4: Send the result back to whoever called fetchSections ──
               completion(sections)
                   
            } catch {
                print(" Decode error:", error)
                completion([])
            }
        }.resume() // sent request 
    }
        
    func debugFetchSliderRaw(hydrateURL: String) {
            let fullURL = "\(APIConfig.baseURL)\(hydrateURL)"
            guard let url = URL(string: fullURL) else {
                print(" Invalid Slider URL")
                return
            }

            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    print("No data:", error?.localizedDescription ?? "unknown error")
                    return
                }
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Slider raw JSON:\n\(jsonString)")
                }
            }.resume()
        }
    
    func fetchSliderItems(hydrateURL: String, completion: @escaping ([SliderItem]) -> Void) {
        let fullURL = "\(APIConfig.baseURL)\(hydrateURL)"
        guard let url = URL(string: fullURL) else {
            completion([])
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion([])
                return
            }
            do {
                // adjust this decode target once we see the real JSON shape
                let decoded = try JSONDecoder().decode(SliderHydrateResponse.self, from: data)
                completion(decoded.data?.items ?? [])
            } catch {
                print(" Slider decode error:", error)
                completion([])
            }
        }.resume()
    }
    
    // deal item
    
    func fetchDeal(
        completion: @escaping (Result<HomeResponse, Error>) -> Void){
        let urlString = "\(APIConfig.baseURL)/pages/homepage/sections/shared.deal-of-the-week-selections/103?platform=mobile&locale=en"
        guard let url = URL(string: urlString) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                
                let homeResponse = try decoder.decode(
                    HomeResponse.self,
                    from: data
                )
                
                completion(.success(homeResponse))
                
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
}
