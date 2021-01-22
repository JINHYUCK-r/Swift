//
//  NewSceneDelegate.swift
//  CustomCode2
//
//  Created by 류진혁 on 2021/01/21.
//  Copyright © 2021 Jin-Hyuck. All rights reserved.
//

import UIKit

class NewSceneDelegate : UIResponder, UIWindowSceneDelegate{
    var window : UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let tbC = UITabBarController()
        //하얀색으로 설정해주지않으면 검은색이 그대로 드러남
        tbC.view.backgroundColor = .white
        self.window?.rootViewController = tbC
        let view01 = ViewController()
        let view02 = SecondViewController()
        let view03 = ThirdViewController()
        
        tbC.setViewControllers([view01,view02,view03], animated: false)
        
        view01.tabBarItem = UITabBarItem(title: "Calendar", image: UIImage(named: "calendar"), selectedImage: nil)
        view02.tabBarItem = UITabBarItem(title: "file", image: UIImage(named: "file-tree"), selectedImage: nil)
        view03.tabBarItem = UITabBarItem(title: "photo", image: UIImage(named: "photo"), selectedImage: nil)
    }
}
