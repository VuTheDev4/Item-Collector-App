//
//  CreateCollectibleVC.swift
//  Collector
//
//  Created by Vu Duong on 8/29/18.
//  Copyright © 2018 Vu Duong. All rights reserved.
//

import UIKit

class CreateCollectibleVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    var pickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerController.delegate = self

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
        }
        pickerController.dismiss(animated: true, completion: nil)
    }
    @IBAction func mediaFolderPressed(_ sender: Any) {
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    @IBAction func cameraPressed(_ sender: Any) {
        pickerController.sourceType = .camera
        present(pickerController, animated: true, completion: nil)
    }
    @IBAction func addPressed(_ sender: Any) {
        
        if let context = (UIApplication.shared.delegate as?
            AppDelegate)?.persistentContainer.viewContext {
            let collectible = Collectible(context: context)
            collectible.title = textField.text
            // Converting image to data
            collectible.image = imageView.image?.jpegData(compressionQuality: 1.0)
            // Saving to Core Data
            (UIApplication.shared.delegate as?
                AppDelegate)?.saveContext()
        }
        
        navigationController?.popViewController(animated: true)
    }
    
}
