//
//  ViewController.swift
//  FriendsCollection
//
//  Created by 류진혁 on 2020/08/24.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    var numberOfCell : Int = 10
    let cellIdentifier : String = "cell"
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numberOfCell    //10개의 셀을 만들겠다
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath)
        
        return cell
    }
    
    //컬렉션뷰의 아이템(셀)을 선택하면 셀의 갯수를 하나씩늘려주는
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //컬렉션뷰는 테이블뷰와 비슷하지만 테이블뷰에서는 indexPath.row 했던것을 indexPath.item 으로 사용하는것이 좀 다름
        self.numberOfCell += 1
        collectionView.reloadData()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

