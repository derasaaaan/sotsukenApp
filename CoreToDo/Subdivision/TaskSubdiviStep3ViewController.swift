//
//  TaskSubdiviStep3ViewController.swift
//  CoreToDo
//
//  Created by 小野寺 恵 on 2017/09/25.
//  Copyright © 2017年 derasan. All rights reserved.
//

import UIKit
import CoreData

class TaskSubdiviStep3ViewController: UIViewController {

    @IBOutlet weak var subdivTableView3: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // taskCategories[]に格納されている文字列がTableViewのセクションになる
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
