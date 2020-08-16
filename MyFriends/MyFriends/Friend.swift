//
//  Friend.swift
//  MyFriends
//
//  Created by 류진혁 on 2020/08/16.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import Foundation


//불러올 json 데이터의 형식
struct Friend: Codable{
    
    struct Address: Codable{
        let country : String
        let city : String
    }
    
    let name : String
    let age : Int
    //address_info를 그냥 addressInfo로 바꿔주면 json데이터의 키값과 일치하지 않게되어서 밑에서 새로 정의해주어야함
    let addressInfo : Address
    
    var nameAndAge : String{
        return self.name + "(\(self.age))"
    }
    
    var fullAddress: String{
        return self.addressInfo.city + ","+self.addressInfo.country
    }
 
    //스위프트에서 _를 잘 안쓰기때문에 json데이터에서 매칭되지 않는 이름을 바꿔줌
    //ddress_info를 addressInfo로 이름 바꾸기
   enum CodingKeys: String, CodingKey{
         case name, age
        case addressInfo = "address_info"
      }
}
