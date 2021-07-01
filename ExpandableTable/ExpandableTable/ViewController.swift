//
//  ViewController.swift
//  ExpandableTable
//
//  Created by 류진혁 on 2021/02/24.
//  Copyright © 2021 Jin-Hyuck. All rights reserved.
//

import UIKit
import ExpyTableView

class ViewController: UIViewController,ExpyTableViewDelegate, ExpyTableViewDataSource {
    
    let arraySection0 : Array<String> = ["0","1","2","3"]
    let arratySection1 : Array<String> = ["4","5","6","7"]
    
    func tableView(_ tableView: ExpyTableView, expyState state: ExpyState, changeForSection section: Int) {
        print("\(section)섹션")
    }
    
    func tableView(_ tableView: ExpyTableView, canExpandSection section: Int) -> Bool {
        true
    }
    
    func tableView(_ tableView: ExpyTableView, expandableCellForSection section: Int) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .systemRed
        cell.selectionStyle = .none
        
        if section == 0{
            cell.textLabel?.text = arraySection0[0]
        }else{
            cell.textLabel?.text = arratySection1[0]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return arraySection0.count
        }else{
            return arratySection1.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
  
        
        if indexPath.section == 0{
            cell.textLabel?.text = arraySection0[0]
        }else{
            cell.textLabel?.text = arratySection1[0]
        }
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
    }

    @IBOutlet weak var myTableView: ExpyTableView!
    
}

