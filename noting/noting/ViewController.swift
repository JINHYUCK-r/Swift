//
//  ViewController.swift
//  noting
//
//  Created by 류진혁 on 2020/08/06.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    lazy var imagePicker : UIImagePickerController = {
        let picker : UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        return picker
    }()
    
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        print("print")
    }
    
    @IBOutlet weak var imageview: UIImageView!
    
    @IBAction func touchUpselectImagebutton(_sender: UIButton){
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    func imagepickercontrollerdidcancel(_picker : UIImagePickerController){
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage : UIImage =
            info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.imageview.image = originalImage
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }


}

