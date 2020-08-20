//
//  ViewController.swift
//  PhotosExample
//
//  Created by 류진혁 on 2020/08/19.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import UIKit
import Photos //import

class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate,/*사진을 삭제하기위해선 딜리게이트 메소드가 필요*/PHPhotoLibraryChangeObserver/*라이브러리에 변화가 생기면 감지하겠다*/ {
    
    
    
    
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
        //  포토라이브러리가 변화될때마다 딜리게이트 메소드가 실행
        PHPhotoLibrary.shared().register(self)
        
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
    
    //테이블 뷰 로우를 편집하게 해줌
      func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
          return true
      }
      //편집을 하려고 할때
      func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
          //편집이 삭제냐
          if editingStyle == .delete{
              let asset: PHAsset = self.fetchResult[indexPath.row]
              
              PHPhotoLibrary.shared().performChanges({
                  PHAssetChangeRequest.deleteAssets([asset] as NSArray)
              }, completionHandler: nil) //딜리트할거야. 삭제창을 띄움
          }
      }
    
    /*PHPhotoLibraryChangeObserver에 의해 생성. 포토라이브러리가 바뀌면 호출될 메서드*/
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let chahges = changeInstance.changeDetails(for: fetchResult) else {
            return
        }
        //어떤게 바뀌었는지
        fetchResult = chahges.fetchResultAfterChanges
        
        OperationQueue.main.addOperation {
            self.tableView.reloadSections(IndexSet(0...0), with: .automatic)
        }//바뀌면 테이블뷰를 다시 불러달라
    }
    
    //네이게이션 컨트롤러가 동작하기전에 호출. 데이터를 전달해준다음에 다음화면에 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController: ImageZoomViewController = segue.destination as? ImageZoomViewController else {
            return
        }
        guard let cell: UITableViewCell = sender as? UITableViewCell else {
            return
        }
        guard let index:IndexPath = self.tableView.indexPath(for: cell) else {
            return
        }
        nextViewController.aseet = self.fetchResult[index.row]
    }
    
    
    }




