//
//  ViewController.swift
//  ForzaSheets
//
//  Created by Jordy De Tier on 12/08/2020.
//  Copyright © 2020 Jordy De Tier. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var premierLeagueButton : UIButton!
    @IBOutlet var bundesligaButton : UIButton!
    @IBOutlet var ligue1button : UIButton!
    @IBOutlet var laLigaButton : UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapPremierLeagueButton(){
        guard let vc = storyboard?.instantiateViewController(identifier: "standingsPremierLeague") as? StandingsViewController else {
            return
        }
  
        vc.title = "Standings"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapLigue1LeagueButton(){
          guard let vc = storyboard?.instantiateViewController(identifier: "standingsLigue1") as? StandingsViewController else {
              return
          }
    
          vc.title = "Standings"
          vc.navigationItem.largeTitleDisplayMode = .never
          navigationController?.pushViewController(vc, animated: true)
      }
      @IBAction func didTapBundesligaLeagueButton(){
          guard let vc = storyboard?.instantiateViewController(identifier: "standingsBundesliga") as? StandingsViewController else {
              return
          }
    
          vc.title = "Standings"
          vc.navigationItem.largeTitleDisplayMode = .never
          navigationController?.pushViewController(vc, animated: true)
      }
      @IBAction func didTapLaLigaLeagueButton(){
          guard let vc = storyboard?.instantiateViewController(identifier: "standingsLaLiga") as? StandingsViewController else {
              return
          }
    
          vc.title = "Standings"
          vc.navigationItem.largeTitleDisplayMode = .never
          navigationController?.pushViewController(vc, animated: true)
      }
    

    
}

