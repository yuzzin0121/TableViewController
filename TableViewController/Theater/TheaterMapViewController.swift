//
//  TheaterMapViewController.swift
//  TableViewController
//
//  Created by 조유진 on 1/15/24.
//

import UIKit
import MapKit

class TheaterMapViewController: UIViewController, ViewProtocol {
    
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
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        let coordinate = CLLocationCoordinate2D(latitude: 37.554921, longitude: 126.970345) // 위, 경도 값을 가지고 오기

        // mapview에 보여질 지역 반경 설정
        mapView.setRegion(MKCoordinateRegion(center: coordinate,
                                             latitudinalMeters: 16000,
                                             longitudinalMeters: 16000),
                          animated: true)
        selectedTheater = .total
        setList() // 선택된 영화관 이름에 일치하는 데이터 가져오기
        createAnnotation()  // 해당 데이터들을 맵뷰에 어노테이션으로 추가하기
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
                    print("true, \(item.location)")
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


