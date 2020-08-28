//
//  PlayerTeam.swift
//  ForzaSheets
//
//  Created by Jordy De Tier on 26/08/2020.
//  Copyright © 2020 Jordy De Tier. All rights reserved.
//

import Foundation

struct GetPlayerTeamResponse: Codable{
    let api: PlayerTeamResponse
}

struct PlayerTeamResponse: Codable{
    let results: Int
    let players: [PlayerTeam]
}

struct PlayerTeam: Codable{
    let player_id: Int
    let player_name: String
    let position: String?
    let age: Int
    let nationality: String
}
