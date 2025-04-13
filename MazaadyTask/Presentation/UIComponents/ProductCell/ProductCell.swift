//
//  ProductCell.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 12/04/2025.
//

import UIKit
import Kingfisher

class ProductCell: UICollectionViewCell {

    // MARK: - Outlets
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
    
    // MARK: - Properties
    private var countdownTimer: Timer?
    private var product: ProductModel?
    
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configDesign()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // Invalidate any existing timer so that reused cells don’t keep old countdowns running.
        invalidateTimer()
    }
    
    // MARK: - Configuration Methods
    func configDesign(){
        containerView.layer.cornerRadius = 22
        containerView.backgroundColor = .appMainBackgroundColor
        productImageView.layer.cornerRadius = 20
        productNameLabel.textColor = .appMainTextColor
        
        [dayView, hoursView, minutesView].forEach {
            $0?.backgroundColor = .appLightOrangeColor
            $0?.layer.cornerRadius = 14
        }
        
        dayLabel.textColor = .appOrangeColor
        hoursLabel.textColor = .appOrangeColor
        minutesLabel.textColor = .appOrangeColor
        endDateView.isHidden = true
    }
    
    func configCell(with product: ProductModel) {
        self.product = product
        let currency = product.currency ?? "EGP"
        
        productNameLabel.text = product.name
        priceLable.text = "\(product.price ?? 0) \(currency)"
        productImageView.kf.setImage(with: URL(string: product.image ?? ""))
        
        if let offer = product.offer {
            offerPriceView.isHidden = false
            oldPriceLabel.text = "\(product.price ?? 0) \(currency)"
            offerLabel.text = "\(offer) \(currency)"
            oldPriceLabel.setStrikethroughText(oldPriceLabel.text ?? "", color: .systemRed)
        } else {
            offerPriceView.isHidden = true
        }
        
        // Reset previous timer
        invalidateTimer()
        
        if product.endDate != nil {
            // Calculate a fixed target date from when the data was fetched.
            let targetDate = product.targetDate
            
            // If the current time is still before the target date, start the timer.
            if let targetDate = targetDate, Date() < targetDate {
                endDateView.isHidden = false
                // Update immediately.
                updateCountdown(with: targetDate)
                // Start a timer that fires every second.
                countdownTimer = Timer.scheduledTimer(timeInterval: 1.0,
                                                      target: self,
                                                      selector: #selector(timerFired),
                                                      userInfo: targetDate,
                                                      repeats: true)
            } else {
                // If the target date has passed, hide the countdown view.
                endDateView.isHidden = true
            }
        } else {
            endDateView.isHidden = true
        }
        
    }
    

    // MARK: - Timer Methods
    
    @objc private func timerFired(_ timer: Timer) {
        guard let targetDate = timer.userInfo as? Date else {
            invalidateTimer()
            return
        }
        updateCountdown(with: targetDate)
    }
    
    private func updateCountdown(with targetDate: Date) {
        let now = Date()
        if now >= targetDate {
            invalidateTimer()
            endDateView.isHidden = true
            return
        }
        
        let components = Calendar.current.dateComponents([.day, .hour, .minute], from: now, to: targetDate)
        updateCountdownUI(with: components)
    }
    
    private func updateCountdownUI(with components: DateComponents) {
       if let days = components.day {
           dayView.isHidden = false
           dayLabel.text = "\(days)"
       } else {
           dayView.isHidden = true
       }
       
       if let hours = components.hour {
           hoursView.isHidden = false
           hoursLabel.text = "\(hours)"
       } else {
           hoursView.isHidden = true
       }
       
       if let minutes = components.minute {
           minutesView.isHidden = false
           minutesLabel.text = "\(minutes)"
       } else {
           minutesView.isHidden = true
       }
   }
    
    private func invalidateTimer() {
        countdownTimer?.invalidate()
        countdownTimer = nil
    }

}
