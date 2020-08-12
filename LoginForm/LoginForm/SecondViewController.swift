//
//  SecondViewController.swift
//  LoginForm
//
//  Created by 류진혁 on 2020/08/07.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @IBOutlet weak var idText: UITextField!
    
    @IBOutlet weak var passWord: UITextField!
    
    
    @IBOutlet weak var passWordCheck: UITextField!
    @IBAction func tapView(_ sender: UITapGestureRecognizer){
        self.view.endEditing(true)
    }

    lazy var imagepicker : UIImagePickerController = {
        let picker : UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        return picker
    }()
    
    @IBOutlet weak var NextButton: UIButton!
    
    @IBAction func touchUpSelectImageButton(_ sender: UIButton) {
        self.present(self.imagepicker, animated: true, completion: nil)
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NextButton.isUserInteractionEnabled = false
        NextButton.setTitleColor(.gray, for: .normal)
       
      
    }
    @IBAction func editChanged(_ sender: UITextField) {
        //조건: 글자가 비었는가?
        if idText.text?.isEmpty == true || passWord.text?.isEmpty == true||passWordCheck.text?.isEmpty == true {
            NextButton.isUserInteractionEnabled = false
            NextButton.setTitleColor(.gray, for: .normal)
        }else{
            if(passWord.text==passWordCheck.text){
                NextButton.isUserInteractionEnabled = true
                NextButton.setTitleColor(.blue, for: .normal)
            }else{
                NextButton.isUserInteractionEnabled = false
                           NextButton.setTitleColor(.gray, for: .normal)
                
            }
            
        }
    }
    
    
    @IBAction func dismissModal() {
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage : UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.imageView.image = originalImage
        }
        
        
        self.dismiss(animated: true, completion: nil)
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
