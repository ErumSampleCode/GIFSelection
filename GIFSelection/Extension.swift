//
//  Extension.swift
//  GIFSelection
//
//  Created by Erum Naz on 23/09/23.
//

import Foundation
import SDWebImage


extension UIImageView {
    
    func setImageWith(_ url: String?, placeholder: UIImage? = nil) {
        
        guard let url = url, let imageURL = URL(string: url) else {
            self.image = placeholder
            return
        }
        
        let complated: SDExternalCompletionBlock = { (image, error, cacheType, imageURL) -> Void in
            //guard let url = imageURL?.absoluteString, let img = image else { return }
            //SKCache.sharedCache.setImage(img, forKey: url)
        }
        self.sd_setImage(with: imageURL, placeholderImage: placeholder, completed: complated)
    }
   
    func setImageWith(_ url: URL?, placeholder: UIImage? = nil) {
        
        guard let imageURL = url else {
            self.image = placeholder
            return
        }
        
        let complated: SDExternalCompletionBlock = { (image, error, cacheType, imageURL) -> Void in
            //guard let url = imageURL?.absoluteString, let img = image else { return }
            //SKCache.sharedCache.setImage(img, forKey: url)
        }
        self.sd_setImage(with: imageURL, placeholderImage: placeholder, completed: complated)
    }
    
}

extension UIView {
    
    func tableViewCell() -> UITableViewCell? {
        var tableViewcell : UIView? = self
        while(tableViewcell != nil)
        {
            if tableViewcell! is UITableViewCell {
                break
            }
            tableViewcell = tableViewcell!.superview
        }
        return tableViewcell as? UITableViewCell
    }
    
    
    func tableViewIndexPath(_ tableView: UITableView) -> IndexPath? {
        if let cell = self.tableViewCell() {
            return tableView.indexPath(for: cell)
        }
        else {
            return nil
        }
    }
    
    
    func collectionviewCell() -> UICollectionViewCell? {
        var collectionviewCell : UIView? = self
        while(collectionviewCell != nil)
        {
            if collectionviewCell! is UICollectionViewCell {
                break
            }
            collectionviewCell = collectionviewCell!.superview
        }
        return collectionviewCell as? UICollectionViewCell
    }
    
    
    func collectionViewIndexPath(_ collectionView: UICollectionView) -> IndexPath? {
        if let cell = self.collectionviewCell() {
            return collectionView.indexPath(for: cell)
        }
        else {
            return nil
        }
    }
    
}


