//
//  SideMenuViewController.swift
//  CoreToDo
//
//  Created by 小野寺 恵 on 2017/07/17.
//  Copyright © 2017年 derasan. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var sideMenuView: UITableView!
    var sideBackView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        createView()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func createView() {
        var barHeight: CGFloat!
        var displayWidth: CGFloat!
        var displayHeight: CGFloat!
        barHeight = UIApplication.shared.statusBarFrame.size.height // 表示されるステータスバーの高さを取得
        displayWidth = UIScreen.main.bounds.size.width // 表示する画面の幅を取得
        displayHeight = UIScreen.main.bounds.size.height // 表示する画面の高さを取得
        
        self.view.frame = CGRect(x:0, y:0, width:displayWidth, height:displayHeight) // 元々のViewのサイズを指定
        
        // メニューのViewを作成
        sideMenuView = UITableView(frame: CGRect(x:0, y:barHeight, width:displayWidth * 0.7, height:displayHeight - barHeight))
        sideMenuView.backgroundColor = UIColor(red: 0.227, green: 0.0, blue:0.549, alpha: 1.0) // 背景色を指定
        sideMenuView.alpha = 0.9 // 透明度を指定
        
        // メニューをタップした時のためにセルのIDの指定やdelegateの指定を行う
        sideMenuView.register(UITableViewCell.self, forCellReuseIdentifier: "SideCell")
        sideMenuView.dataSource = self
        sideMenuView.delegate = self
        sideMenuView.tableFooterView = UIView()
        
        view.addSubview(sideMenuView) // 作成したViewをメインのViewに追加し、表示されるようにする
        
        // 背景viewを作成
        sideBackView = UIView(frame: CGRect(x:displayWidth * 0.7, y:barHeight, width:displayWidth * 0.3, height:displayHeight - barHeight))
        sideBackView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue:0.0, alpha: 0.5)
        view.addSubview(sideBackView)
        
        // 背景viewタップ時の動きを設定
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(SideMenuViewController.tapSingle(sender:))) // タップが行われたときに実行される関数を指定
        singleTap.numberOfTapsRequired = 1
        sideBackView.addGestureRecognizer(singleTap)
        
    }
    
    // 背景のviewをタップすると呼ばれる
    func tapSingle(sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil) // 全てのモーダルを閉じます
    }
    
    // Cellが選択された際に呼び出される.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
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
