//
//  ViewController.swift
//  FriendsCollection
//
//  Created by 류진혁 on 2020/08/24.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
   // var numberOfCell : Int = 10
    var friends:[Friend] = []
    let cellIdentifier : String = "cell"
    @IBOutlet weak var collectionView : UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // return self.numberOfCell    //10개의 셀을 만들겠다
        return self.friends.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:FriendCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! FriendCollectionViewCell //강제캐스팅은 좋지않음 고치는게 좋음
        let friend : Friend = self.friends[indexPath.item]
        
        cell.nameAgeLabel.text = friend.nameAndAge
        cell.adressLabel.text = friend.fullAddress
        
        return cell
    }
    
    /*//컬렉션뷰의 아이템(셀)을 선택하면 셀의 갯수를 하나씩늘려주는
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //컬렉션뷰는 테이블뷰와 비슷하지만 테이블뷰에서는 indexPath.row 했던것을 indexPath.item 으로 사용하는것이 좀 다름
        self.numberOfCell += 1
        collectionView.reloadData()
    }*/
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //json 데이터 불러와서 변환
        let jsonDecoder :JSONDecoder = JSONDecoder()
        guard let dataAsset : NSDataAsset = NSDataAsset(name: "friends") else {
            return
        }
        do{
            self.friends = try jsonDecoder.decode([Friend].self, from: dataAsset.data)
        }catch{
            print(error.localizedDescription)
        }
        self.collectionView.reloadData()

    }


}
