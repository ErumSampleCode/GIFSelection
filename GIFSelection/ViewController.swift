//
//  ViewController.swift
//  GIFSelection
//
//  Created by Erum Naz on 21/09/23.
//

import UIKit
import SDWebImage
import Kingfisher

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView :UITableView!
    @IBOutlet weak var searchBar :UISearchBar!
    
    
    var dataArrays: [TRENDING] = []
    var gifs: [Gif] = []
    let networkCall = GifService()
    let defaults = UserDefaults.standard
    var myarray: [String] = []
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        searchBar.delegate = self
        
        setNewarray()
    }
    
    func setNewarray() {
        
        
        Task {
            defer{tableView.reloadData()}
            let networkCall = GifService()
            let result = try await networkCall.poTrendingData()
            self.gifs.append(contentsOf: result)
        }
        
        
        myarray = defaults.stringArray(forKey: "SavedStringArray") ?? [String]()
    }
    //MARK:- TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gifs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImagesTableViewCell") as! ImagesTableViewCell
        
        cell.favBtn.addTarget(self, action: #selector(favBtnAction(_:)), for: .touchUpInside)
        
        let rowData = gifs[indexPath.row]
        
        
        cell.logoImage.kf.setImage(with: URL(string: rowData.getGifURL()))
        
        if myarray.contains(rowData.getGifURL()) {
            cell.favBtn.tintColor = .white
            cell.favBtn.setImage(UIImage(named: "icons9"), for: .normal)
        }  else {
            cell.favBtn.tintColor = .clear
            cell.favBtn.setImage(UIImage(named: "heartOutline"), for: .normal)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0;//Choose your custom row height
    }
    
    @objc func favBtnAction(_ btn: UIButton) {
        
        guard let cell = btn.tableViewCell() as? ImagesTableViewCell else { return }
        guard let indexPath = btn.tableViewIndexPath(self.tableView) else { return }
        
        let rowData = self.gifs[indexPath.row]
        
        
        if myarray.contains(rowData.getGifURL()) {
            cell.favBtn.tintColor = .clear
            cell.favBtn.setImage(UIImage(named: "heartOutline"), for: .normal)
            myarray.remove(at: myarray.firstIndex(of: rowData.getGifURL())!)
            
        } else {
            cell.favBtn.tintColor = .white
            cell.favBtn.setImage(UIImage(named: "icons9"), for: .normal)
            myarray.append(rowData.getGifURL())
            
        }
        defaults.set(myarray, forKey: "SavedStringArray")
        
        setImageGif(ImageValue: myarray)
    }
    
    func searchGifs(for searchText: String) {
        self.gifs.removeAll()
        self.tableView.reloadData()
        networkCall.fetchGifs(searchTerm: searchText) {[weak self] gifArray in
            if gifArray != nil {
                self?.gifs.append(contentsOf:gifArray!.gifs)
                self?.tableView.reloadData()
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            setNewarray()
        } else {
            searchGifs(for: searchText)
        }
    }
    
    
}

