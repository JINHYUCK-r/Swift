//
//  ViewController.swift
//  MyFriends
//
//  Created by 류진혁 on 2020/08/16.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource {

    @IBOutlet weak var tableView : UITableView!
    let cellIdentifier: String = "cell"
    var friends: [Friend] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        let friend: Friend = self.friends[indexPath.row]
        
        //셀에다가 데이터 넣기
        /* Friend에 새롭게 정의하고 이름 바꾸지 않았을때는 이렇게 써야함
        cell.textLabel?.text = friend.name + "(\(friend.age))"
        cell.detailTextLabel?.text = friend.address_info.city + "," + friend.address_info.country
        */
        //새롭게 정의해서 깔끔한 코드가 되었음
        cell.textLabel?.text = friend.nameAndAge
        cell.detailTextLabel?.text = friend.fullAddress
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //json 데이터를 불러와서 프렌즈 배열에 넣기
        //제이슨 디코더 사용
        let jsonDecoder: JSONDecoder = JSONDecoder()
        //가져올 데이터 에셋을 불러옴
        guard let dataAsst: NSDataAsset = NSDataAsset(name: "friends") else{
            return
        }
        
        do{
            self.friends = try jsonDecoder.decode([Friend].self,from:dataAsst.data)
        }catch{
            print(error.localizedDescription)
        }
        self.tableView.reloadData()
    }


}

