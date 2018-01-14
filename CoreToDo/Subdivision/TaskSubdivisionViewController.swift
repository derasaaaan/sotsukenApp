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
    var tasksToShow:[String:[String]] = ["First":[], "Second":[]]
    let taskCategories:[String] = ["First", "Second"]
    
    var totalCell = 0
//    var task: SubdivTask?
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SubdivTask")

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        subdivTableView.dataSource = self
        subdivTableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // CoreDataからデータをfetchしてくる
        getData()
        
        // taskTableViewを再読み込みする
        subdivTableView.reloadData()
        
        totalCell = tasks.count
//        print(totalCell)
    }

    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        print(segue.identifier!)

//        以下二つのletはguardを外しました
        let toDetail = segue.destination as? TaskSubdiviStep2ViewController
//        print(segue.identifier?.description ?? "aaaaa")
        if segue.identifier?.description == "toDetail" {
//            toDetail?.number = (task?.subdivTaskid)!
            if let indexPath = subdivTableView.indexPathForSelectedRow{
                let object = tasks[indexPath.row]
                toDetail?.number = Int(object.subdivTaskid)
            }
        }

        let toAdd = segue.destination as? SubdivAddTaskViewController
        if segue.identifier?.description == "toAdd" {
        //            print("addButtonTapped")
        toAdd?.taskId = totalCell
        }
        
        guard let destinationViewController = segue.destination as? SubdivAddTaskViewController else { return }
        
        // contextをAddTaskViewController.swiftのcontextへ渡す
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        destinationViewController.context = context
        if let indexPath = subdivTableView.indexPathForSelectedRow, segue.identifier == segueEditTaskSubdivViewController{
            // 編集したいデータのcategoryとnameを取得
            let editedCategory = taskCategories[indexPath.section]
            let editedName = tasksToShow[editedCategory]?[indexPath.row]
            // 先ほど取得したcategoryとnameに合致するデータのみをfetchするようにfetchRequestを作成
            let fetchRequest: NSFetchRequest<SubdivTask> = SubdivTask.fetchRequest()
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
            let fetchRequest: NSFetchRequest<SubdivTask> = SubdivTask.fetchRequest()
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
//        return taskCategories.count
        return 1
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return taskCategories[section]
//    }

    // tasksToShowにカテゴリー（tasksToShowのキーとなっている）ごとのnameが格納されている
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksToShow[taskCategories[section]]!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = subdivTableView.dequeueReusableCell(withIdentifier: SubdivTableViewCell1.reuseItentifier, for: indexPath) as? SubdivTableViewCell1 else{
            fatalError("Unexpected Index Path")
        }
        
        let sectionData = tasksToShow[taskCategories[indexPath.section]]
        let cellData = sectionData?[indexPath.row]
        
        cell.textLabel?.text = "\(cellData!)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if editingStyle ==  .delete {
            // 削除したいデータのみをfetchする
            // 削除したいデータのcategoryとnameを取得
            let deletedCategory = taskCategories[indexPath.section]
            let deletedName = tasksToShow[deletedCategory]?[indexPath.row]
            // 先ほど取得したcategoryとnameに合致するデータのみをfetchするようにfetchRequestを作成
            let fetchRequest: NSFetchRequest<SubdivTask> = SubdivTask.fetchRequest()
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
        subdivTableView.reloadData()
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
