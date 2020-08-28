//
//  PlayersTableViewCell.swift
//  ForzaSheets
//
//  Created by Jordy De Tier on 26/08/2020.
//  Copyright © 2020 Jordy De Tier. All rights reserved.
//

import UIKit


class PlayersTableViewCell: UITableViewCell {
    
    @IBOutlet var position: UILabel!
    @IBOutlet var playerName: UILabel!
    @IBOutlet var nationality: UILabel!
    @IBOutlet var age: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
