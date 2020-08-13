//
//  ViewController.swift
//  SimpleTable
//
//  Created by 류진혁 on 2020/08/12.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableVieW : UITableView!
    let cellIdentifiel : String = "cell"
    let customcellIdentifiel : String = "customCell"
    
    let korean: [String] = ["가","나","다","라","마","바","사","아","자","차","카","타","파","하"]
    let english: [String] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    var dates : [Date] = []
    
    //날짜만 보여줌
    let dateFommater: DateFormatter = {
        let formmater: DateFormatter = DateFormatter()
        formmater.dateStyle = .medium
        return formmater
    }()
    //시간만 보여줌
    let timeFommater: DateFormatter = {
          let formmater: DateFormatter = DateFormatter()
          formmater.timeStyle = .medium
          return formmater
      }()
    
    //버튼을 누르면 dates에 추가됨
    @IBAction func touchUpAddButton(_sender:UIButton){
        dates.append(Date())
        
        /*데이터를 전체 다 불러와서 비효율적임
        self.tableVieW.reloadData()
         */
        //애니메이션 효과 추가
        self.tableVieW.reloadSections(IndexSet(2...2),with: UITableView.RowAnimation.automatic)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /*  스토리보드에서 테이블뷰와 스토리보드를 직접연결하지않고 이렇게 코드로 연결할수도 있다.
        self.tableVieW.delegate = self
        self.tableVieW.dataSource = self
         */
    }
    //몇개의 섹션을 만들것인가
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    //테이블뷰에 로우가 몇개여야하는지 알려달라
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return korean.count
        case 1:
            return english.count
        case 2:
            return dates.count
        default:
            return 0
        }
    }
    
    //로우마다 해당하는 셀을 돌려달라
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /* 섹션이 두개였을때
        let text : String = indexPath.section == 0 ? korean[indexPath.row]:
            english[indexPath.row]
            */
        if indexPath.section<2{
            /*기본으로 사용하는 셀 (커스텀하지않음)*/
            //dequeu: 큐에 쌓여있던 재샤용 큐를 다시 가져와 사용한다. 화면을 벗어나면 셀을 큐에 넣어두고 화면에 보여질때만 보여줌, 셀을 재사용하지않고 let cell : UITableViewCell =  uiTableViewCell()로 쓰면 메모리의 낭비가 이루어 진다.
            let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifiel, for: indexPath)
            let text : String = indexPath.section == 0 ? korean[indexPath.row]:
            english[indexPath.row]
             cell.textLabel?.text = text
            
            //두번째 셀에만 색칠하기
            if indexPath.row == 1{
                cell.backgroundColor = UIColor.red
            }else{  //이걸 쓰지않고 위에만쓰면 재사용할때마다 불러와져서 다른곳까지 빨간색으로 색칠됨
                cell.backgroundColor = UIColor.white
            }
            
            return cell
        }else{
            let cell : CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.customcellIdentifiel, for: indexPath) as! CustomTableViewCell
            //as!는 강제 캐스팅한것. dequeueReusableCell는 일반 셀에서 쓰는거라서 커스텀에서쓰려하면 오류가 나기때문
            
            /* 셀에 데이트 타입 값을 집어넣을때 기본형에서
            cell.textLabel?.text = self.dateFommater.string(from: self.dates[indexPath.row])
            */
            cell.leftLabel.text = self.dateFommater.string(from: self.dates[indexPath.row])
            cell.rightLabel.text = self.timeFommater.string(from: self.dates[indexPath.row])
            return cell
        }
       
    }
    
    //섹션에 타이틀 주기
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section>2{
            return section == 0 ? "한글" : "영어"
        }
        return nil
        
    }
}

