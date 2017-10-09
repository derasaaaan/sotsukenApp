//
//  SubdivTableViewCell1.swift
//  CoreToDo
//
//  Created by 小野寺 恵 on 2017/10/06.
//  Copyright © 2017年 derasan. All rights reserved.
//

import UIKit

class SubdivTableViewCell1: UITableViewCell {

    // MARK: - Properties
    
    static let reuseItentifier = "MainTaskCell"
    
    // MARK: -
    
    @IBOutlet weak var subdivLabel1: UILabel!
    
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
