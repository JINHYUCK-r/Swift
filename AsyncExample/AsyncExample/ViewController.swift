//
//  ViewController.swift
//  AsyncExample
//
//  Created by 류진혁 on 2020/08/20.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBAction func touchUpDownloadButton( _ sender:UIButton){
        //이미지 다운로드 -> 이미지 뷰에 셋팅
        //커다란 사이즈의 이미지를 찾아옴, 이미지를 다운받을것
        //info.plist에 App Transport Security Settings를 추가 하고 그밑에 Allow Arbitrary Loads를 추가해주면 http주소도 쓸수있을것이다
        //https://upload.wikimedia.org/wikipedia/commons/3/3d/LARGE_elevation.jpg
        
        let imageURL : URL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/3/3d/LARGE_elevation.jpg")!
        /*
        let imageData : Data = try! Data.init(contentsOf: imageURL) //1번
        let image : UIImage = UIImage(data: imageData)!
        
        self.imageView.image = image
        //실행하면 화면이 멈췄다가 이미지가 뜸. 화면이 프리즈됨 ->url로 부터 이미지를 가져오는 1번이 동기메소드(async메소드), 작업이 끝나기 전까지는 다음줄로 넘어가지 않음. 이 코드는 메인스레드에서 동작함
         */
        
        //오퍼레이션 큐를 사용하여 메인스레드가 아닌 뒤쪽으로 보냄,  다른 스레드에서 동작. 큰데이터, 이미지를 처리하는건 백그라운드에서 하고 메인화면에 출력해주어야 좋다
        OperationQueue().addOperation {
             let imageData : Data = try! Data.init(contentsOf: imageURL) //1번
                   let image : UIImage = UIImage(data: imageData)!
                   
                  // self.imageView.image = image
            //멈추는건 멈췄지만 이미지는 메인스레드에서만 사용해야한다는 경고문이 사용됨, ui와 관련된코드들은 메인스레드에서 동작해야함
            OperationQueue.main.addOperation { // 작업이 끝나게 되면 메인스레드로 가져와서 코드 실행
                self.imageView.image = image
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

