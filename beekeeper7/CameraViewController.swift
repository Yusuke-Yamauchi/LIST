//
//  CameraViewController.swift
//  beekeeper7
//
//  Created by 梶原敬太 on 2019/06/20.
//  Copyright © 2019 梶原敬太. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var CameraImage: UIImageView!
    
    //カメラを起動
    @IBAction func cameraButton(_ sender: Any) {
        //カメラが使えるかどうか
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            print("カメラを使用できます")
            let ipc = UIImagePickerController()
            ipc.sourceType = .camera
            ipc.delegate = self
            present(ipc, animated:true, completion: nil)
        }else {
            print("カメラは使用できません")
        }
    }
    
    //SNS投稿
    @IBAction func snsBUtton(_ sender: Any) {
        if let shereImage = CameraImage.image {
            let shereItems = [shereImage]
            let controller = UIActivityViewController(activityItems: shereItems, applicationActivities: nil)
            controller.popoverPresentationController?.sourceView = view
            present(controller, animated: true, completion: nil)
        }
        
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        CameraImage.image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
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
