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
        
        //문제가 있는코드
        guard let imageURL: URL = URL(string: friend.picture.thumbnail) else{ return cell}
        guard let imageData : Data = try? Data(contentsOf: imageURL) else{return cell}
        cell.imageView?.image = UIImage(data: imageData)
        
        return cell
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //url 요청
        guard let url : URL = URL(string:"https://randomuser.me/api/?results=20&inc=name,email,picture") else{return}
        
        //세션생성
        let session : URLSession = URLSession(configuration: .default)
        //데이터테스크 생성. url로 요청/ { 뒤에 클로저는 요청에 대한 서버의 응답이 왓을때 호출될 클로저. 서버에서 보내준 데이터. 그곳의 응답. 오류가 발생하면
        let datatask : URLSessionDataTask = session.dataTask(with: url) { (data: Data?, reponse: URLResponse?, error : Error?) in
            if let error = error {
                print(error.localizedDescription)
                return
        }
            //받아온 데이터를 디코더함
            guard let data = data else{return}
            
            do{
                let apiResponse : APIResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                self.friends = apiResponse.results
                //reloadData는 메인스레드에서 동작해주어야 하는 지금 클로저는 메인스레드에서 동작하지않음/ 많은 데이터가 올시 오류가 생길수 있으니 백그라운드에서 동작하도록 수정해주어야함
                self.tableVIew.reloadData()
            }catch(let err){
                print(err.localizedDescription)
            }
        }
        //데이터 테스크를 실행하고 서버에 요청하게됨. 클로저는 당장실행할 코드가 아니라 요청에 대한 응답이 왔을때 실행하는것
        //실질적으로 viewDidAppear에서 동작하는 것은 session, datatask resume 임
        datatask.resume()
    }
    

}

