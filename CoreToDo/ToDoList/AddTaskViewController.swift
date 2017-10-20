//
//  AddTaskViewController.swift
//  CoreToDo
//
//  Created by 小野寺 恵 on 2017/06/21.
//  Copyright © 2017年 derasan. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController,UITextFieldDelegate {

    // MARK: - Properties
    
    // MARK: - 今日の日付を代入
    let nowDate = NSDate()
    let dateFormat = DateFormatter()
    let inputDatePicker = UIDatePicker()
    let inputDatePickerEnd = UIDatePicker()
    
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var categorySegmentedControl: UISegmentedControl!
    @IBOutlet weak var dateSelecter: UITextField!
    @IBOutlet weak var dateSelectorEnd: UITextField!
    
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var task: Task?
    
    // MARK: -
    
    var taskCategory = "ToDo"
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //日付フィールドの設定
        dateFormat.dateFormat = "yyyy年MM月dd日HH時mm分"
        dateSelecter.text = dateFormat.string(from: nowDate as Date)
        self.dateSelecter.delegate = self
        
        dateSelectorEnd.text = dateFormat.string(from: nowDate as Date)
        self.dateSelectorEnd.delegate = self
        
        // DatePickerの設定（日付用）
        inputDatePicker.datePickerMode = UIDatePickerMode.dateAndTime
        dateSelecter.inputView = inputDatePicker
        
        inputDatePickerEnd.datePickerMode = UIDatePickerMode.dateAndTime
        dateSelectorEnd.inputView = inputDatePickerEnd
        
        
        // キーボードに表示するツールバーの表示
        let pickerToolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        pickerToolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        pickerToolBar.barStyle = .blackTranslucent
        pickerToolBar.tintColor = UIColor.white
        pickerToolBar.backgroundColor = UIColor.black

        // taskにも値が代入されていたら、textFieldとsegmentedControlにそれを表示
        if let task = task {
            taskTextField.text = task.name
            taskCategory = task.category!
            switch task.category! {
                case "ToDo":
                    categorySegmentedControl.selectedSegmentIndex = 0
                case "Shopping":
                    categorySegmentedControl.selectedSegmentIndex = 1
                case "Assignment":
                    categorySegmentedControl.selectedSegmentIndex = 2
                default:
                    categorySegmentedControl.selectedSegmentIndex = 0
            }
            inputDatePicker.date = task.date! as Date //date保存test
            let insertedDate = inputDatePicker.date
            dateSelecter.text = dateFormat.string(from: insertedDate)
            inputDatePickerEnd.date = task.dateEnd! as Date
            let insertedDateEnd = inputDatePickerEnd.date
            dateSelectorEnd.text = dateFormat.string(from: insertedDateEnd)
        }

    }

    // MARK: - Actions of Buttons
    
    @IBAction func categoryChosen(_ sender: UISegmentedControl) {
        // choose category of task
        switch sender.selectedSegmentIndex {
        case 0:
            taskCategory = "ToDo"
        case 1:
            taskCategory = "Shopping"
        case 2:
            taskCategory = "Assignment"
        default:
            taskCategory = "ToDo"
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // ピッカーの値をtextFieldに入れて入力画面を閉じる
        let pickerDate = inputDatePicker.date
        dateSelecter.text = dateFormat.string(from: pickerDate)
        self.view.endEditing(true)

        let pickerDateEnd = inputDatePickerEnd.date
        dateSelectorEnd.text = dateFormat.string(from: pickerDateEnd)
        self.view.endEditing(true)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func plusButtonTapped(_ sender: Any) {
        
        // TextFieldに何も入力されていない場合は何もせずに1つ目のビューへ戻ります。
        let taskName = taskTextField.text
//        let pickerDate = inputDatePicker.date //date保存test
        if taskName == "" {
            dismiss(animated: true, completion: nil)
            return
        }
        
        // 受け取った値が空であれば、新しいTask型オブジェクトを作成する
        if task == nil {
            task = Task(context: context)
        }
        
        // 受け取ったオブジェクト、または、先ほど新しく作成したオブジェクトそのタスクのnameとcategoryに入力データを代入する
        if let task = task {
            task.name = taskName
            task.category = taskCategory
            task.date = inputDatePicker.date as NSDate //date保存test
            task.dateEnd = inputDatePickerEnd.date as NSDate
        }
        
        // 変更内容を保存する
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        dismiss(animated: true, completion: nil)
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
