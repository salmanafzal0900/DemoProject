//
//  SignableViewCell.swift
//  SwiftApp
//
//  Created by Salman Afzal on 02/09/2024.
//

import UIKit

class SignableViewCell: UITableViewCell {

    @IBOutlet weak var myTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}



import UIKit
import SwiftSignatureView

class SignatureTableViewCell: UITableViewCell {
    @IBOutlet weak var signatureView: SwiftSignatureView!
}
