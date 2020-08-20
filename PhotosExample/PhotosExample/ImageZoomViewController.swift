//
//  ImageZoomViewController.swift
//  PhotosExample
//
//  Created by 류진혁 on 2020/08/20.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import UIKit
import Photos

class ImageZoomViewController: UIViewController, UIScrollViewDelegate{
    
    var aseet: PHAsset!
    let imageManager : PHCachingImageManager = PHCachingImageManager()
    
    @IBOutlet weak var imageView : UIImageView!
    
    //스크롤뷰 딜리게이트 메소드
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 메모리에 화면이 호출되면에셋에서 이미지를 요청해달라
        imageManager.requestImage(for: aseet, targetSize: CGSize(width: aseet.pixelWidth, height: aseet.pixelHeight), contentMode: .aspectFit, options: nil, resultHandler:  { image, _ in
            self.imageView.image = image
        })
        
        
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
