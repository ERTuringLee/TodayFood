//
//  HomeViewController.swift
//  TodayFood
//
//  Created by 이재문 on 2023/02/25.
//

import UIKit
import CoreLocation

class HomeViewController: BaseViewController {
    @IBOutlet weak var mapView: UIView!
    var kakaoMap: MTMapView?
    var locationManager = CLLocationManager()
    var isLocationAuthorize = false

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        kakaoMap?.refreshMapTiles()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        kakaoMap = MTMapView(frame: self.mapView.frame)
        
        isLocationAuthorize = self.locationManager.authorizationStatus == .authorizedWhenInUse || self.locationManager.authorizationStatus == .authorizedAlways
                
        if let mapView = kakaoMap {
            // 델리게이트 연결
            mapView.delegate = self
            // 지도의 타입 설정 - hybrid: 하이브리드, satellite: 위성지도, standard: 기본지도
            mapView.baseMapType = .standard
            
            // 현재 위치 트래킹
            DispatchQueue.global().async {
                mapView.currentLocationTrackingMode = .onWithoutHeading
                mapView.showCurrentLocationMarker = true
            }
            
            self.mapView.addSubview(mapView)
        }
        
        guard self.isLocationAuthorize else {
            return
        }

        self.locationManager.startUpdatingLocation()
    }
    
    @IBAction func onTouchedLocationButton(_ sender: Any) {
        self.kakaoMap?.setMapCenter(MTMapPoint(geoCoord: self.currentLocation()), animated: true)
    }
    
    
    func currentLocation() -> MTMapPointGeo {
        return MTMapPointGeo(latitude: self.locationManager.location?.coordinate.latitude ?? 0, longitude: self.locationManager.location?.coordinate.longitude ?? 0)
    }
    
    func fetchRestaurantData() {
        let currentLocation = self.currentLocation()
        SearchService.shared.getLocalWithKeyword(x: currentLocation.latitude, y: currentLocation.longitude, page: 1)
            .subscribe(
                onSuccess: {
                    print("\($0)")
                },
                onFailure: {
                    print("\($0.localizedDescription)")
                }
            ).disposed(by: disposeBag)
    }
}

extension HomeViewController: MTMapViewDelegate, CLLocationManagerDelegate { }