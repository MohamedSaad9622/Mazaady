//
//  TagCollectionCell.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 12/04/2025.
//

import UIKit

class TagCollectionCell: UICollectionViewCell {
    static let reuseIdentifier = "TagCollectionCell"
    
    private let tagLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) not implemented") }
    
    private func setupUI() {
        tagLabel.font = .systemFont(ofSize: 14)
        tagLabel.textColor = .appMainTextColor
        tagLabel.textAlignment = .center
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.backgroundColor = .appMainBackgroundColor
        contentView.layer.cornerRadius = 8
        contentView.addSubview(tagLabel)
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.appBoarderColor.cgColor
        
        NSLayoutConstraint.activate([
            tagLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            tagLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            tagLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            tagLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.backgroundColor = .appLightOrangeColor
                tagLabel.textColor = .appOrangeColor
                contentView.layer.borderColor = UIColor.appOrangeColor.cgColor
            } else {
                contentView.backgroundColor = .appMainBackgroundColor
                tagLabel.textColor = .appMainTextColor
                contentView.layer.borderColor = UIColor.appBoarderColor.cgColor
            }
        }
    }
    
    func configure(with tag: Tag) {
        tagLabel.text = tag.name
    }

}
