//
//  ListViewController.swift
//  CustomCode4
//
//  Created by 류진혁 on 2021/01/28.
//  Copyright © 2021 Jin-Hyuck. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    //딜리게이트 객체. 사용자가 목록을 선택하면 이를 MapAlertViewController에 알려줄때 객체 참조정보를 저장해놓음 
    var delegate : MapAlertViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize.height = 220
      
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row)번째 옵션입니다."
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        return cell
    }
    
    //사용자가 셀을 선택하면 안의 메소드가 실행 -> 딜리게이트로 등록되어있는 MapAlertViewController에 정의된 메소드 호출
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectRowAt(indexPath:indexPath)
    }



}
