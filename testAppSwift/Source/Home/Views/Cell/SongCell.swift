//
//  SongCell.swift
//  testAppSwift
//
//  Created by Salman Afzal on 06/08/2024.
//

import UIKit

class SongCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblDetail: UILabel!
    
    @IBOutlet weak var imgIsMusicPlaying: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
        imgIsMusicPlaying.image = UIImage(named: "logo.app")
    }
    
    func updateCell(title: String, detail: String, isPlaying: Bool){
        self.lblTitle.text = title
        self.lblDetail.text = detail
        self.imgIsMusicPlaying.isHidden = isPlaying
    }
    
}
