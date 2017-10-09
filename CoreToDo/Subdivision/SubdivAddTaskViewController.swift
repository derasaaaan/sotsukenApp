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
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var task: SubdivTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let pickerToolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        pickerToolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        pickerToolBar.barStyle = .blackTranslucent
        pickerToolBar.tintColor = UIColor.white
        pickerToolBar.backgroundColor = UIColor.black
        
        // taskにも値が代入されていたら、textFieldとsegmentedControlにそれを表示
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {

//        let taskName = subdivTextField.text
//        if taskName == ""{
//            dismiss(animated: true, completion: nil)
//            return
//        }
//        if task == nil{
//            task = SubdivTask(context: context)
//        }
//
//        if let task = task{
//            task.name = taskName
//        }
//
//        (UIApplication.shared.delegate as! AppDelegate).saveContext()

        dismiss(animated: true, completion: nil)
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
