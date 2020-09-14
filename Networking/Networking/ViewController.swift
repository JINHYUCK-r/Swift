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
        //데이터테스크 생성. url로 요청/ { 뒤에 클로저는 요청에 대한 서버의 응답이 왓을때 호출될 클로저. 서버에서 보내준 데이터. 그곳의 응답. 오류가 발생하면/ 클로저는 백그라운드에서 작업됨
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
                 //self.tableVIew.reloadData()
                //메인스레드로 가져가야할 코드는 dispatchqueue를 사용
                DispatchQueue.main.async {
                    self.tableVIew.reloadData()
                }
               
            }catch(let err){
                print(err.localizedDescription)
            }
        }
        //데이터 테스크를 실행하고 서버에 요청하게됨. 클로저는 당장실행할 코드가 아니라 요청에 대한 응답이 왔을때 실행하는것
        //실질적으로 viewDidAppear에서 동작하는 것은 session, datatask resume 임
        datatask.resume()
    }
    

}

