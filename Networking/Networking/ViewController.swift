//
//  ViewController.swift
//  Networking
//
//  Created by 류진혁 on 2020/09/11.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableVIew : UITableView!
    let cellIdentifier : String = "friendCell"
    var friends : [Friend] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        let friend : Friend = self.friends[indexPath.row]
        
        cell.textLabel?.text = friend.name.full
        cell.detailTextLabel?.text = friend.email
        // 셀이 재사용되기 전에 초기화 시켜주어야함. 나중에 이미지를 가져오기전에 다른사람의 이미지를 표현하지 않게 하기 위해
        cell.imageView?.image = nil
        
        /*
        //문제가 있는코드
        guard let imageURL: URL = URL(string: friend.picture.thumbnail) else{ return cell}
        //imagaData는 동기메소드이기때문에 이미지를 전부 불러올때까지 화면이 멈추게 됨
        guard let imageData : Data = try? Data(contentsOf: imageURL) else{return cell}
        */
        //백그라운드에서 작업. 여기서 return cell을 하면 오류가 생김.
        DispatchQueue.global().async {
            guard let imageURL: URL = URL(string: friend.picture.thumbnail) else{ return }
             guard let imageData : Data = try? Data(contentsOf: imageURL) else{return }
            
           //작업된 결과를 메인스레드로 가져와서 동작
            DispatchQueue.main.async {
                //사용자가 화면을 움직이게되면 셀의 번호가 달라지기때문에 오류가 발생할수있음. 화면에 보여지는 셀의 인덱스를 번호를 맞춰주기 위한 코드, 서로 일치하는 상황에서만 구현
                if let index : IndexPath = tableView.indexPath(for: cell){
                    if index.row == indexPath.row{
                        cell.imageView?.image = UIImage(data: imageData)
                    }
                }
                
                
            }
        }
        //cell.imageView?.image = UIImage(data: imageData)
        
        return cell
        
    }
    
    //노티피케이션으로 전송해준 데이터를 받는 함수
    @objc func didRecieveFriendsNotification(_ noti : Notification){
        
        guard let friends:[Friend] = noti.userInfo?["friends"] as? [Friend] else {
            return
        }
        self.friends = friends
        
        //위에 메소드들은 백그라운드에서 작업하고있기때문에 메인스레드로 불러와 주어야함
        DispatchQueue.main.async {
            self.tableVIew.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //노티피케이션을 받음
        NotificationCenter.default.addObserver(self, selector: #selector(self.didRecieveFriendsNotification(_:)), name: DidReceiveFriendsNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        requestFriends()
       
    }
    

}

