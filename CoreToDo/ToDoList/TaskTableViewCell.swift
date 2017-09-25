//
//  TaskTableViewCell.swift
//  CoreToDo
//
//  Created by 小野寺 恵 on 2017/06/25.
//  Copyright © 2017年 derasan. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "TaskCell"
    
    // MARK: -
    
    @IBOutlet weak var taskLabel: UILabel!

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
