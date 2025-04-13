//
//  UISegmentedControl+Extensions.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 13/04/2025.
//

import UIKit

extension UISegmentedControl {
    
    private var underlineHeight: CGFloat { 2 }

    func setup() {
        style()
        transparentBackground()
        DispatchQueue.main.async {
            self.addUnderline()
        }
    }

    func style() {
        clipsToBounds = false
        tintColor = .clear
        backgroundColor = .clear
        if #available(iOS 13.0, *) {
            selectedSegmentTintColor = .clear
        }
        selectedSegmentIndex = 0

        // Selected and unselected title colors
        setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 17), .foregroundColor: UIColor.appMainColor], for: .selected)
        setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 17), .foregroundColor: UIColor.darkGray], for: .normal)

        sizeToFit()
    }

    func transparentBackground() {
        let backgroundImage = UIImage.coloredRectangleImageWith(color: UIColor.clear.cgColor, andSize: self.bounds.size)
        let dividerImage = UIImage.coloredRectangleImageWith(color: UIColor.clear.cgColor, andSize: CGSize(width: 1, height: self.bounds.height))
        setBackgroundImage(backgroundImage, for: .normal, barMetrics: .default)
        setBackgroundImage(backgroundImage, for: .selected, barMetrics: .default)
        setBackgroundImage(backgroundImage, for: .highlighted, barMetrics: .default)
        setDividerImage(dividerImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    }

    func addUnderline() {
        let segmentWidth = bounds.width / CGFloat(numberOfSegments)
        let underlineX = segmentWidth * CGFloat(selectedSegmentIndex)

        let underline = UIView(frame: CGRect(x: underlineX, y: bounds.height - underlineHeight, width: segmentWidth, height: underlineHeight))
        underline.backgroundColor = .appMainColor
        underline.tag = 999
        addSubview(underline)
    }

    func setSelectedSegmentUnderline() {
        guard let underline = self.viewWithTag(999) else { return }

        let segmentWidth = bounds.width / CGFloat(numberOfSegments)
        let underlineX = segmentWidth * CGFloat(selectedSegmentIndex)

        UIView.animate(withDuration: 0.2) {
            underline.frame = CGRect(x: underlineX, y: self.bounds.height - self.underlineHeight, width: segmentWidth, height: self.underlineHeight)
        }
    }
}
