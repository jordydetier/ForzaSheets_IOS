//
//  PlayerDetailsManager.swift
//  ForzaSheets
//
//  Created by Jordy De Tier on 26/08/2020.
//  Copyright © 2020 Jordy De Tier. All rights reserved.
//

import Foundation


protocol PlayerDetailsManagerDelegate{
    func updatePlayer(_ playerDetailsManager: PlayerDetailsManager, _ getPlayerDetailResponse: GetPlayerDetailResponse)
    func didFail(with error: Error)
}

struct PlayerDetailsManager{
    
    let url = "https://v2.api-football.com/"
    let API_KEY = "1ab22aab615c428e280d25f31d9f4e68"
    
    var delegate: PlayerDetailsManagerDelegate?
    
    func getPlayerDetails(playerId: Int) {
        let urlString = "\(url)players/player/\(playerId)/2019-2020"
        performGetRequest(with: urlString) {data, response, error in
            if error != nil {
                self.delegate?.didFail(with: error!)
                return
            }
            if let safeData = data{
                let decoder = JSONDecoder()
                do {
                    let decodedContainer = try decoder.decode(GetPlayerDetailResponse.self, from: safeData)
                    self.delegate?.updatePlayer(self, decodedContainer)
                } catch {
                    self.delegate?.didFail(with: error)
                }
            }
        }
    }
    
    
    private func performGetRequest(with urlString: String, onCompletionCallback: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.setValue(API_KEY, forHTTPHeaderField: "X-RapidAPI-Key")
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request, completionHandler: onCompletionCallback)
            task.resume()
        }
    }
    
    
}
