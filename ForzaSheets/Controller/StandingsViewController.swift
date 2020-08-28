//
//  StandingsViewController.swift
//  ForzaSheets
//
//  Created by Jordy De Tier on 12/08/2020.
//  Copyright © 2020 Jordy De Tier. All rights reserved.
//

import UIKit

class StandingsViewController: UIViewController, StandingsManagerDelegate {
    
    var leagueId: Int = 0
    private var standings: [Standing] = []
    private var networkManager: StandingsManager = StandingsManager()
    @IBOutlet var leagueName: UILabel!
    @IBOutlet var seasonInfo: UILabel!
    @IBOutlet var standingsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.standingsTableView.rowHeight = 44
        standingsTableView.delegate = self
        standingsTableView.dataSource = self
        standingsTableView.register(UINib(nibName: "StandingsTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableStandingsCell")
        networkManager.delegate = self
        switch tabBarController?.selectedIndex {
        case 0:
            self.leagueId = 754
        case 1:
            self.leagueId = 775
        case 3:
            self.leagueId = 524
        case 4:
            self.leagueId = 525
        default:
            self.leagueId = 524
        }
        networkManager.getStandings(leagueId: self.leagueId)
    }
    
    func updateStandings(_ standingsManager: StandingsManager, _ getStandingsResponse: GetStandingResponse) {
        self.standings = getStandingsResponse.api.standings[0]
        DispatchQueue.main.async {
            self.standingsTableView.reloadData()
        }
    }
    
    func didFail(with error: Error) {
        print("---DIDFAIL WITH ERROR @ STANDINGSVIEW", error.localizedDescription, error)
    }
}

extension StandingsViewController: UITableViewDataSource, UITableViewDelegate {
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showTeamDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? TeamDetailsViewController{
            destination.teamId = standings[standingsTableView.indexPathForSelectedRow!.row].team_id
        }
    }
}

