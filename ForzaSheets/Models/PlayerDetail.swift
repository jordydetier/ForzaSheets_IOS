//
//  PlayerDetail.swift
//  ForzaSheets
//
//  Created by Jordy De Tier on 26/08/2020.
//  Copyright © 2020 Jordy De Tier. All rights reserved.
//

import Foundation

struct GetPlayerDetailResponse: Codable{
    let api: PlayerDetailResponse
}

struct PlayerDetailResponse: Codable{
    let results: Int
    let players: [PlayerDetail]
}

struct PlayerDetail: Codable{
    let player_id: Int
    let firstname: String
    let lastname: String
    let position: String?
    let age: Int
    let birth_date: String
    let nationality: String
    let height: String?
    let weight: String?
    let goals: Goals
    let cards: Cards
    let games: Games
}

struct Goals: Codable {
    let total: Int
    let conceded: Int
    let assists: Int
    let saves: Int
}

struct Cards: Codable {
    let yellow: Int
    let red: Int
}

struct Games: Codable {
    let appearences: Int
    let minutes_played: Int
}

