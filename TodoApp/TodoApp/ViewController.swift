//
//  ViewController.swift
//  TodoApp
//
//  Created by 류진혁 on 2020/09/02.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController,UITableViewDataSource {
    
    //ref 는 내 firebase데이터베이스의 주소가 저장될 변수
    var ref : DatabaseReference!
    
    @IBOutlet weak var tableView: UITableView!
    
    var todos = [String]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
        cell.textLabel!.text = self.todos[indexPath.row]
        return cell
    }
    
    @IBAction func addToDo(_ sender: Any) {
       let dialog = UIAlertController(title: "새 할일 추가", message: nil, preferredStyle: .alert)
        dialog.addTextField()
        let okAction = UIAlertAction(title: "확인", style: .default) { (action : UIAlertAction) in
            if let newTodo = dialog.textFields?[0].text {
                self.todos.append(newTodo)
                self.tableView.reloadData()
                
                //ref에 내 firebase 주소를 넣어줌
                self.ref = Database.database().reference()
                //itemRef는 위 데이터베이스의 위치(ref)의 child라고 하네요.
                //child는 지정된 상대 경로에있는 위치의 주소를 가져오는 프로퍼티
                //list라는 이름으로 밑에 데이터들이 저장됨
                //"list/firebaseTest/zedd"이런식으로 하위경로도 설정가능
                let itemRef = self.ref.child("list")
                //데이터 베이스에 값을 넣음
                itemRef.setValue(self.todos)
            }
            
        }
        
        let cancelAntion = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        dialog.addAction(okAction)
        dialog.addAction(cancelAntion)
        self.show(dialog,sender: nil)

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

