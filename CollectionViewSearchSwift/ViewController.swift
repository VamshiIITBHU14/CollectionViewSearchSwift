//
//  ViewController.swift
//  CollectionViewSearchSwift
//
//  Created by Vamshi Krishna on 20/04/17.
//  Copyright © 2017 VamshiKrishna. All rights reserved.
//



import UIKit

class ViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout , TapCellDelegate, UISearchBarDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionSearchBar: UISearchBar!
    var cellIdentifier = "Cell"
    var numberOfItemsPerRow : Int = 2
    var dataSource:[String]?
    var dataSourceForSearchResult:[String]?
    var searchBarActive:Bool = false
    var searchBarBoundsY:CGFloat?
    var refreshControl:UIRefreshControl?
    
    var cellWidth:CGFloat{
        return collectionView.frame.size.width/2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        collectionSearchBar.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        self.dataSource = ["Afghanistan","Albania","Algeria","Andorra","Barbados","Belarus","Belgium","Cabo Verde","Central African Republic", "Chad","Chile","Denmark","Djibouti","Eritrea","Estonia","Fiji", "Finland","Haiti","Holy See","Honduras","Iceland","India", "Japan", "Kosovo","Kuwait","Lesotho", "Liberia","Mauritius", "Mexico","Micronesia","Moldova","Namibia","Nauru","Nepal","Oman","Paraguay", "Peru","Philippines","Poland","Qatar","Russia","Senegal","Serbia","Seychelles","Sierra Leone","Tonga","Trinidad and Tobago","Tunisia","United Kingdom","Uruguay","Venezuela","Vietnam","Yemen","Zimbabwe"]
        self.dataSourceForSearchResult = [String]()
    }
    
    // MARK: Search
    func filterContentForSearchText(searchText:String){
        self.dataSourceForSearchResult = self.dataSource?.filter({ (text:String) -> Bool in
            return text.contains(searchText)
        })
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count > 0 {
            self.searchBarActive    = true
            self.filterContentForSearchText(searchText: searchText)
            self.collectionView?.reloadData()
        }else{
            self.searchBarActive = false
            self.collectionView?.reloadData()
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self .cancelSearching()
        self.collectionView?.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBarActive = true
        self.view.endEditing(true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.collectionSearchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchBarActive = false
        self.collectionSearchBar.setShowsCancelButton(false, animated: false)
    }
    func cancelSearching(){
        self.searchBarActive = false
        self.collectionSearchBar.resignFirstResponder()
        self.collectionSearchBar.text = ""
    }
    
    
    // MARK: <UICollectionViewDataSource>
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CollectionViewCell
        cell.indexPath = indexPath
        cell.delegate = self
        cell.topButton.backgroundColor = UIColor .blue
        cell.layer.borderWidth = 1.0;
        cell.layer.borderColor = UIColor.green.cgColor
        cell.topLabel.textColor = UIColor.white
        
        if (self.searchBarActive) {
            cell.topLabel!.text = self.dataSourceForSearchResult![indexPath.row];
        }else{
            cell.topLabel!.text = self.dataSource![indexPath.row];
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.searchBarActive {
            return self.dataSourceForSearchResult!.count;
        }
        return self.dataSource!.count
    }
    
    func buttonTapped(indexPath: IndexPath) {
        print("success")
    }
    
    // MARK: <UICollectionViewDelegateFlowLayout>
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfItemsPerRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(numberOfItemsPerRow))
        return CGSize(width: size, height: size)
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
   
}


