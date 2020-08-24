//
//  Standing.swift
//  ForzaSheets
//
//  Created by Jordy De Tier on 24/08/2020.
//  Copyright © 2020 Jordy De Tier. All rights reserved.
//

import Foundation

struct GetStandingResponse: Codable{
    let api: StandingResponse
}

struct StandingResponse: Codable{
    let results: Int
    let standings: [[Standing]]
}

struct Standing: Codable{
    let rank: Int
    let team_id: Int
    let teamName: String
    let logo: String
    let group: String
    let forme: String
    let all: StandingMatches
    let goalsDiff: Int
    let points: Int
}

struct StandingMatches: Codable{
    let matchsPlayed: Int
    let win: Int
    let draw: Int
    let lose: Int
    let goalsFor: Int
    let goalsAgainst: Int
}
