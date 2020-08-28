//
//  TeamDetailsViewController.swift
//  ForzaSheets
//
//  Created by Jordy De Tier on 12/08/2020.
//  Copyright © 2020 Jordy De Tier. All rights reserved.
//

import UIKit

class TeamDetailsViewController: UIViewController, TeamDetailsManagerDelegate {
    
    @IBOutlet var founded: UILabel!
    @IBOutlet var teamName: UILabel!
    @IBOutlet var country: UILabel!
    @IBOutlet var teamLogo: UIImageView!
    @IBOutlet var venueCity: UILabel!
    @IBOutlet var venueName: UILabel!
    @IBOutlet var venueCapacity: UILabel!
    @IBOutlet var playersTableView: UITableView!
    private var networkManager: TeamDetailsManager = TeamDetailsManager()
    var teamId:Int?
    var team: Team?
    var players: [PlayerTeam] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let teamId = self.teamId{
            self.playersTableView.rowHeight = 44
            playersTableView.delegate = self
            playersTableView.dataSource = self
            playersTableView.register(UINib(nibName: "PlayersTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusablePlayersCell")
            networkManager.delegate = self
            networkManager.getTeamDetails(teamId: teamId)
            networkManager.getPlayers(teamId: teamId)
        }
    }
    
    func updateTeamDetails(_ teamDetailsManager: TeamDetailsManager, _ getTeamDetailsResponse: GetTeamResponse) {
        self.team = getTeamDetailsResponse.api.teams[0]
        DispatchQueue.main.async {
            DispatchQueue.global(qos: .background).async {
                do
                {
                    let data = try Data.init(contentsOf: URL.init(string: self.team!.logo)!)
                    DispatchQueue.main.async {
                        let teamCrest: UIImage = UIImage(data: data)!
                        self.teamLogo.image = teamCrest
                    }
                }
                catch {
                    print("Error while loading Logo")
                }
            }
            self.founded.text = String(self.team!.founded)
            self.teamName.text = self.team!.name
            self.country.text = self.team!.country
            if (self.team!.venue_name != nil){
                self.venueName.text = self.team!.venue_name
            }else{
                self.venueName.text = "No Data"
            }
            if (self.team!.venue_city != nil){
                self.venueCity.text = self.team!.venue_city
            }else{
                self.venueCity.text = "No Data"
            }
            if (self.team!.venue_capacity != nil){
                let teamCap = self.team!.venue_capacity!
                self.venueCapacity.text = String(teamCap)
            }else{
                self.venueCapacity.text = "No Data"
            }
        }
    }
    
    func updatePlayers(_ teamDetailsManager: TeamDetailsManager, _ getPlayerTeamResponse: GetPlayerTeamResponse) {
        
        self.players = getPlayerTeamResponse.api.players.sorted{ (player1, player2) -> Bool in
            var player1number = 0
            var player2number = 0
            switch player1.position {
            case "Goalkeeper":
                player1number = 1
            case "Defender":
                player1number = 2
            case "Midfielder":
                player1number = 3
            case "Attacker":
                player1number = 4
            default:
                player1number = 0
            }
            switch player2.position {
            case "Goalkeeper":
                player2number = 1
            case "Defender":
                player2number = 2
            case "Midfielder":
                player2number = 3
            case "Attacker":
                player2number = 4
            default:
                player2number = 0
            }
            
            return player1number < player2number
        }
        DispatchQueue.main.async {
            self.playersTableView.reloadData()
        }
    }
    
    func didFail(with error: Error) {
        print("---DIDFAIL WITH ERROR @ TEAMDETAILSVIEW", error.localizedDescription, error)
    }
    
}

extension TeamDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ playersTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ playersTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = playersTableView.dequeueReusableCell(withIdentifier: "ReusablePlayersCell", for: indexPath) as! PlayersTableViewCell
        let player: PlayerTeam = players[indexPath.row]
        switch player.position {
        case "Goalkeeper":
            cell.position.text = "GK"
        case "Defender":
            cell.position.text = "DEF"
        case "Midfielder":
            cell.position.text = "MID"
        case "Attacker":
            cell.position.text = "ATT"
        default:
            cell.position.text = "No Data"
        }
        cell.playerName.text = player.player_name
        cell.nationality.text = player.nationality
        cell.age.text = String(player.age)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPlayerDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PlayerDetailsViewController{
            destination.playerId = players[playersTableView.indexPathForSelectedRow!.row].player_id
            destination.teamLogoString = team?.logo
        }
    }
}


