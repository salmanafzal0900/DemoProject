//
//  UITableViewCell+Extension.swift
//  VaultsPay
//
//  Created by Rashihd Latif on 02/05/2021.
//

import UIKit

extension UITableViewCell{
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

extension UITableViewHeaderFooterView{
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

extension UITableView {
    func returnIndexPath(cell: UITableViewCell) -> IndexPath?{
        guard let indexPath = self.indexPath(for: cell) else {
            return nil
        }
        return indexPath
    }
    
    func updateHeaderViewHeight() {
            if let header = self.tableHeaderView {
                let newSize = header.systemLayoutSizeFitting(CGSize(width: self.bounds.width, height: 0))
                header.frame.size.height = newSize.height
            }
        }
}
