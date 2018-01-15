//
//  SubdivTableViewCell3.swift
//  CoreToDo
//
//  Created by 小野寺 恵 on 2018/01/15.
//  Copyright © 2018年 derasan. All rights reserved.
//

import UIKit

class SubdivTableViewCell3: UITableViewCell {

    // MARK: - Properties
    
    static let reuseIdentifier = "DetailPartTaskCell"
    
    // MARK: -

    @IBOutlet weak var subdivLabel3: UILabel!

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
