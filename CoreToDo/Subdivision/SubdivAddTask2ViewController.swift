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
    }

    // MARK: - Actions of Buttons

    @IBAction func detailCategoryChosen(_ sender: UISegmentedControl) {
        // choose category of task
        switch sender.selectedSegmentIndex {
        case 0:
            taskCategory = "First"
        case 1:
            taskCategory = "Second"
        default:
            taskCategory = "First"
        }
    }
    
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
