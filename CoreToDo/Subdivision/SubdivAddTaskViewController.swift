//
//  SubdivAddTaskViewController.swift
//  CoreToDo
//
//  Created by 小野寺 恵 on 2017/10/07.
//  Copyright © 2017年 derasan. All rights reserved.
//

import UIKit

class SubdivAddTaskViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var subdivTextField: UITextField!
    @IBOutlet weak var subdCategorySegmentedControl: UISegmentedControl!
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var task: SubdivTask?
    
    // MARK: -
    
    var taskCategory = "First"
    var taskId = 0
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        // キーボードに表示するツールバーの表示
//        let pickerToolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
//        pickerToolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
//        pickerToolBar.barStyle = .blackTranslucent
//        pickerToolBar.tintColor = UIColor.white
//        pickerToolBar.backgroundColor = UIColor.black
        

//        print("cellの数は",taskId)
        // taskにも値が代入されていたら、textFieldとsegmentedControlにそれを表示
        if let task = task {
            subdivTextField.text = task.name
            taskCategory = task.category!
            switch task.category! {
            case "First":
                subdCategorySegmentedControl.selectedSegmentIndex = 0
            case "Second":
                subdCategorySegmentedControl.selectedSegmentIndex = 1
            default:
                subdCategorySegmentedControl.selectedSegmentIndex = 0
            }
        }
        //変数を作る ok
        //もし変数の中身がtaskの中身になかったら
        //task.subdibTaskIdに入れる ok
        let cellNum = Int16(taskId) + 1
        
        if task?.subdivTaskid != nil{
            for var i in cellNum...(task?.subdivTaskid)!{
                i += 1
            }
            taskId = Int(cellNum) + 1
        } else if task?.subdivTaskid == nil{
            taskId = Int(cellNum)
        }
        print(taskId)
    }
    
    // MARK: - Actions of Buttons
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
        let taskName = subdivTextField.text
        if taskName == ""{
            navigationController?.popViewController(animated: true)
            return
        }
        
        // 受け取った値が空であれば、新しいTask型オブジェクトを作成する
        if task == nil{
            task = SubdivTask(context: context)
        }

        // 受け取ったオブジェクト、または、先ほど新しく作成したオブジェクトそのタスクのnameとcategoryに入力データを代入する
        if let task = task {
            task.name = taskName
            task.category = taskCategory
            task.subdivTaskid = Int16(taskId)
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
