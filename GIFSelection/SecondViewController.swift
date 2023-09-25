//
//  SecondViewController.swift
//  GIFSelection
//
//  Created by Erum Naz on 21/09/23.
//

import UIKit
import Kingfisher

class SecondViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView :UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    let defaults = UserDefaults.standard
    var myarray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNewarray()
    }
    
    func setNewarray() {
        segmentedControl.selectedSegmentIndex = 0
        myarray = getImageGif() ?? []
        myarray = defaults.stringArray(forKey: "SavedStringArray") ?? [String]()
        collectionView.reloadData()
    }
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            print("Popular grid")
            self.collectionView.reloadData()
        case 1:
            print("History list")
            self.collectionView.reloadData()
        default:
            break;
        }
    }
    
    //MARK: CollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myarray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if segmentedControl.selectedSegmentIndex == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouriteGridViewCell",for: indexPath) as! FavouriteGridViewCell
            cell.favBtn.addTarget(self, action: #selector(favGridBtnAction(_:)), for: .touchUpInside)
            let rowData = myarray[indexPath.row]
            cell.logoImage.kf.setImage(with: URL(string: rowData))
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouriteListViewCell",for: indexPath) as! FavouriteListViewCell
            cell.favBtn.addTarget(self, action: #selector(favListBtnAction(_:)), for: .touchUpInside)
            let rowData = myarray[indexPath.row]
            cell.logoImage.kf.setImage(with: URL(string: rowData))
            return cell
        }
        
    }
    
    @objc func favGridBtnAction(_ btn: UIButton) {
        
        guard let indexPath = btn.collectionViewIndexPath(self.collectionView) else {return}
        let cell = collectionView.cellForItem(at: indexPath) as! FavouriteGridViewCell
        let rowData = self.myarray[indexPath.row]
        cell.favBtn.tintColor = .clear
        cell.favBtn.setImage(UIImage(named: "heartOutline"), for: .normal)
        myarray.remove(at: myarray.firstIndex(of: rowData)!)
        
        defaults.set(myarray, forKey: "SavedStringArray")
        setImageGif(ImageValue: myarray)
        collectionView.reloadData()
    }
    
    @objc func favListBtnAction(_ btn: UIButton) {
        
        guard let indexPath = btn.collectionViewIndexPath(self.collectionView) else {return}
        let cell = collectionView.cellForItem(at: indexPath) as! FavouriteListViewCell
        let rowData = self.myarray[indexPath.row]
        cell.favBtn.tintColor = .clear
        cell.favBtn.setImage(UIImage(named: "heartOutline"), for: .normal)
        myarray.remove(at: myarray.firstIndex(of: rowData)!)
        
        defaults.set(myarray, forKey: "SavedStringArray")
        setImageGif(ImageValue: myarray)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if segmentedControl.selectedSegmentIndex == 1 {
            return CGSize(width: collectionView.frame.width, height: 200)
        } else {
            
            if myarray.count-1 == indexPath.row {
                let width = collectionView.frame.width-10
                let height : CGFloat = 150.0
                return CGSize(width: width, height: height)
            }else{
                let width = (collectionView.frame.width-20)/3
                let height : CGFloat = 150.0
                if indexPath.item % 4 == 0 && indexPath.item != 0{
                    return CGSize(width: 250, height: height)
                } else {
                    return CGSize(width: width, height: height)
                }
            }
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
