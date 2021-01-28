//
//  MapkitViewController.swift
//  CustomCode4
//
//  Created by 류진혁 on 2021/01/28.
//  Copyright © 2021 Jin-Hyuck. All rights reserved.
//

import UIKit
import MapKit

class MapkitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let mapkitView = MKMapView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.view = mapkitView
        //알림창에 표현되는 contentVC의 크기 설정
        self.preferredContentSize.height = 200
        
        //위도 경도 설정
        let pos = CLLocationCoordinate2D(latitude: 35.9268328, longitude: 128.5478336)
        //축척설정. 숫자가 작을수록 좁은 범위를 확대시켜서 보여준다.
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        //지도 영역 설정
        let region = MKCoordinateRegion(center: pos, span: span)
        //지도에 표시
        mapkitView.region = region
        //지도의 같은 지점에 여전히 중앙에 있지만 범위 값이지도보기의 프레임에 맞게 조정되는 영역
        mapkitView.regionThatFits(region)
        //핀 설정
        let point = MKPointAnnotation()
        point.coordinate = pos
        mapkitView.addAnnotation(point)

    }
    


}
