//
//  UITextField+Extensions.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 13/04/2025.
//

import UIKit

extension UITextField {
    func setLeftViewIcon(_ image: UIImage?, color: UIColor = .gray, padding: CGFloat = 8) {
        let iconView = UIImageView(image: image)
        iconView.tintColor = color
        iconView.contentMode = .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false

        let containerView = UIView()
        containerView.addSubview(iconView)

        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            iconView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            iconView.topAnchor.constraint(equalTo: containerView.topAnchor),
            iconView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 20),
            iconView.heightAnchor.constraint(equalToConstant: 20)
        ])

        containerView.frame = CGRect(x: 0, y: 0, width: 36, height: 20)
        self.leftView = containerView
        self.leftViewMode = .always
    }
}
