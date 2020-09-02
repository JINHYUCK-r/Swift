//
//  ViewController.swift
//  TodoApp
//
//  Created by 류진혁 on 2020/09/02.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource {
    
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

