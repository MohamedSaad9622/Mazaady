//
//  SegmentView.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 13/04/2025.
//

import UIKit

class SegmentHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "SegmentHeaderView"
    var onSegmentChanged: ((Int) -> Void)?
    
    let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Products", "Reviews", "Followers"])
        control.selectedSegmentIndex = 0
        control.setup()
        return control
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            segmentedControl.centerYAnchor.constraint(equalTo: centerYAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 40)
        ])
        segmentedControl.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func segmentValueChanged(_ sender: UISegmentedControl) {
        onSegmentChanged?(sender.selectedSegmentIndex)
        sender.setSelectedSegmentUnderline()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

