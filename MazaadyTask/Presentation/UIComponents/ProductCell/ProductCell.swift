//
//  ProductCell.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 12/04/2025.
//

import UIKit
import Kingfisher

class ProductCell: UICollectionViewCell {

    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLable: UILabel!
    
    @IBOutlet weak var offerPriceView: UIStackView!
    @IBOutlet weak var offerLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    
    @IBOutlet weak var endDateView: UIStackView!
    @IBOutlet weak var dayView: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var hoursView: UIView!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var minutesView: UIView!
    @IBOutlet weak var minutesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configDesign()
    }
    
    func configDesign(){
        containerView.layer.cornerRadius = 22
        containerView.backgroundColor = .appMainBackgroundColor
        productImageView.layer.cornerRadius = 20
        productNameLabel.textColor = .appMainTextColor
        dayView.backgroundColor = .appLightOrangeColor
        dayView.layer.cornerRadius = 14
        hoursView.backgroundColor = .appLightOrangeColor
        hoursView.layer.cornerRadius = 14
        minutesView.backgroundColor = .appLightOrangeColor
        minutesView.layer.cornerRadius = 14
        endDateView.isHidden = true
        dayLabel.textColor = .appOrangeColor
        hoursLabel.textColor = .appOrangeColor
        minutesLabel.textColor = .appOrangeColor
    }
    
    func configCell(with product: ProductModel){
        let currency = product.currency ?? "EGP"
        productNameLabel.text = product.name
        priceLable.text = "\(product.price ?? 0) \(currency)"
        productImageView.kf.setImage(with: URL(string: product.image ?? ""))
        
        if let offer = product.offer {
            offerPriceView.isHidden = false
            oldPriceLabel.text = "\(product.price ?? 0) \(currency)"
            offerLabel.text = "\(offer) \(currency)"
        }else{
            offerPriceView.isHidden = true
        }
        
        if product.endDate != nil{
            endDateView.isHidden = false
            if let days = product.countdownComponents?.days, days > 0{
                dayView.isHidden = false
                dayLabel.text = "\(days)"
            }else{
                dayView.isHidden = true
            }
            if let hours = product.countdownComponents?.hours, hours > 0 {
                hoursView.isHidden = false
                hoursLabel.text = "\(hours)"
            }else{
                hoursView.isHidden = true
            }
            if let minutes = product.countdownComponents?.minutes, minutes > 0{
                minutesView.isHidden = false
                minutesLabel.text = "\(minutes)"
            }else{
                minutesView.isHidden = true
            }
        }else{
            endDateView.isHidden = true
        }
    }

}
