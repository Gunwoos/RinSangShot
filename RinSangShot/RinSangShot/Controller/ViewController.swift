//
//  ViewController.swift
//  RinSangShot
//
//  Created by 임건우 on 23/01/2019.
//  Copyright © 2019 lims. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController {

    @IBOutlet weak var TopView: UIView!
    @IBOutlet weak var SettingButton: UIButton!
    @IBOutlet weak var ViewSizeButton: UIButton!
    @IBOutlet weak var ChangeButton: UIButton!
    
    
    
    @IBOutlet weak var BottomView: UIView!
    @IBOutlet weak var AlbumButon: UIButton!
    @IBOutlet weak var TakeButton: UIButton!
    @IBOutlet weak var FilterButton: UIButton!
    
    @IBOutlet weak var CameraImageVIew: UIImageView!
    private let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePickerController.delegate = self
        
    }
    
    @IBAction func ShowAlbum(_ sender: Any) {
        print("\n---------- [ pickImage ] ----------\n")
        let type = UIImagePickerController.SourceType.photoLibrary
        guard UIImagePickerController.isSourceTypeAvailable(type) else { return }
        
        imagePickerController.sourceType = type
        present(imagePickerController, animated: true)
    }
    


}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("Image Picker Did Pick")
        
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        if UTTypeEqual(mediaType, kUTTypeMovie){
            let originalVideo = info[UIImagePickerController.InfoKey.mediaURL] as! NSURL
            
            if let path = originalVideo.path{
                UISaveVideoAtPathToSavedPhotosAlbum(path, nil, nil, nil)
            }
        }
        else{
            let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            let selectedImage = editedImage ?? originalImage
            CameraImageVIew.image = selectedImage
            
            if let saveImage = selectedImage{
                UIImageWriteToSavedPhotosAlbum(saveImage, nil, nil, nil)
            }
        }
        
        picker.dismiss(animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Image Picker Did Cancel")
        
        picker.dismiss(animated: true)
    }
}

