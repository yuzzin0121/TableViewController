//
//  CityInfoViewController.swift
//  TableViewController
//
//  Created by 조유진 on 1/10/24.
//

import UIKit

class CityInfoViewController: UIViewController, CollectionViewLayoutProtocol {
    
    let cityList = CityInfo.cityList    // original City List
    let searchController = UISearchController(searchResultsController: nil)
    
    var allList: [City] = CityInfo.cityList // 모두
    var domesticList: [City] = []   // 국내
    var noDomesticList: [City] = [] // 해외
    
    var list: [City] = CityInfo.cityList {  // 테이블뷰에 보여줄 list
        didSet {
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        
        domesticList = getList(isDomestic: true)    // 국내 도시 리스트 설정
        noDomesticList = getList(isDomestic: false) // 해외 도시 리스트 설정
        configurationSearchController()
        setCollectionViewFlowLayout()
    }
    
    // 뷰 클릭 시 키보드 내리기
    @IBAction func didTapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // searchController 설정
    func configurationSearchController() {
        self.navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "도시 이름을 검색해보세요"
        self.navigationItem.hidesSearchBarWhenScrolling = false // 스크롤할 때도 서치바 보이기
        searchController.searchBar.delegate = self
    }
    
    // collectionview 설정
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        let xib = UINib(nibName: CityInfoCollectionViewCell.identifier, bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: CityInfoCollectionViewCell.identifier)
    }
    
    // collectionview 설정
    func setCollectionViewFlowLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 24
        
        let cellWidth = UIScreen.main.bounds.width - (spacing*2)
        
        layout.itemSize = CGSize(width: cellWidth / 2, height: (cellWidth/2) * 1.5)
        layout.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .vertical
        
        collectionView.collectionViewLayout = layout
    }

    // 국내 or 해외 리스트 가져오기
    func getList(isDomestic: Bool) -> [City]{
        var list: [City] = []
        for city in cityList {
            if city.domestic_travel == isDomestic {
                list.append(city)
            }
        }
        return list
    }

    // 세그먼트 인덱스 변경시 호출
    @IBAction func changeIndex(_ sender: UISegmentedControl) {
        collectionView.reloadData() // 리로드
        searchBar(searchController.searchBar, textDidChange: searchController.searchBar.text!)
    }
    
    func setList()  {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            list = CityInfo.cityList
        case 1:
            list = domesticList
        case 2:
            list = noDomesticList
        default:
            print("오류")
        }
    }
    
    func getFilteredList(_ list: [City], keyword: String) -> [City] {
        var filterlist: [City] = []
        
        for item in list {
            if item.city_name.contains(keyword) || item.city_english_name.contains(keyword) || item.city_explain.contains(keyword) {
                filterlist.append(item)
            }
            else if item.city_name.lowercased().contains(keyword) || item.city_english_name.lowercased().contains(keyword) || item.city_explain.lowercased().contains(keyword) {
                filterlist.append(item)
            } else if item.city_name.uppercased().contains(keyword) || item.city_english_name.uppercased().contains(keyword) || item.city_explain.uppercased().contains(keyword) {
                filterlist.append(item)
            }
        }
        
        return filterlist
    }
}

extension CityInfoViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchController.searchBar.text!
        let trimText = text.components(separatedBy: [" "]).joined()
        
        if trimText == "" {
            setList()
        } else {
            switch segmentedControl.selectedSegmentIndex {
            case 0:
                list = getFilteredList(allList, keyword: trimText)
            case 1:
                list = getFilteredList(domesticList, keyword: trimText)
            case 2:
                list = getFilteredList(noDomesticList, keyword: trimText)
            default:
                print("오류")
            }
        }
    }
    
    // 검색 버튼 눌렀을 때
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = searchController.searchBar.text!
        let trimText = text.components(separatedBy: [" "]).joined()
        
        if trimText == "" {
            setList()
        } else {
            switch segmentedControl.selectedSegmentIndex {
            case 0:
                list = getFilteredList(allList, keyword: trimText)
            case 1:
                list = getFilteredList(domesticList, keyword: trimText)
            case 2:
                list = getFilteredList(noDomesticList, keyword: trimText)
            default:
                print("오류")
            }
        }
    }
    
    // 검색 취소 버튼 눌렀을 때
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        setList()
    }
}

extension CityInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityInfoCollectionViewCell.identifier, for: indexPath) as! CityInfoCollectionViewCell
 
        cell.configureCell(item: list[indexPath.row])
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        
        let TravelVC = mainSB.instantiateViewController(withIdentifier: TravelViewController.identifier)
        
        self.navigationController?.pushViewController(TravelVC, animated: true)
    }
}
