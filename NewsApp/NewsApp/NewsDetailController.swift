//
//  NewsDetailController.swift
//  NewsApp
//
//  Created by 류진혁 on 2020/08/18.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import UIKit

class NewsDetailController : UIViewController {

    @IBOutlet weak var ImageMain: UIImageView!
  
    @IBOutlet weak var LabelMain: UILabel!
    
    
    //1.image url
    //2. desc
    
    var imageUrl : String?
    var desc: String?
    
    
    
    
    
    override func viewDidLoad() {
          super.viewDidLoad()

          // Do any additional setup after loading the view.
        if let img = imageUrl{
            //이미지를 가져와서 뿌린다
            //Data 사용
            if let data = try? Data(contentsOf: URL(string: "")!){
                DispatchQueue.main.async {
                     //Main thread
                    self.ImageMain.image = UIImage(data: data)
                }
               
            }
           
        }
        if let d = desc{
            //본문을 보여준다
            self.LabelMain.text = d
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
