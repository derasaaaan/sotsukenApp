//
//  SubdivAddTask2ViewController.swift
//  CoreToDo
//
//  Created by 小野寺 恵 on 2017/11/07.
//  Copyright © 2017年 derasan. All rights reserved.
//

import UIKit

class SubdivAddTask2ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var detailTextField: UITextField!
    @IBOutlet weak var detailCategorySegmentedControl: UISegmentedControl!
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var task: DetailTask?

    var taskCategory = "First"
    var taskIdFirst = 0
    var  taskIdSecond = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // taskにも値が代入されていたら、textFieldとsegmentedControlにそれを表示
        if let task = task {
            detailTextField.text = task.name
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
        //セルの数から適当にかぶらない数字を割り当て
        let cellNum = Int16(taskIdSecond) + 1
        
        if task?.subdivTaskid != nil{
            for var i in cellNum...(task?.subdivTaskid)!{
                i += 1
            }
            taskIdSecond = Int(cellNum) + 1
        } else if task?.subdivTaskid == nil{
            taskIdSecond = Int(cellNum)
        }
        print("secondのcellナンバー",taskIdSecond)
        
        print(self.taskIdFirst)
    }

    // MARK: - Actions of Buttons

    
    @IBAction func detailSaveButtonTapped(_ sender: UIBarButtonItem) {
        
        let taskName = detailTextField.text
        if taskName == ""{
            navigationController?.popViewController(animated: true)
            return
        }
        
        // 受け取った値が空であれば、新しいTask型オブジェクトを作成する
        if task == nil{
            task = DetailTask(context: context)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
