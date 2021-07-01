//
//  SideBarViewController.swift
//  SideBarDIY
//
//  Created by 류진혁 on 2021/02/13.
//  Copyright © 2021 Jin-Hyuck. All rights reserved.
//

//왼쪽에서 열릴 사이드바화면 담당 
import UIKit

class SideBarViewController: UITableViewController {
    
    let titles = [
        "메뉴 01",
        "메뉴 02",
        "메뉴 03",
        "메뉴 04",
        "메뉴 05"
    ]
    let icons = [
        UIImage(named : "icon01.png"),
        UIImage(named : "icon02.png"),
        UIImage(named : "icon03.png"),
        UIImage(named : "icon04.png"),
        UIImage(named : "icon05.png")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //계정 정보를 담을 라벨
        let accountLabel = UILabel()
        accountLabel.frame = CGRect(x: 10, y: 30, width: self.view.frame.width, height: 30)
        accountLabel.text = "test01@naver.com"
        accountLabel.textColor = .white
        accountLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        //라벨이 담길 뷰
        let v = UIView()
        v.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70)
        v.backgroundColor = .brown
        v.addSubview(accountLabel)
        
        //테이블 헤더 뷰에 v를 등록
        self.tableView.tableHeaderView = v
        

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath : IndexPath) -> UITableViewCell{
        // 재사용 큐로부터 테이블 셀을 꺼내 온다. 스크롤시 필요할때마다 테이블목록을 가져옴
        // 큐는 내부적인 임시데이터 저장공간 : FIFO
        let id = "menucell" // 재사용 큐에 등록할 식별자
        //재사용 큐에 대기하고 있는 셀을 꺼낼때 호출 
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ??
            //재사용 큐를 위한 셀을 등록하는 작업
            UITableViewCell(style: .default, reuseIdentifier: id)
        
        // 타이틀과 이미지를 대입한다.
        cell.textLabel?.text = self.titles[indexPath.row]
        cell.imageView?.image = self.icons[indexPath.row]
        
        // 폰트 설정
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        
        return cell
    }

}
