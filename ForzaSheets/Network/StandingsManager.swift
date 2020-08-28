//
//  ApiManager.swift
//  ForzaSheets
//
//  Created by Jordy De Tier on 24/08/2020.
//  Copyright © 2020 Jordy De Tier. All rights reserved.
//

import Foundation

protocol StandingsManagerDelegate{
    func updateStandings(_ standingsManager: StandingsManager, _ getStandingsResponse: GetStandingResponse)
    func didFail(with error: Error)
}

struct StandingsManager{
    
    let url = "https://v2.api-football.com/"
    let API_KEY = "1ab22aab615c428e280d25f31d9f4e68"
    
    var delegate: StandingsManagerDelegate?
    
    func getStandings(leagueId: Int) {
        let urlString = "\(url)leagueTable/\(leagueId)"
        performGetRequest(with: urlString) {data, response, error in
            if error != nil {
                self.delegate?.didFail(with: error!)
                return
            }
            if let safeData = data{
                let decoder = JSONDecoder()
                do {
                    let decodedContainer = try decoder.decode(GetStandingResponse.self, from: safeData)
                    self.delegate?.updateStandings(self, decodedContainer)
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
