//
//  ViewController.swift
//  NewsApp
//
//  Created by 류진혁 on 2020/08/18.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    //news apikey : Your API key is: 0bc0da37a5704a0bbe013e015ad2de55
      //https://newsapi.org/v2/top-headlines?country=kr&category=business&apiKey=0bc0da37a5704a0bbe013e015ad2de55
    
    var newsData : Array<Dictionary<String,Any>>?
    
    @IBOutlet weak var tableViewMain: UITableView!
    
    
    func getNews(){
        let task = URLSession.shared.dataTask(with: URL(string: "https://newsapi.org/v2/top-headlines?country=kr&category=business&apiKey=0bc0da37a5704a0bbe013e015ad2de55")!/*!로 옵셔널을 강제로 벗겨냄*/) { (data, response, error) in
           //json데이터를 보기위해서 파싱(제이슨 데이터로 변환해야함)
            if let dataJson = data{
                do{
                    let json = try JSONSerialization.jsonObject(with: dataJson, options: []) as! Dictionary<String,Any> /*json을 딕셔너리형태로 바꾸어줌 앞에는 스트링 뒤에는 뭐가 올지 모름*/
                    //Dictionary
                   let articles = json["articles"] as! Array<Dictionary<String,Any>> //json에서 "articles"키를 가져와
                    print(articles)
                    self.newsData = articles
                    DispatchQueue.main.async { //백그라운드에서 도는 네트워크를 메인으로 돌려줘라
                        
                         self.tableViewMain.reloadData() // main
                    }
                   
                    /*
                    for(idx,value) in articles.enumerated(){
                        if let v = value as? Dictionary<String,Any>{
                           print("\(v["title"])")
                        }
                    }*/
                }
                catch{}
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let news = newsData{
            return news.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewMain.dequeueReusableCell(withIdentifier: "Type1", for: indexPath) as! Type1
        let idx = indexPath.row
        if let news = newsData{
            
            let row = news[idx]
            if let v = row as? Dictionary<String,Any>{
                if let title = v["title"] as? String {
                    cell.labelText.text = title
                }
                
            }
        }
       
        
        return cell
    }
    //1.옵션: 클릭감지
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("click")
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "NewsDetailController") as! NewsDetailController
        
        if let news = newsData{
            let row = news[indexPath.row]
            if let r = row as? Dictionary<String,Any>{
                if let imageUrl = r["urlImage"] as? String{
                    controller.imageUrl = imageUrl
                }
                if let desc = r["description"] as? String{
                    controller.desc = desc
                }
            }
        }
       //이동! - 수동!
     showDetailViewController(controller, sender: nil)
        
    }
    
    //2. 세그웨이: 부모자식관계에서 uicontoller에 있는 prepare함수를 가져다 와서사용
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier,"NewsDetail" == id{
            if let controller = segue.destination as? NewsDetailController{
                
             if let news = newsData{
                if let indexPath =  tableViewMain.indexPathForSelectedRow{
               
                    let row = news[indexPath.row]
                    if let r = row as? Dictionary<String,Any>{
                        if let imageUrl = r["urlImage"] as? String{
                            controller.imageUrl = imageUrl
                        }
                        if let desc = r["description"] as? String{
                            controller.desc = desc
                        }
                    }
                }
                }
                
            }
        }
        //이동! - 자동
    }
    //1. 상세화면 만들기
    //2. 값을 보내기
    //-1.tableview delegate , -2.storyboard(segue)(스토리보드에서 셀을 클릭해서 다음뷰컨트롤러에 끌어다놓기)
    //3. 화면이동 (이동하기전에 값을 미리 세팅해야한다.!!!)
  

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewMain.dataSource = self
        tableViewMain.delegate = self
        // Do any additional setup after loading the view.
        getNews()
    }


}

