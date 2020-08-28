//
//  TeamDetailsManager.swift
//  ForzaSheets
//
//  Created by Jordy De Tier on 25/08/2020.
//  Copyright © 2020 Jordy De Tier. All rights reserved.
//

import Foundation

protocol TeamDetailsManagerDelegate {
    func updateTeamDetails(_ teamDetailsManager: TeamDetailsManager, _ getTeamDetailsResponse: GetTeamResponse)
    func updatePlayers(_ teamDetailsManager: TeamDetailsManager, _ getPlayerTeamResponse: GetPlayerTeamResponse)
    func didFail(with error: Error)
}


struct TeamDetailsManager {
    
    let url = "https://v2.api-football.com/"
    let API_KEY = "1ab22aab615c428e280d25f31d9f4e68"
    
    var delegate: TeamDetailsManagerDelegate?
    
    func getTeamDetails(teamId: Int) {
        let urlString = "\(url)teams/team/\(teamId)"
        performGetRequest(with: urlString) {data, response, error in
            if error != nil {
                self.delegate?.didFail(with: error!)
                return
            }
            if let safeData = data{
                let decoder = JSONDecoder()
                do {
                    let decodedContainer = try decoder.decode(GetTeamResponse.self, from: safeData)
                    self.delegate?.updateTeamDetails(self, decodedContainer)
                } catch {
                    self.delegate?.didFail(with: error)
                }
            }
        }
    }
    
    func getPlayers(teamId: Int) {
        let urlString = "\(url)players/squad/\(teamId)/2019-2020"
        performGetRequest(with: urlString) {data, response, error in
            if error != nil {
                self.delegate?.didFail(with: error!)
                return
            }
            if let safeData = data{
                let decoder = JSONDecoder()
                do {
                    let decodedContainer = try decoder.decode(GetPlayerTeamResponse.self, from: safeData)
                    self.delegate?.updatePlayers(self, decodedContainer)
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
