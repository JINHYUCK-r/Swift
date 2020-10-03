//
//  ViewController.swift
//  msg_Notification
//
//  Created by 류진혁 on 2020/10/03.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController{
    
    
   

    
    @IBOutlet weak var msg: UITextField!
    
    
    @IBOutlet weak var datepicker: UIDatePicker!
    
    
    override func viewDidLoad() {
              super.viewDidLoad()
             
           //알림 동의 여부 확인
               UNUserNotificationCenter.current().requestAuthorization(options: [.alert], completionHandler: { (didAllow, error) in
                     })
                     UNUserNotificationCenter.current().delegate = self
              // Do any additional setup after loading the view.
          }
    
    @IBAction func save(_ sender: Any) {
        if #available(iOS 10.0, *){
            UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                if settings.authorizationStatus == UNAuthorizationStatus.authorized{
                    DispatchQueue.main.async {
                        let nContent = UNMutableNotificationContent()
                        nContent.body = (self.msg.text)!
                        nContent.title = "미리 알림"
                        nContent.sound = UNNotificationSound.default
                        
                        //발송시각을 지금으로부터 *초형식으로 바꿈
                        let time = self.datepicker.date.timeIntervalSinceNow
                        
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
                        
                        let request = UNNotificationRequest(identifier: "alram", content: nContent, trigger: trigger)
                        
                        
                        UNUserNotificationCenter.current().add(request){(_) in
                            DispatchQueue.main.async {
                                let date = self.datepicker.date.addingTimeInterval(9*60*60)
                                let message = "알람이 등록되었습니다. 등록된 알람은 \(date)에 발송됩니다."
                                
                                let alert = UIAlertController(title: "알람등록", message: message, preferredStyle: .alert)
                                let ok = UIAlertAction(title: "확인", style: .default)
                                alert.addAction(ok)
                                self.present(alert, animated: true)
                            }
                            
                        }
                    }
                    
                }else{
                    let alert = UIAlertController(title: "알림등록", message: "알림이 허용되어있지 않습니다.", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "확인", style: .default)
                    alert.addAction(ok)
                    
                    self.present(alert, animated: true)
                    return
                }
            }
        }
        
    }
    
 
    
   
    @IBAction func buttonpressed(_ sender: Any) {
                
                //알림 컨텐츠 객체
                    let content = UNMutableNotificationContent()
                    content.badge = 1
                    content.title = "Notification"
                    content.subtitle = "This is Notification Test"
                    content.body = "Test Body"
        
                    // 알림 발송 조건 객체
                    let TimeIntervalTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
                    
                  // 알림 요청 객체
                    let request = UNNotificationRequest(identifier: "Notification", content: content, trigger: TimeIntervalTrigger)
        
                    //노티피케이션 센터에 추가
                    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                    
                
            }
            
        }

        extension ViewController : UNUserNotificationCenterDelegate {
            //To display notifications when app is running  inforeground
            
            //앱이 실행중일때도 알림메세지를 보여줌
            //viewDidLoad()에 UNUserNotificationCenter.current().delegate = self를 추가해주는 것을 잊지마세요.
            func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
                //알림 배너 띄워주기
                completionHandler([.alert, .sound, .badge])
            }
            
            //알람을 선택했을때 발생하는 이벤트
            func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
                let settingsViewController = UIViewController()
                settingsViewController.view.backgroundColor = .gray
                self.present(settingsViewController, animated: true, completion: nil)
                
            }
        }

