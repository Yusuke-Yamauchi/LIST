//
//  DayViewController.swift
//  beekeeper7
//
//  Created by 梶原敬太 on 2019/06/20.
//  Copyright © 2019 梶原敬太. All rights reserved.
//

import UIKit

class DayViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    
    @IBOutlet var dayTable: UITableView!
    
    //let userDefaults = UserDefaults.standard
    
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
       // days = []
        
        //userDefaults.object(forKey: “キー名”)はデータを取り出すメソッド。
        //forKey に userDefaults.setメソッドで設定したキー値をいれて、データを取り出す。
//        if userDefaults.object(forKey: "days") == nil {
//            print("dame")
//        } else if UserDefaults.standard.object(forKey: "days") != nil{
//            days = UserDefaults.standard.object(forKey: "days") as! [[String : Any]]
        if userDefaults.object(forKey: "list") == nil {
            print("dame")
        } else{
            let daysList =    userDefaults.object(forKey: "list") as! [[[String : Any]]]
            print(daysList)
            let row = userDefaults.object(forKey: "row") as! Int
            days = daysList[row]
        
                        dayTable.reloadData()
        }
        
        dayTable.reloadData()
        
    }
    
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        if UserDefaults.standard.object(forKey: "list") == nil {
            print("dame")
        } else {
            var list = UserDefaults.standard.object(forKey: "list") as! [[[String:Any]]]
            let row = UserDefaults.standard.object(forKey: "row") as! Int
            list[row] = days
            UserDefaults.standard.set(list, forKey: "list")
        }
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return days.count
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayCell", for: indexPath) as! DayTableViewCell
      
        
        cell.dateLabel?.text = days[indexPath.row]["title"] as? String
        
        cell.honbunLabel?.text = days[indexPath.row]["naiyou"] as? String
        if let time = days[indexPath.row]["time"]{
            let url = getURL(time as! String)
            cell.photoImage?.image = UIImage(contentsOfFile: url.path)
            
        }
        
        return cell
    }
    
    
    
    //UIImageでURLで指定して画像を取得したいとき
    func getImageByUrl(url: String) -> UIImage{
        let url = URL(string: url)
        do {
            let data = try Data(contentsOf: url!)
            return UIImage(data: data)!
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        return UIImage()
        
        
        
        
    }
    
    
    func getURL(_ time:String) ->URL {
        
        let documentsURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent("\(time).png")
        print(documentsURL)
        print("時間付き\(fileURL)")
        return fileURL
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
            if let time = days[indexPath.row]["time"]{
                let url = getURL(time as! String)
                do {
                    try FileManager.default.removeItem(atPath:url.path)
                    print("消去したよ")
                }catch {
                    print("消去できませんでした")
                }
            }
            
            //resultArray内のindexPathのrow番目をremove（消去）する
            days.remove(at: indexPath.row)
            
            //再びアプリ内に消去しおわった配列を保存 保存はwilldisapperでやってるから大丈夫
            //UserDefaults.standard.set(days, forKey: "days")
            //tableViewを更新
            dayTable.reloadData()
            
        }
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
