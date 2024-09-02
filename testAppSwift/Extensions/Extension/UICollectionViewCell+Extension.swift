//
//  UICollectionViewCell+Extension.swift
//  VaultsPay
//
//  Created by Rashihd Latif on 02/05/2021.
//

import UIKit

extension UICollectionViewCell{
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

extension UICollectionView {
    func returnIndexPath(cell: UICollectionViewCell) -> IndexPath?{
        guard let indexPath = self.indexPath(for: cell) else {
            return nil
        }
        return indexPath
    }
}
