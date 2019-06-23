//
//  TableViewController.swift
//  beekeeper7
//
//  Created by 梶原敬太 on 2019/06/20.
//  Copyright © 2019 梶原敬太. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var listDays :[[[String:Any]]] = []
    
    
    @IBAction func addButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "追加", message: "巣箱の名前を入力してください", preferredStyle: .alert)
        
        //TextFieldを追加
        alert.addTextField { (text:UITextField!) in
            text.placeholder = "ここにテキストを入力してください"
            text.tag = 1
            
        }
        
        //OKボタンを生成
        let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            
            //複数のtextFieldのテキストを格納
            guard let textFields:[UITextField] = alert.textFields else {return}
            //textからテキストを取り出していく
            //もしテキストフィールドに何も入っていなかったらブレイクして、それ以外の時にデータを保存する
            for textField in textFields {
                if textField.text! != "" {
                    let textf = String(textField.text!)
                    self.list.append(textf)
                    
                    UserDefaults.standard.set( self.list, forKey: "box" )
                    self.tableView.reloadData()
                    self.listDays.append([])
                    UserDefaults.standard.set(self.listDays, forKey: "list")
                }else{
                    break
                }
                print("追加したとき：\(self.list)")
            }
        }
        
        //OKボタンを追加
        alert.addAction(okAction)
        //Cancelボタンを生成
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        //Cancelボタンを追加
        alert.addAction(cancelAction)
        
        //アラートを表示
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
    
    
    var list: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        UserDefaults.standard.removeObject(forKey: "days")
//      UserDefaults.standard.removeObject(forKey: "box")
//        UserDefaults.standard.removeObject(forKey: "list")
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.object(forKey: "box") != nil{
            list = UserDefaults.standard.object(forKey: "box") as! [String]
            tableView.reloadData()
        }
        if UserDefaults.standard.object(forKey: "list") != nil{
            listDays = UserDefaults.standard.object(forKey: "list") as! [[[String:Any]]]
    }
    
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = list[indexPath.row]
        
        return cell
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectRow = indexPath.row
        UserDefaults.standard.set(selectRow, forKey: "row")
    }
  
    
    
    
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
        //消す前に画像があるpathを取得
        let Days  = listDays[indexPath.row]
        for i in 0..<Days.count{
        //先に画像を全部消す
            let Daysrow:[String:Any] = Days[i]
//            if let time:String = Daysrow["time"] as! String{
            if Daysrow["time"] != nil {
                let time:String = Daysrow["time"] as! String
                let url = getURL(time)
                do {
                    try FileManager.default.removeItem(atPath:url.path)
                    print("消去したよ")
                }catch {
                    print("消去できませんでした")
                }
            }
        }
  
        
        //セルの消去
//        DispatchQueue.main.asyncAfter(deadline: .now()+1){
            tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.list.remove(at: indexPath.row)
            self.listDays.remove(at: indexPath.row)
            UserDefaults.standard.set(self.list, forKey: "box")
            UserDefaults.standard.set(self.listDays, forKey: "list")
            tableView.endUpdates()
        
//        }
        
        
        
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func getURL(_ time:String) ->URL {
        
        let documentsURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent("\(time).png")
        print(documentsURL)
        print("時間付き\(fileURL)")
        return fileURL
    }
}
