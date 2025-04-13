//
//  AdsCollectionViewCell.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 12/04/2025.
//

import UIKit
import Kingfisher

class AdsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var adsImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        adsImageView.layer.cornerRadius = 21
    }
    
    func configure(with ads: Advertisements) {
        adsImageView.kf.setImage(with: URL(string: ads.image ?? ""))
    }

}
