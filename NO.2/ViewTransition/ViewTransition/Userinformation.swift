//
//  Userinformation.swift
//  ViewTransition
//
//  Created by 류진혁 on 2020/08/05.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import Foundation

class UserInfomation{
    static let shared : UserInfomation = UserInfomation()
    
    var name : String?
    var age : String?
    
}

// 싱글톤 주의점 : shared같은 쉬운 이름을쓰면 해킹의 위험이 존재


