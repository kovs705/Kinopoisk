//
//  NavigationBar.swift
//  Reshenie-Test
//
//  Created by Kovs on 03.06.2023.
//

import UIKit

class NavigationBar: UIView {
    
    let symbolConfig = UIImage.SymbolConfiguration(pointSize: 22)
    
    let titleLabel = UILabel()
    let searchButton = UIButton()
    
    let searchField = UITextField()
    let backButton = UIButton()
    
    var isSearch = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(isSearch: Bool) {
        self.init(frame: .zero)
        self.isSearch = isSearch
        
        if isSearch {
            setupSearchBar()
        } else {
            setupDefaultBar()
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Configure
    private func configure() {
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureTitleLabel() {
        titleLabel.numberOfLines = 1
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.text = "Топ-250"
    }
    
    private func configureSearchButton() {
        searchButton.setImage(UIImage(systemName: "magnifyingglass", withConfiguration: symbolConfig), for: .normal)
        searchButton.tintColor = UIColor(named: Colors.rtBlue)
    }
    
    private func configureSearchField() {
        searchField.borderStyle = .none
        searchField.placeholder = "Поиск"
        searchField.tintColor = UIColor(named: Colors.rtBlue)
    }
    
    private func configureBackButton() {
        backButton.setImage(UIImage(systemName: "arrow.left", withConfiguration: symbolConfig), for: .normal)
        backButton.tintColor = UIColor(named: Colors.rtBlue)
    }
    
    
    // MARK: - Layout
    func setupSearchBar() {
        self.addSubviews(backButton, searchField)
        
        configureBackButton()
        configureSearchField()
        
        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.leading.equalTo(self).inset(25)
            make.width.equalTo(23)
            make.height.equalTo(22)
        }
        
        searchField.snp.makeConstraints { make in
            make.leading.equalTo(backButton.snp.trailing).offset(15)
            make.trailing.equalTo(self).inset(25)
            make.centerY.equalTo(self)
            make.height.equalTo(45)
        }
    }
    
    func setupDefaultBar() {
        self.addSubviews(titleLabel, searchButton)
        
        configureTitleLabel()
        configureSearchButton()
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.leading.equalTo(self).inset(25)
        }
        
        searchButton.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.trailing.equalTo(self).inset(25)
        }
    }
    
}
