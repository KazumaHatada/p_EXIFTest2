//
//  ViewController.swift
//  EXIFTest2
//
//  Created by Kazuma Hatada on 2019/08/14.
//  Copyright © 2019 Kazuma Hatada. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBAction func bChoosePhoto(_ sender: Any) {
        PHPhotoLibrary.requestAuthorization({
            (newStatus) in
            print("status is \(newStatus)")
            if newStatus ==  PHAuthorizationStatus.authorized {
                /* do stuff here */
                print("success")
            }
        })
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    @IBOutlet weak var iImageView: UIImageView!
    
//    let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        imagePickerController.sourceType = .photoLibrary
//        imagePickerController.delegate = self
    }

    //画像が選択された時に呼ばれる.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                self.iImageView.image = image
            })
//print(info)
            checkPermission()
            
            if let onePhasset = info[.phAsset] {
                print("-------------------------------------------------------------------")
                print(onePhasset)
                print("-------------------------------------------------------------------")
            } else {
                if let oneURL = info[.imageURL] {
                    print(oneURL)
                } else {
                    print("URL failed")
                }
            }
            
        } else {
            print("Error")
        }
        
        // モーダルビューを閉じる
        picker.dismiss(animated: true, completion: nil)
    }
    

    //画像選択がキャンセルされた時に呼ばれる.
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // モーダルビューを閉じる
        picker.dismiss(animated: true, completion: nil)
    }

    // アルバム(Photo liblary)の閲覧権限の確認をするメソッド
    func checkPermission(){
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAuthorizationStatus {
        case .authorized:
            print("auth")
        case .notDetermined:
            print("not Determined")
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        @unknown default:
            print("Unknown default")
        }
    }
}
