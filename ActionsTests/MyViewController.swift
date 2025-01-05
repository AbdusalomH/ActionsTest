//
//  ViewController.swift
//  ActionsTests
//
//  Created by Abdusalom on 04/01/2025.
//

import UIKit

protocol HorizontalCellMenuDelegate: AnyObject {
    func didTapButton(withTitle title: String)
}


class HorizontalCellMenu: UICollectionViewCell {
    
    
    static let reuseCell = "hmcell"
    
    weak var delegate: HorizontalCellMenuDelegate?
    
    
    lazy var titleLabels: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        
        contentView.addSubview(titleLabels)
        
        NSLayoutConstraint.activate([
            
            titleLabels.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabels.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            titleLabels.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            titleLabels.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        titleLabels.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    
    @objc func tapped() {
        
        if let title = titleLabels.title(for: .normal) {
            delegate?.didTapButton(withTitle: title)
        }
    }
    
    
    
    func setupTitles(title: String) {
        titleLabels.setTitle(title, for: .normal)
    }
}


class MyViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, HorizontalCellMenuDelegate {
    
    
    let menu = ["Hamburgers", "Hotdogs", "Lavash", "Pizza", "Doner", "Kebab"]
    
    var containerView: UIView = {
        let customView = UIView()
        customView.translatesAutoresizingMaskIntoConstraints = false
        return customView
    }()
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menu.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalCellMenu.reuseCell, for: indexPath) as! HorizontalCellMenu
        cell.setupTitles(title: menu[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    
    lazy var horizontalMenu: UICollectionView = {
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HorizontalCellMenu.self, forCellWithReuseIdentifier: HorizontalCellMenu.reuseCell)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
        
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        displayContent(for: "Hamburgers")
    }
    
    
    func setupView() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = .white
        view.addSubview(horizontalMenu)
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            
            horizontalMenu.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            horizontalMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            horizontalMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            horizontalMenu.heightAnchor.constraint(equalToConstant: 50),
            
            containerView.topAnchor.constraint(equalTo: horizontalMenu.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    func flowLayout() -> UICollectionViewFlowLayout {
        
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = CGSize(width: 150, height: 50)
        flow.scrollDirection = .horizontal
        return flow
    }
    
    
    func didTapButton(withTitle title: String) {
        displayContent(for: title)
    }
    
    
    private func displayContent(for title: String) {
        
            // Удаляем старый содержимый контроллер
        if let currentChild = children.first {
            currentChild.willMove(toParent: nil)
            currentChild.view.removeFromSuperview()
            currentChild.removeFromParent()
        }
        
        // Добавляем новый содержимый контроллер
        let newContentVC: UIViewController
        switch title {
        case "Hamburgers":
            newContentVC = HamburgerVC()
        case "Hotdogs":
            newContentVC = HotdogsVC()
        case "Lavash":
            newContentVC = LavashVC()
        default:
            newContentVC = UIViewController() // Пустой контроллер по умолчанию
            newContentVC.view.backgroundColor = .systemGray6
        }
            
        addChild(newContentVC)
        
        containerView.addSubview(newContentVC.view)
        
        newContentVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newContentVC.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            newContentVC.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            newContentVC.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            newContentVC.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        newContentVC.didMove(toParent: self)
        
        }
}

