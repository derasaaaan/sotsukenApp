//
//  ViewController.swift
//  CoreToDo
//
//  Created by 小野寺 恵 on 2017/06/21.
//  Copyright © 2017年 derasan. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var taskTableView: UITableView!
    
    @IBAction func tapMenu(_ sender: Any) {
        sideMenuCall()
    }
    
    func sideMenuCall(){
        self.performSegue(withIdentifier: "sideMenuSegue", sender:nil )
    }
    
    
    // MARK: - Properties for table view
    
    private let segueEditTaskViewController = "SegueEditTaskViewController"
    
    var tasks:[Task] = []
    var tasksToShow:[String:[String]] = ["ToDo":[], "Shopping":[], "Assignment":[]]
    let taskCategories:[String] = ["ToDo", "Shopping", "Assignment"]
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        taskTableView.dataSource = self
        taskTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // CoreDataからデータをfetchしてくる
        getData()
        
        // taskTableViewを再読み込みする
        taskTableView.reloadData()
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationViewController = segue.destination as? AddTaskViewController else { return }
        
        // contextをAddTaskViewController.swiftのcontextへ渡す
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        destinationViewController.context = context
        if let indexPath = taskTableView.indexPathForSelectedRow, segue.identifier == segueEditTaskViewController{
            // 編集したいデータのcategoryとnameを取得
            let editedCategory = taskCategories[indexPath.section]
            let editedName = tasksToShow[editedCategory]?[indexPath.row]
            // 先ほど取得したcategoryとnameに合致するデータのみをfetchするようにfetchRequestを作成
            let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name = %@ and category = %@", editedName!, editedCategory)
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
    
    func getData() {
        // データ保存時と同様にcontextを定義
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            // CoreDataからデータをfetchしてtasksに格納
            let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
            tasks = try context.fetch(fetchRequest)
            
            // tasksToShow配列を空にする（同じデータを複数表示しないため）
            for key in tasksToShow.keys{
                tasksToShow[key] = []
            }
            //先ほどfetchしたデータをtasksToShow配列に格納する
            for task in tasks {
                tasksToShow[task.category!]?.append(task.name!)
            }
        } catch {
            print("Fetcing Failed.")
        }
    }
    
    // MARK: - Table View Data Source
    
    // taskCategories[]に格納されている文字列がTableViewのセクションになる
    func numberOfSections(in tableView: UITableView) -> Int {
        return taskCategories.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return taskCategories[section]
    }
    
    // tasksToShowにカテゴリー（tasksToShowのキーとなっている）ごとのnameが格納されている
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksToShow[taskCategories[section]]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = taskTableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.reuseIdentifier, for: indexPath) as? TaskTableViewCell else{
            fatalError("Unexpected Index Path")
        }
        
        let sectionData = tasksToShow[taskCategories[indexPath.section]]
        let cellData = sectionData?[indexPath.row]
        
        cell.textLabel?.text = "\(cellData!)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if editingStyle ==  .delete {
            // 削除したいデータのみをfetchする
            // 削除したいデータのcategoryとnameを取得
            let deletedCategory = taskCategories[indexPath.section]
            let deletedName = tasksToShow[deletedCategory]?[indexPath.row]
            // 先ほど取得したcategoryとnameに合致するデータのみをfetchするようにfetchRequestを作成
            let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name = %@ and category = %@", deletedName!, deletedCategory)
            // そのfetchRequestを満たすデータをfetchしてtask（配列だが要素を1種類しか持たない）に代入し、削除する
            do {
                let task = try context.fetch(fetchRequest)
                context.delete(task[0])
            } catch {
                print("Fetching Failed.")
            }
            
            // 削除した後のデータを保存する
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            // 削除後の全データをfetchする
            getData()
        }
        // taskTableViewを再読み込みする
        taskTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

