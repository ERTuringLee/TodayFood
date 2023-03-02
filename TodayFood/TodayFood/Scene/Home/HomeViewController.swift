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
    var poiItems:[MTMapPOIItem] = []
    var restorants:[LocalKeyword.Document] = []

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
    
    @IBAction func onTouchedRecommendButton(_ sender: Any) {
        self.fetchRestaurantData()
    }
    
    @IBAction func onTouchedShareButton(_ sender: Any) {
        guard !self.restorants.isEmpty else {
            return
        }
        
        var restorantInfos = ""

        for restorant in self.restorants {
            let info = "\(restorant.place_name)\n\(restorant.road_address_name)\n\(restorant.place_url)\n\n"
            restorantInfos.append(contentsOf: info)
        }

        let activityVC = UIActivityViewController(activityItems: [restorantInfos], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
    
    func currentLocation() -> MTMapPointGeo {
        return MTMapPointGeo(latitude: self.locationManager.location?.coordinate.latitude ?? 0, longitude: self.locationManager.location?.coordinate.longitude ?? 0)
    }
    
    func fetchRestaurantData() {
        let currentLocation = self.currentLocation()
        let randomPage = Int.random(in: 0..<15)
        self.restorants.removeAll()
        self.poiItems.removeAll()
        self.kakaoMap?.removeAllPOIItems()
        
        SearchService.shared.getLocalWithKeyword(x: currentLocation.longitude, y: currentLocation.latitude, page: randomPage)
            .map(LocalKeyword.self)
            .subscribe(
                onSuccess: {
                    self.restorants = $0.documents
                    
                    for restorant in $0.documents {
                        let poiItem = MTMapPOIItem()
                        poiItem.itemName = restorant.place_name
                        poiItem.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: Double(restorant.y)!, longitude: Double(restorant.x)!))
                        poiItem.markerType = .redPin
                        self.poiItems.append(poiItem)
                    }

                    self.kakaoMap?.addPOIItems(self.poiItems)
                },
                onFailure: {
                    print("\($0.localizedDescription)")
                }
            ).disposed(by: disposeBag)
    }
}

extension HomeViewController: MTMapViewDelegate, CLLocationManagerDelegate { }
