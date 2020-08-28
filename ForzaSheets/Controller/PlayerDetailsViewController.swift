//
//  PlayerDetailsViewController.swift
//  ForzaSheets
//
//  Created by Jordy De Tier on 12/08/2020.
//  Copyright © 2020 Jordy De Tier. All rights reserved.
//

import UIKit

class PlayerDetailsViewController: UIViewController, PlayerDetailsManagerDelegate {
    
    @IBOutlet var firstName: UILabel!
    @IBOutlet var lastName: UILabel!
    @IBOutlet var nationality: UILabel!
    @IBOutlet var position: UILabel!
    @IBOutlet var height: UILabel!
    @IBOutlet var weight: UILabel!
    @IBOutlet var dateOfBirth: UILabel!
    @IBOutlet var age: UILabel!
    @IBOutlet var goals: UILabel!
    @IBOutlet var goalsLabel: UILabel!
    @IBOutlet var assists: UILabel!
    @IBOutlet var assistsLabel: UILabel!
    @IBOutlet var yellowCards: UILabel!
    @IBOutlet var redCards: UILabel!
    @IBOutlet var appearances: UILabel!
    @IBOutlet var minutesPlayed: UILabel!
    @IBOutlet var teamLogo: UIImageView!
    
    private var networkManager: PlayerDetailsManager = PlayerDetailsManager()
    var playerId:Int?
    var teamLogoString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let playerId = self.playerId{
            networkManager.delegate = self
            networkManager.getPlayerDetails(playerId: playerId)
        }
        // Do any additional setup after loading the view.
    }
    
    func updatePlayer(_ playerDetailsManager: PlayerDetailsManager, _ getPlayerDetailResponse: GetPlayerDetailResponse) {
        let player = getPlayerDetailResponse.api.players[0]
        DispatchQueue.main.async {
            DispatchQueue.global(qos: .background).async {
                           do
                           {
                            let data = try Data.init(contentsOf: URL.init(string: self.teamLogoString!)!)
                               DispatchQueue.main.async {
                                   let teamCrest: UIImage = UIImage(data: data)!
                                   self.teamLogo.image = teamCrest
                               }
                           }
                           catch {
                               print("Error while loading Logo")
                           }
                       }
            self.firstName.text = player.firstname
            self.lastName.text = player.lastname
            self.nationality.text = player.nationality
            self.position.text = player.position
            if (player.height != nil){
                self.height.text = player.height
            }else{
                self.height.text = "No Data"
            }
            if (player.weight != nil){
                self.weight.text = player.weight
            }else{
                self.weight.text = "No Data"
            }
            self.dateOfBirth.text = player.birth_date
            self.age.text = String(player.age)
            switch player.position {
            case "Goalkeeper":
                self.goals.text = String(player.goals.saves)
                self.goalsLabel.text = "saves"
                self.assists.text = String(player.goals.conceded)
                self.assistsLabel.text = "conceded"
            default:
                self.goals.text = String(player.goals.total)
                self.assists.text = String(player.goals.assists)
            }
            self.yellowCards.text = String(player.cards.yellow)
            self.redCards.text = String(player.cards.red)
            self.appearances.text = String(player.games.appearences)
            self.minutesPlayed.text = String(player.games.minutes_played)
        }
    }
    func didFail(with error: Error) {
        print("---DIDFAIL WITH ERROR @ PLAYERDETAILSVIEW", error.localizedDescription, error)
    }
}
