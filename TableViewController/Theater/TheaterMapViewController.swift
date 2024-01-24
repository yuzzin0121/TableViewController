//
//  TheaterMapViewController.swift
//  TableViewController
//
//  Created by 조유진 on 1/15/24.
//

import UIKit
import MapKit
import CoreLocation

class TheaterMapViewController: UIViewController, ViewProtocol {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var currentLocationButton: UIButton!
    let theaterList = TheaterList.mapAnnotations    // original Theater List
    
    var selectedTheater: TheaterName = .total {     // 선택된 영화관 이름
        didSet {
            mapView.removeAnnotations(annotations)
            setList()
            createAnnotation()
        }
    }
    var selectedTheaterList: [Theater] = TheaterList.mapAnnotations   // 선택된 영화관들
    var annotations: [MKAnnotation] = []    // 맵뷰에 추가될 annotation들
    let locationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D? = nil
    let seedQubeLocation = CLLocationCoordinate2D(latitude: 37.654165, longitude: 127.049696)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        locationManager.delegate = self
        designView()
        checkDeviceLocationAuthorization()
        let coordinate = CLLocationCoordinate2D(latitude: 37.554921, longitude: 126.970345) // 위, 경도 값을 가지고 오기

        // mapview에 보여질 지역 반경 설정
        setRegion(center: coordinate, meters: 16000)
                     
        selectedTheater = .total
        setList() // 선택된 영화관 이름에 일치하는 데이터 가져오기
        createAnnotation()  // 해당 데이터들을 맵뷰에 어노테이션으로 추가하기
    }
    
    func designView() {
        currentLocationButton.configuration = .locationStyle()
    }
    
    @IBAction func currentLocationButtonClicked(_ sender: UIButton) {
        checkDeviceLocationAuthorization()
    }
    
    // 어노테이션 만들어서 맵뷰에 추가
    func createAnnotation() {
        annotations = []
        for item in selectedTheaterList {
            let coordinate = CLLocationCoordinate2D(latitude: item.latitude, 
                                                    longitude: item.longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = item.location
            annotations.append(annotation)
        }
        DispatchQueue.main.async {
            self.mapView.addAnnotations(self.annotations)
            if let coordinate = self.annotations.last?.coordinate {
                self.setRegion(center: coordinate, meters: 13000)
            }
            
        }
    }
    
    // selectedTheaterList에 일치하는 데이터 가져오기
    func setList() {
        selectedTheaterList = getSelectedList(name: selectedTheater)
    }
    
    // 선택한 영화관 종류에 해당하는 아이템 추가
    func getSelectedList(name: TheaterName) -> [Theater] {
        print(#function)
        var list: [Theater] = []
        
        if name == .total {
            list = theaterList
        } else {
            for item in theaterList {
                if item.type == name.rawValue {
                    list.append(item)
                }
            }
        }

        return list
    }
    
    // navigation bar 설정
    func configureView() {
        navigationItem.title = "영화관 지도"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(alertActionSheet))
    }
    
    // 액션시트 띄우기 (메가박스, 롯데시네마, CGV, 전체보기)
    @objc func alertActionSheet() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        [UIAlertAction(title: TheaterName.Mega.rawValue, style: .default) { _ in
            self.setTheaterName(.Mega)
        },
         UIAlertAction(title: TheaterName.Lotte.rawValue, style: .default) { _ in
            self.setTheaterName(.Lotte)
         },
         UIAlertAction(title: TheaterName.CGV.rawValue, style: .default) { _ in
            self.setTheaterName(.CGV)
        },
         UIAlertAction(title: TheaterName.total.rawValue, style: .default) { _ in
            self.setTheaterName(.total)
        }].forEach {
            alert.addAction($0)
        }
        present(alert, animated: true)
    }
    
    // 영화관 이름 선택하기
    func setTheaterName(_ name: TheaterName) {
        selectedTheater = name
    }
    
}

extension TheaterMapViewController {
    // 지도에 보여질 위치 설정
    func setRegion(center: CLLocationCoordinate2D, meters: CLLocationDistance = 10000) {
        // 지도 중심 기반으로 보여질 범위 설정
        let region = MKCoordinateRegion(center: center, latitudinalMeters: meters, longitudinalMeters: meters)
        mapView.setRegion(region, animated: true)
    }
    
    // 1. 사용자에게 권한 요청을 하기 위한 iOS 위치 서비스 활성화 여부 체크
    func checkDeviceLocationAuthorization() {
        // UI와 직결되지 않은 부분은 global 처리
        DispatchQueue.global().async {
            // 현제 사용자의 위치 서비스 On / Off 체크
            if CLLocationManager.locationServicesEnabled() {    // On일 경우
                let authorization: CLAuthorizationStatus
                
                if #available(iOS 14.0, *) {    // iOS 14 이상
                    authorization = self.locationManager.authorizationStatus
                } else {   // iOS 13 이하
                    authorization = CLLocationManager.authorizationStatus()
                }
                
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization(status: authorization)   // 권한상태 전달
                }
            } else {
                print("위치 서비스가 꺼져있어서, 위치 권한 요청을 할 수 없어요.")  // print로 대체하는 부분은 사용자에게 알려줘야 되는 부분이당
            }
        }
    }
    
    // 2. 사용자 위치 권한 상태 확인 후, 권한 요청
    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:  // 앱을 처음 켰을 때 아직 권한이 결정되지 않은 상태 or 한번 허용하고 다시 켰을 때
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.requestWhenInUseAuthorization()
        case .denied:   // 허용 안함
            self.setRegion(center: self.seedQubeLocation, meters: 1000)
            showAlert(title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요", actionTitle: "설정으로 이동") {
                self.showSetting()
            } cancelHandler: {
                self.setRegion(center: self.seedQubeLocation, meters: 1000)
            }
        case .authorizedWhenInUse:  // 앱을 사용하는 동안 허용 or 한번만 허용
            locationManager.startUpdatingLocation()
        default:
            print("Error")
        }
    }
    
    // 설정 화면으로 이동
    func showSetting() {
        if let setting = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(setting)
        } else {
            print("수동으로 설정 화면 가야함")
        }
    }
}


extension TheaterMapViewController: CLLocationManagerDelegate {
    // 5. 사용자의 위치를 성공적으로 가지고 온 경우 실행
    // didUpdateLocations - startUpdatingLocation() 호출한 이후 불려진다
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 실패했을 떄 default 위치를 설정하거나
        print(locations)
        
        if let coordinate = locations.last?.coordinate {
            print(coordinate)
            print(coordinate.latitude)
            print(coordinate.longitude)
            // 날씨 API 호출
            setRegion(center: coordinate)
            currentLocation = coordinate
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    // iOS 14 이상
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkDeviceLocationAuthorization()
    }
    
    // iOS 13 이하
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
        checkDeviceLocationAuthorization()
    }
}
