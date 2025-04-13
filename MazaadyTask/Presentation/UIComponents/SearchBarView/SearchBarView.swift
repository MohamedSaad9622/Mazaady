//
//  SearchBarView.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 13/04/2025.
//

import UIKit

class SearchBarView: UICollectionReusableView {

    static let reuseIdentifier = "SearchBarView"

    let searchTextField = UITextField()
    let searchButton = UIButton(type: .system)

    var onSearchTapped: ((String) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        searchTextField.placeholder = "Search"
        searchTextField.borderStyle = .roundedRect
        searchTextField.layer.cornerRadius = 20
        searchTextField.setLeftViewIcon(UIImage(named: "search_icon"), color: .appMainColor)
        searchTextField.translatesAutoresizingMaskIntoConstraints = false

        searchButton.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        searchButton.imageView?.contentMode = .scaleAspectFit
        searchButton.imageView?.layer.bounds.size = CGSize(width: 20, height: 18)
        searchButton.tintColor = .white
        searchButton.backgroundColor = .appMainColor
        searchButton.layer.cornerRadius = 16
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.addTarget(self, action: #selector(didTapSearch), for: .touchUpInside)

        addSubview(searchTextField)
        addSubview(searchButton)

        NSLayoutConstraint.activate([
            searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            searchTextField.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            searchTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),

            searchButton.leadingAnchor.constraint(equalTo: searchTextField.trailingAnchor, constant: 8),
            searchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            searchButton.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 40),
            searchButton.heightAnchor.constraint(equalToConstant: 34)
        ])
    }

    @objc private func didTapSearch() {
        if searchTextField.text?.isEmpty ?? true { return }
        onSearchTapped?(searchTextField.text ?? "")
    }
}
