//
//  ViewController.swift
//  noting
//
//  Created by 류진혁 on 2020/08/06.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var tableViewMain : UITableView!
    @IBOutlet weak var labelText : UILabel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewMain.dequeueReusableCell(withIdentifier: "Type1", for: IndexPath) as! Type1
        
        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        //클릭시 구현되는 소스
    }
    
  
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableViewMain.delegate = self
        tableViewMain.dataSource = self
        
    }


}

