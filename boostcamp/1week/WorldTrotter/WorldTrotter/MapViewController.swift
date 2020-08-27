//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by 류진혁 on 2020/08/26.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    
    var mapView : MKMapView!
    var currentLocation : UIButton!
    var zoom : UIButton!
    var rotatePin : UIButton!

    override func loadView() {
        //지도뷰 생성
        mapView = MKMapView()
        //지도뷰를 이 뷰 컨트롤로의 뷰로 설정
        view = mapView
        
        //지도의 타입을 설정하는 버튼 만들기. 기본,위성, 복합,
       let segmentedControl = UISegmentedControl(items: ["Standard","Hybrid","Satellite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        //addtarget: 버튼이 클릭되었을때 selector에 있는 함수가 호출됨
        segmentedControl.addTarget(self, action: #selector(mapTypeChanged), for: .valueChanged)
        
        //콘스트레인트 레이아웃제약조건
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        //지도뷰에 segmentedControl버튼 추가
        view.addSubview(segmentedControl)
        
        //콘스트레인트 레이아웃주기
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        //현재 위치표시, 줌 버튼 추가
        currentLocation = UIButton()
        zoom = UIButton()
        currentLocation.setTitle("현재위치", for: .normal)
        zoom.setTitle("확대", for: .normal)
        currentLocation.setTitleColor(UIColor.red, for: .normal)
        zoom.setTitleColor(UIColor.red, for: .normal)
        
        currentLocation.translatesAutoresizingMaskIntoConstraints = false
        zoom.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(currentLocation)
        view.addSubview(zoom)
        
        currentLocation.addTarget(self, action: #selector(showCurrentLocation), for: .touchUpInside)
        zoom.addTarget(self, action: #selector(zoomIn), for: .touchUpInside)
        
        //현재위치, 줌 버튼에 대한 제약조건추가
        currentLocation.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        currentLocation.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        zoom.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        zoom.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("MapViewController loaded its view")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func mapTypeChanged(segcontrol : UISegmentedControl){
        switch segcontrol.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    //현재위치 표기
    var locationManager:CLLocationManager!
    
    @objc func showCurrentLocation(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        //지도 접근권한 요청
        let status = CLLocationManager.authorizationStatus()
        if status == .notDetermined{
            locationManager.requestWhenInUseAuthorization()
        }
        if status == .authorizedWhenInUse{
            locationManager.requestLocation()
        }
        return
        
    }
    //확대
    @objc func zoomIn(){
        guard let location = locationManager.location else {
            return
        }
        //latitude: 위도. longitude:경도
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span:
            MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.setRegion(region, animated: true)
        
        
        
    }

}
