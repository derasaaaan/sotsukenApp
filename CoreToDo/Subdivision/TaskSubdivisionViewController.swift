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
    var tasksToShow:[String] = ["ToDo"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        subdivTableView.dataSource = self
        subdivTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // CoreDataからデータをfetchしてくる
//        getData()
        
        // taskTableViewを再読み込みする
        subdivTableView.reloadData()
    }

    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationViewController = segue.destination as? SubdivAddTaskViewController else { return }
        
        // contextをAddTaskViewController.swiftのcontextへ渡す
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        destinationViewController.context = context
        if let indexPath = subdivTableView.indexPathForSelectedRow, segue.identifier == segueEditTaskSubdivViewController{
            // 編集したいデータのcategoryとnameを取得
            let editedName = tasksToShow[indexPath.row]
            // 先ほど取得したcategoryとnameに合致するデータのみをfetchするようにfetchRequestを作成
            let fetchRequest: NSFetchRequest<SubdivTask> = SubdivTask.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name = %@", editedName)
            // そのfetchRequestを満たすデータをfetchしてtask(配列だが要素を一種類しか持たないはず)に代入し、それを渡す
            do {
                let task = try context.fetch(fetchRequest)
                destinationViewController.task = task[0]
            } catch {
                print("Fetching Failed.")
            }
        }
    }
    
    // MARK: - Method of Getting data from Core Data
    
//    func getData() {
//        // データ保存時と同様にcontextを定義
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        do {
//            // CoreDataからデータをfetchしてtasksに格納
//            let fetchRequest: NSFetchRequest<SubdivTask> = SubdivTask.fetchRequest()
//            tasks = try context.fetch(fetchRequest)
//
//            // tasksToShow配列を空にする。（同じデータを複数表示しないため）
//            for key in tasksToShow.keys {
//                tasksToShow[key] = []
//            }
//            // 先ほどfetchしたデータをtasksToShow配列に格納する
//            for task in tasks {
//                tasksToShow[task.name!]
//            }
//        } catch {
//            print("Fetching Failed.")
//        }
//    }
    
    
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
