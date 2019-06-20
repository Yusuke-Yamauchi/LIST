//
//  DayViewController.swift
//  beekeeper7
//
//  Created by 梶原敬太 on 2019/06/20.
//  Copyright © 2019 梶原敬太. All rights reserved.
//

import UIKit

class DayViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    
    var dayTable: UITableView!
    
    let userDefaults = UserDefaults.standard
    
    //タイトルと本文の配列 配列の中身が辞書になっている
    var days: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dayTable.dataSource = self
        dayTable.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    //    addviewcontrollerで問題を登録して画面遷移してきたときに
    //    キーを頼りに[questions配列] にデータを保存
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        let userDefaults = UserDefaults.standard
        //画面が戻って来たときに一旦配列を空にしてから再度読み込む
        days = []
        
        //userDefaults.object(forKey: “キー名”)はデータを取り出すメソッド。
        //forKey に userDefaults.setメソッドで設定したキー値をいれて、データを取り出す。
        if userDefaults.object(forKey: "days") != nil {
            
            //もしデータが入っていたらquestions配列にデータを入れる
            days = userDefaults.object(forKey: "days") as! [[String: Any]]
            
            
        }
        
        //tableViewを更新
        dayTable.reloadData()
        
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return days.count
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "DayCell")
        
           //        呼び出すのはインデックスパスのrow番目
        //cell.textLabel?.text = resultArray[indexPath.row]
        
        cell.textLabel?.text = ""
        
        
        cell.detailTextLabel?.text = "詳細なメッセージだよ"
        
        
        cell.imageView?.image = UIImage(named: "1")
        
        
        
        
        return cell
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
