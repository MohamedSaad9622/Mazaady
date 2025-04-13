//
//  ProfileCell.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 12/04/2025.
//

import UIKit
import Kingfisher
import Combine

class ProfileCell: UICollectionViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    
    @IBOutlet weak var userLocationLabel: UILabel!
    
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    
    var settingButtonTapped = PassthroughSubject<Void, Never>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configDesign()
    }
    
    func configDesign(){
        profileImageView.layer.cornerRadius = 18
        userNameLabel.textColor = .appMainTextColor
        userEmailLabel.textColor = .appMainTextColor
        userLocationLabel.textColor = .appSecondaryTextColor
        followersLabel.textColor = .appMainColor
        followingLabel.textColor = .appMainColor
        
    }
    
    func configCell(with user: UserData){
        profileImageView.kf.setImage(with: URL(string: user.image ?? ""))
        userNameLabel.text = user.name
        userEmailLabel.text = user.userName
        userLocationLabel.text = "\(String(describing: user.countryName ?? "")), \(String(describing: user.cityName ?? ""))"
        followingCountLabel.text = "\(String(describing: user.followingCount ?? 0))"
        followersCountLabel.text = "\(String(describing: user.followersCount ?? 0))"
    }

    
    @IBAction func settingButtonTaped(_ sender: Any) {
        settingButtonTapped.send()
    }
    
    
}
