//
//  MainTabBarController.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 12/04/2025.
//

import UIKit


class MainTabBarController: UITabBarController {

    private let middleButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setupMiddleButton()
    }

    private func setupViewControllers() {
        let homeVC = UINavigationController(rootViewController: UIViewController())
        let searchVC = UINavigationController(rootViewController: UIViewController())
        let shopVC = UINavigationController(rootViewController: UIViewController())
        let profileVC = UINavigationController(rootViewController: ProfileViewController(viewModel: DependencyContainer.shared.makeProductUseCases()))
        let cartVC = UINavigationController(rootViewController: UIViewController())

        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "tab_bar_home"), tag: 0)
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        shopVC.tabBarItem = UITabBarItem(title: "", image: nil, tag: 2)
        cartVC.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(named: "tab_bar_cart"), tag: 3)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "tab_bar_user"), tag: 4)

        self.setViewControllers([homeVC, searchVC, shopVC, cartVC, profileVC], animated: false)
        selectedIndex = 4
    }

    private func setupMiddleButton() {
        middleButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        middleButton.backgroundColor = .appMainColor
        middleButton.layer.cornerRadius = 7
        middleButton.layer.shadowColor = UIColor.black.cgColor
        middleButton.layer.shadowOpacity = 0.3
        middleButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        middleButton.layer.shadowRadius = 5

        let icon = UIImage(named: "tab_bar_shop")
        middleButton.setImage(icon, for: .normal)
        middleButton.center = CGPoint(x: tabBar.center.x, y: tabBar.bounds.minY - 5)
        middleButton.addTarget(self, action: #selector(middleButtonTapped), for: .touchUpInside)

        self.view.addSubview(middleButton)
    }

    @objc private func middleButtonTapped() {
        self.selectedIndex = 2
    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        var newTabBarFrame = tabBar.frame
        newTabBarFrame.size.height = 90
        newTabBarFrame.origin.y = view.frame.height - newTabBarFrame.size.height
        tabBar.frame = newTabBarFrame

        // Reposition the middle button
        self.middleButton.center = CGPoint(x: tabBar.center.x, y: view.bounds.height - tabBar.frame.height/2 - 20)

    }
}
