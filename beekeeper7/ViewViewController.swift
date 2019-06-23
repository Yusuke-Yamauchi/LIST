//
//  ViewController.swift
//  UIImagePickerControllerSample
//
//  Created by RyutaMiyamoto on 2018/06/22.
//  Copyright © 2018 RyutaMiyamoto. All rights reserved.
//

import UIKit

class ViewViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
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
    
    //保存ボタン
    @IBAction func tapSaveButton(_ sender: UIButton) {
        guard let image = imageView.image else { return }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.saveImage(_:didFinishSavingWithError:contextInfo:)), nil)
        showAlert(message: "保存しました")
    }
    
    
    
    
    
    
    
    
    
    
    
    
    //SNS投稿
    @IBAction func snsBUtton(_ sender: Any) {
        if let shereImage =  imageView.image {
            let shereItems = [shereImage]
            let controller = UIActivityViewController(activityItems: shereItems, applicationActivities: nil)
            controller.popoverPresentationController?.sourceView = view
            present(controller, animated: true, completion: nil)
        }
        
    }
    
    
    func openPicker(type: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(type) else { return }
        let picker = UIImagePickerController()
        picker.sourceType = type
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else { return }
        imageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    @objc func saveImage(_ image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutableRawPointer) {
        if error == nil {
            print("save success")
        }
    }
    
    
    
    
    
    // アラートを出す関数
    //使うときはshowAlert(message: "表示したいメッセージ")とかけばいい
    func showAlert(message: String) {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "とじる", style: .cancel , handler: nil)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    
}
