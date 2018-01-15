//
//  SubdivAddTask3ViewController.swift
//  CoreToDo
//
//  Created by 小野寺 恵 on 2018/01/15.
//  Copyright © 2018年 derasan. All rights reserved.
//

import UIKit

class SubdivAddTask3ViewController: UIViewController {
    
    @IBOutlet weak var detail2Textfield: UITextField!
    @IBOutlet weak var detailCategorySegmentedControl: UISegmentedControl!

    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var task: Detail2Task?
    
    var taskCategory = "First"
    var taskIdFirst = 0
    var taskIdSecond = 0


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // taskにも値が代入されていたら、textFieldとsegmentedControlにそれを表示
        if let task = task {
            detail2Textfield.text = task.name
            taskCategory = task.category!
            switch task.category! {
            case "First":
                detailCategorySegmentedControl.selectedSegmentIndex = 0
            case "Second":
                detailCategorySegmentedControl.selectedSegmentIndex = 1
            default:
                detailCategorySegmentedControl.selectedSegmentIndex = 0
            }
        }

    }
    
    @IBAction func detailPartSaveButtonTapped(_ sender: UIBarButtonItem) {
        
        let taskName = detail2Textfield.text
        if taskName == ""{
            navigationController?.popViewController(animated: true)
            return
        }
        
        // 受け取った値が空であれば、新しいTask型オブジェクトを作成する
        if task == nil{
            task = Detail2Task(context: context)
        }
        
        // 受け取ったオブジェクト、または、先ほど新しく作成したオブジェクトそのタスクのnameとcategoryに入力データを代入する
        if let task = task {
            task.name = taskName
            task.category = taskCategory
            task.subdivTaskid = Int16(taskIdFirst)
            task.detailTaskid = Int16(taskIdSecond)
        }
        
        // 変更内容を保存する
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController?.popViewController(animated: true)


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
