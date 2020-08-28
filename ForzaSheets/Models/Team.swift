//
//  Team.swift
//  ForzaSheets
//
//  Created by Jordy De Tier on 24/08/2020.
//  Copyright © 2020 Jordy De Tier. All rights reserved.
//

import Foundation

struct GetTeamResponse: Codable {
    let api : TeamResponse
}

struct TeamResponse: Codable{
    let results : Int
    let teams : [Team]
}

struct Team: Codable{
    let team_id : Int
    let name : String
    let logo : String
    let country : String
    let founded : Int
    let venue_name : String?
    let venue_city : String?
    let venue_capacity: Int?
}
