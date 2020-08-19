//
//  ViewController.swift
//  PhotosExample
//
//  Created by 류진혁 on 2020/08/19.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import UIKit
import Photos //import

class ViewController: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView : UITableView!
    var fetchResult : PHFetchResult<PHAsset>!
    let imageManager : PHCachingImageManager = PHCachingImageManager() //가져온 에셋을 가지고 이미지 로드
    let cellIdentifier : String = "cell"
    
    func requestConllection(){
        //카메라롤 콜렉션을 가져옴
        let cameraRoll : PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        
        guard let cameraRollCollection = cameraRoll.firstObject else {
            return
        }
        //사진을 가져오기
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)] //최신순으로 정렬
        self.fetchResult = PHAsset.fetchAssets(in: cameraRollCollection, options: fetchOptions)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //사용자가 사진첩의 접근허가 판단
        let photoAurhorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAurhorizationStatus {
        case .authorized:
            print("접근허가됨")
            self.requestConllection()
            self.tableView.reloadData()
        case .denied:
            print("접근불허")
        case .notDetermined:
            print("아직 응답하지않음")
            //사용자가 아직 설정하지않으면 해달라고 리퀘스트 요청
            PHPhotoLibrary.requestAuthorization( { (status) in
                switch status{
                case .authorized:
                    print("사용자가 허가함")
                    self.requestConllection()
                    OperationQueue.main.addOperation { //밑에 오류코드를 이안에 넣으면 오류가 사라짐
                        self.tableView.reloadData()
                    }
                    /*
                    self.tableView.reloadData()
                    //실행하면 UITableView.reloadData() must be used from main thread only 라는 오류가 생김*/
                case .denied:
                    print("사용자가 불허함")
                default:
                    break
                }
            })
        case .restricted:
            print("접근제한")
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchResult?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        //인덱스에 해당하는 녀석
        let asset : PHAsset = fetchResult.object(at: indexPath.row)
        
       //이미지를 요청
        imageManager.requestImage(for: asset, targetSize: CGSize(width: 30, height: 30), contentMode: .aspectFit, options: nil, resultHandler: { image, _ in cell.imageView?.image = image}) // 셀의 이미지뷰에 이미지를 넣고
        return cell //셀을 반환
        
        }
    }




