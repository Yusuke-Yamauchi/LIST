//
//  AddViewController.swift
//  beekeeper7
//
//  Created by 梶原敬太 on 2019/06/20.
//  Copyright © 2019 梶原敬太. All rights reserved.
//

import UIKit

class AddViewController: UIViewController,UITextFieldDelegate {
    
   
    @IBAction func dateButton(_ sender: Any) {
        date.isHidden = false
        
    }
    
    @IBOutlet weak var dateButton: UIButton!
    
    
    @IBAction func dateClose(_ sender: Any) {
        dateButton.setTitle(dateChecker, for: .normal)
        
        dateButton.setTitleColor(UIColor.black, for: .normal)
        
        date.isHidden = true
        
    }
    
    @IBOutlet weak var date: UIDatePicker!
    
    var dateChecker : String = ""
    
    @IBAction func date(_ sender: Any) {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy年mm月dd日 HH:mm"
        
        dateChecker = formatter.string(from: (sender as AnyObject).date)
        
    }
    
    
    @IBOutlet weak var memoTextField: UITextField!
    
    //タイトルと本文の配列 配列の中身が辞書になっている
    var days: [[String: Any]] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  dateTextField.delegate = self
        memoTextField.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addButton(_ sender: UIButton) {
        
        //タイトルが入力されなかったとき
        if dateChecker.isEmpty{
            showAlert(message: "本文を入力してください")
            //タイトルが入力されたとき  タイトル用と本文用の変数をつくる
        }else {
            //タイトルが入力されたものを変数に格納
            var date = dateChecker
            
            //本文が入る変数
            var honbun = memoTextField.text!
            
            
            //UserDefaults.standardで  変数userDefaults は UserDefaultsのデータを参照しますよということ
            //データを保存する時やデータを取り出す時など様々な場面で登場する
            let userDefaults = UserDefaults.standard
            
            //前に保存したデータの呼び出し
            if UserDefaults.standard.object(forKey: "days") != nil {
                days = UserDefaults.standard.object(forKey: "days") as! [[String : Any]]
                
                
                //タイトルと本文が決まったらdays配列に追加する 問題文はtitle 本文はhonbunnaiyou に入っている
                //var questions: [[String: Any]] = []
                days.append(["title": date, "naiyou": honbun])
                
                //追加したら入力画面は空にする
              //  dateTextField.text = ""
                memoTextField.text = ""
                
                
            }
            
            //内容が追加された配列をユーザーデフォルトにdaysというキー値で保存する
            //userDefaults.set(保存したいデータ(今回は配列), forKey: “キー名”)
            userDefaults.set(days, forKey: "days")
            
            //シュミレータで動かしたときにデバックエリアでなにが保存されてるか見るために配列をprintしてみる
            print("保存したデータ\(days)")
        }
        
        
        
        
        
        
    }
    
    
    @IBAction func modoruButton(_ sender: Any) {
        //dismissで画面を戻るとviewDidLoadは反応しないからviewWillAppearを使う
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    // アラートを出す関数
    //使うときはshowAlert(message: "表示したいメッセージ")とかけばいい
    func showAlert(message: String) {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "とじる", style: .cancel , handler: nil)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
        
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
