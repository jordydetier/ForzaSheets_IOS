//
//  StandingsViewController.swift
//  ForzaSheets
//
//  Created by Jordy De Tier on 12/08/2020.
//  Copyright © 2020 Jordy De Tier. All rights reserved.
//

import UIKit

class StandingsViewController: UIViewController, NetworkManagerDelegate{
    
    private var standings: [Standing] = []
    private var networkManager: NetworkManager = NetworkManager()
    @IBOutlet var leagueName: UILabel!
    @IBOutlet var seasonInfo: UILabel!
    @IBOutlet var standingsTableView: UITableView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let standingMatches = StandingMatches(matchsPlayed: 38, win: 32, draw: 3, lose: 3, goalsFor: 85, goalsAgainst: 33)
//        let standing = Standing(rank: 1, team_id: 40, teamName: "Manchester United", logo: "https://media.api-sports.io/football/teams/40.png", group: "Premier League", goalDiff: 52, points: 99, all: standingMatches)
//        standings.append(standing)
//        standings.append(standing)
//        standings.append(standing)
        standingsTableView.dataSource = self
        standingsTableView.register(UINib(nibName: "StandingsTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableStandingsCell")
        networkManager.delegate = self
        networkManager.getStandings()
        // Do any additional setup after loading the view.
    }
    
    func updateStandings(_ networkManager: NetworkManager, _ getStandingsResponse: GetStandingResponse) {
        self.standings = getStandingsResponse.api.standings[0]
        DispatchQueue.main.async {
            self.standingsTableView.reloadData()
        }
    }
    
    func didFail(with error: Error) {
        print("---DIDFAIL WITH ERROR @ STANDINGSVIEW", error.localizedDescription, error)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension StandingsViewController: UITableViewDataSource {
    func tableView(_ standingsTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return standings.count
    }
    
    func tableView(_ standingsTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = standingsTableView.dequeueReusableCell(withIdentifier: "ReusableStandingsCell", for: indexPath) as! StandingsTableViewCell
        let standing: Standing = standings[indexPath.row]
        DispatchQueue.global(qos: .background).async {
               do
                {
                    let data = try Data.init(contentsOf: URL.init(string: standing.logo)!)
                      DispatchQueue.main.async {
                        let teamCrest: UIImage = UIImage(data: data)!

                        cell.teamLogo.image = teamCrest
                      }
                }
               catch {
                      print("Error while loading Logo")
                     }
        }
        cell.ranking.text = String(standing.rank)
        cell.teamName.text = standing.teamName
        cell.matchesPlayed.text = String(standing.all.matchsPlayed)
        cell.matchesWon.text = String(standing.all.win)
        cell.matchesDrawn.text = String(standing.all.draw)
        cell.matchesLost.text = String(standing.all.lose)
        cell.goalDiff.text = String(standing.goalsDiff)
        cell.points.text = String(standing.points)
        return cell
    }

    
    
}


