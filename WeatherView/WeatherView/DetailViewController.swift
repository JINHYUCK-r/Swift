//
//  DetailViewController.swift
//  WeatherView
//
//  Created by 류진혁 on 2020/08/18.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier : String = "cell"
    var weather:[Weather]=[]
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weather.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
           return cell
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        let jsonDecoder : JSONDecoder = JSONDecoder()
        
        guard let dataAsset : NSDataAsset = NSDataAsset(name: "jp") else{
            return
            
        }
        
        do{
            self.weather = try jsonDecoder.decode([Weather].self,from:dataAsset.data)
        }catch{
            
        }
        self.tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
