//
//  SubdivTableViewCell2.swift
//  CoreToDo
//
//  Created by 小野寺 恵 on 2017/11/07.
//  Copyright © 2017年 derasan. All rights reserved.
//

import UIKit

class SubdivTableViewCell2: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "DetailTaskCell"
    
    // MARK: -
    
    @IBOutlet weak var subdivLabel2: UILabel!
    
    // MARK: - Initialization

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
