//
//  AddViewController.swift
//  beekeeper7
//
//  Created by 梶原敬太 on 2019/06/20.
//  Copyright © 2019 梶原敬太. All rights reserved.
//

import UIKit
import AssetsLibrary
import Photos



class AddViewController: UIViewController,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var savebuttonIspushed = false
    var imageUrlStr = ""
    
    //イメージビュー
    @IBOutlet weak var imageView: UIImageView!
    
    
    //フォトライブラリーにアクセス
    @IBAction func tapPhotoLibraryButton(_ sender: UIButton) {
        openPicker(type: .photoLibrary)
    }
    
    //カメラ起動ボタン
    @IBAction func tapCameraButton(_ sender: UIButton) {
        openPicker(type: .camera)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if UserDefaults.standard.object(forKey: "list") == nil {
            print("dame")
        } else {
            if savebuttonIspushed == true{
            var list = UserDefaults.standard.object(forKey: "list") as! [[[String:Any]]]
            let row = UserDefaults.standard.object(forKey: "row") as! Int
            list[row] = days
            UserDefaults.standard.set(list, forKey: "list")
            }else{return}
        }
    }
    
    
    
    //ボタンを押すと
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
        
        formatter.dateFormat = "yyyy年MM月dd日 hh:mm"
        
        dateChecker = formatter.string(from: (sender as AnyObject).date)
        
    }
    
    
    @IBOutlet weak var memoTextField: UITextField!
    
    //タイトルと本文の配列 配列の中身が辞書になっている
    var days: [[String: Any]] = []
    var day: [String: Any] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  dateTextField.delegate = self
        memoTextField.delegate = self
        
        
        savebuttonIspushed = false
        dateButton.layer.borderWidth = 0.5
        // 枠線の幅
        dateButton.layer.borderColor = UIColor.black.cgColor
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addButton(_ sender: UIButton) {
        savebuttonIspushed = true
        //タイトルが入力されなかったとき
        if dateChecker.isEmpty{
            showAlert(message: "本文を入力してください")
            //タイトルが入力されたとき  タイトル用と本文用の変数をつくる
        }else {
            //タイトルが入力されたものを変数に格納
            var date:String = dateChecker
            
            //本文が入る変数
            var honbun:String = memoTextField.text!
            
            
            //UserDefaults.standardで  変数userDefaults は UserDefaultsのデータを参照しますよということ
            //データを保存する時やデータを取り出す時など様々な場面で登場する
            let userDefaults = UserDefaults.standard
            
            //前に保存したデータの呼び出し
            if UserDefaults.standard.object(forKey: "list") != nil {
                
                let daysList = UserDefaults.standard.object(forKey: "list") as! [[[String : Any]]]
                let row =  UserDefaults.standard.object(forKey: "row") as! Int
                days = daysList[row]
                //タイトルと本文が決まったらdays配列に追加する 問題文はtitle 本文はhonbunnaiyou に入っている
                //var questions: [[String: Any]] = []
                day["title"] = date
                day["naiyou"] = honbun
                // day["imageUrl"] = imageUrlStr
                print("day:\(day)")
                
                days.append(day)
                
                //追加したら入力画面は空にする
                //  dateTextField.text = ""
                memoTextField.text = ""
                
                
            }
            
            //内容が追加された配列をユーザーデフォルトにdaysというキー値で保存する
            //userDefaults.set(保存したいデータ(今回は配列), forKey: “キー名”)
            //userDefaults.set(days, forKey: "days")
            
            //シュミレータで動かしたときにデバックエリアでなにが保存されてるか見るために配列をprintしてみる
            print("保存したデータ\(days)")
            showAlert(message: "保存しました")
        }
        
        
        
        
        
        
    }
    
    
    //    @IBAction func modoruButton(_ sender: Any) {
    //        //dismissで画面を戻るとviewDidLoadは反応しないからviewWillAppearを使う
    //        self.dismiss(animated: true, completion: nil)
    //    }
    //
    
    
    
    
    
    
    // アラートを出す関数
    //使うときはshowAlert(message: "表示したいメッセージ")とかけばいい
    func showAlert(message: String) {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "とじる", style: .cancel , handler: nil)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
        
    }
    
    func openPicker(type: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(type) else { return }
        let picker = UIImagePickerController()
        picker.sourceType = type
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else { return }
        //let imageUrl = info[.imageURL] as? URL
        //        imageUrlStr = String(describing: imageUrl!)
        //
        //        print("imageUrl:\n\(String(describing: imageUrl!))")
        
        imageView.image = image
        saveImage(image)
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    //iPhoneのデフォルトの写真一覧
    func pickImageFromLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            
            // 新たに追加したカメラロール表示ViewControllerをpresentViewControllerにする
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        memoTextField.resignFirstResponder()
        return true
    }
    
    
    
    //    let fetchResult: PHFetchResult = PHAsset.fetchAssetsWithALAssetURLs([url], options: nil)
    //    let asset: PHAsset = fetchResult.firstObject as! PHAsset
    //    let manager = PHImageManager.defaultManager()
    //    manager.requestImageForAsset(asset, targetSize: CGSize(width: 140, height: 140), contentMode: .AspectFill, options: nil) { (image, info) in
    //    // imageをセットする
    //    imageView.image = image
    //    }
    
    
    
    func saveImage (_ image: UIImage){
        //pngで保存する場合
        let pngImageData = image.pngData()
        // jpgで保存する場合
        //    let jpgImageData = UIImageJPEGRepresentation(image, 1.0)
        let currentTime:String = "\(NSDate())"
        day.updateValue(currentTime, forKey: "time")
        let documentsURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)[0]
        
        
        let fileURL = documentsURL.appendingPathComponent("\(currentTime).png")
        
        
        do {
            try pngImageData!.write(to: fileURL)
            //            let url:String = fileURL.absoluteString
            //            data.updateValue(url, forKey: "signPath")
        } catch {
            return
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
