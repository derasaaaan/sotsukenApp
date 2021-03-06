//
//  TaskSubdiviStep3ViewController.swift
//  CoreToDo
//
//  Created by 小野寺 恵 on 2017/09/25.
//  Copyright © 2017年 derasan. All rights reserved.
//

import UIKit
import CoreData

class TaskSubdiviStep3ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var subdivTableView3: UITableView!
    
    private let segueEditDetailPartViewController = "SegueEditDetailPartViewController"
    
    var tasks:[Detail2Task] = []
    var tasksToShow:[String:[String]] = ["First":[], "Second":[]]
    let taskCategories:[String] = ["First", "Second"]
    
    var number = 0
    var taskIdFirst = 0
    var taskIdSecond = 0
    
    // チェックマークのやつ
    var checkDataArray = [false, false, false]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        subdivTableView3.dataSource = self
        subdivTableView3.delegate = self
        
        //  チェックマークのやつ
        subdivTableView3.allowsMultipleSelection = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // CoreDataからデータをfetchしてくる
        getData()
        
        // taskTableViewを再読み込みする
        subdivTableView3.reloadData()
        
//        totalCell = tasks.count
    }

    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //ここにaddControllerに渡す値をかく
        let toAddThird = segue.destination as? SubdivAddTask3ViewController
        if segue.identifier?.description == "toAddThird" {
            toAddThird?.taskIdFirst = self.taskIdFirst
            toAddThird?.taskIdSecond = self.number
        }
        
        guard let destinationViewController = segue.destination as? SubdivAddTask3ViewController else { return }
        
        // contextをAddTaskViewController.swiftのcontextへ渡す
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        destinationViewController.context = context
        if let indexPath = subdivTableView3.indexPathForSelectedRow, segue.identifier == segueEditDetailPartViewController{
            // 編集したいデータのcategoryとnameを取得
            let editedCategory = taskCategories[indexPath.section]
            let editedName = tasksToShow[editedCategory]?[indexPath.row]
            // 先ほど取得したcategoryとnameに合致するデータのみをfetchするようにfetchRequestを作成
            let fetchRequest: NSFetchRequest<Detail2Task> = Detail2Task.fetchRequest()
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
            let fetchRequest: NSFetchRequest<Detail2Task> = Detail2Task.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "detailTaskid == %@ AND subdivTaskid == %@", NSNumber(value: number) , NSNumber(value: taskIdFirst))
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
        return 1
    }

    // tasksToShowにカテゴリー（tasksToShowのキーとなっている）ごとのnameが格納されている
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksToShow[taskCategories[section]]!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = subdivTableView3.dequeueReusableCell(withIdentifier: SubdivTableViewCell3.reuseIdentifier, for: indexPath) as? SubdivTableViewCell3 else{
            fatalError("Unexpected Index Path")
            }
        
        let sectionData = tasksToShow[taskCategories[indexPath.section]]
        let cellData = sectionData?[indexPath.row]
        
        cell.textLabel?.text = "\(cellData!)"
        
        // セルにチェック状態を反映
        if checkDataArray[indexPath.row] {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        // セルが選択された時の背景色を消す
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if editingStyle == .delete {
            // 削除したいデータのみをfetchする
            // 削除したいデータのcategoryとnameを取得
            let deletedCategory = taskCategories[indexPath.section]
            let deletedName = tasksToShow[deletedCategory]?[indexPath.row]
            // 先ほど取得したcategoryとnameに合致するデータのみをfetchするようにfetchRequestを作成
            let fetchRequest: NSFetchRequest<Detail2Task> = Detail2Task.fetchRequest()
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
        subdivTableView3.reloadData()
    }
    
//    //  チェックマークのやつ
//    func  tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at:indexPath)
//        
//        // チェックマークを入れる
//        cell?.accessoryType = .checkmark
//    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        // チェック状態を反転してリロードする
        checkDataArray[indexPath.row] = !checkDataArray[indexPath.row]
        tableView.reloadData()
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
