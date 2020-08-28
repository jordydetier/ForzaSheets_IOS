//
//  File.swift
//  ForzaSheets
//
//  Created by Jordy De Tier on 24/08/2020.
//  Copyright © 2020 Jordy De Tier. All rights reserved.
//

import UIKit


class StandingsTableViewCell: UITableViewCell {
    
    @IBOutlet var ranking: UILabel!
    @IBOutlet var teamLogo: UIImageView!
    @IBOutlet var teamName: UILabel!
    @IBOutlet var matchesPlayed: UILabel!
    @IBOutlet var matchesWon: UILabel!
    @IBOutlet var matchesDrawn: UILabel!
    @IBOutlet var matchesLost: UILabel!
    @IBOutlet var goalDiff: UILabel!
    @IBOutlet var points: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
