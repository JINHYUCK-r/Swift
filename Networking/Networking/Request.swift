//
//  Request.swift
//  Networking
//
//  Created by 류진혁 on 2020/09/14.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import Foundation
//데이터를 받을때 사용하는 노티피케이션 이름 설정
let DidReceiveFriendsNotification: Notification.Name = Notification.Name("DidRecieveFriends")

func requestFriends(){
    
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
                //여기서 메인스레드로 호출해주면 viewController에서 dispatchqueue를 안해줘도됨
                //노피티케이션으로 데이터를 전송해줌
                NotificationCenter.default.post(name: DidReceiveFriendsNotification, object: nil, userInfo: ["friends":apiResponse.results])
                
                //기존의 컨트롤러에서 새롭게 옮겨오면 이렇게 사용할수가없음
                /*
                self.friends = apiResponse.results
                   //reloadData는 메인스레드에서 동작해주어야 하는 지금 클로저는 메인스레드에서 동작하지않음/ 많은 데이터가 올시 오류가 생길수 있으니 백그라운드에서 동작하도록 수정해주어야함
                    //self.tableVIew.reloadData()
                   //메인스레드로 가져가야할 코드는 dispatchqueue를 사용
                   DispatchQueue.main.async {
                       self.tableVIew.reloadData()
                   }
                    */
                  
               }catch(let err){
                   print(err.localizedDescription)
               }
           }
           //데이터 테스크를 실행하고 서버에 요청하게됨. 클로저는 당장실행할 코드가 아니라 요청에 대한 응답이 왔을때 실행하는것
           //실질적으로 viewDidAppear에서 동작하는 것은 session, datatask resume 임
           datatask.resume()
}
