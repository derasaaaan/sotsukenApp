//
//  TaskSubdivisionViewController.swift
//  CoreToDo
//
//  Created by 小野寺 恵 on 2017/09/25.
//  Copyright © 2017年 derasan. All rights reserved.
//

import UIKit
import CoreData

class TaskSubdivisionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var subdivTableView: UITableView!
    
    // MARK: - Properties for table view
    
    private let segueEditTaskSubdivViewController = "SegueEditTaskSubdivViewController"
    
    var tasks:[SubdivTask] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        subdivTableView.dataSource = self
        subdivTableView.delegate = self
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = subdivTableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.reuseIdentifier, for: indexPath) as? TaskTableViewCell else{
            fatalError("Unexpected Index Path")
        }
        
        //TODO: - sectionData,CellDataの書き込み
        
        return cell
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
