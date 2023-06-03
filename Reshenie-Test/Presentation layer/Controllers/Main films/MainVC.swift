//
//  MainVC.swift
//  Reshenie-Test
//
//  Created by Kovs on 31.05.2023.
//

import UIKit
import SnapKit

class MainVC: UIViewController {
    
    var presenter: MainPresenterProtocol!
    
    private var tableView = UITableView()
    private var emptyView = UIView()
    
    private var navBar = UIView()
    let symbolConfig = UIImage.SymbolConfiguration(pointSize: 22)
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        
        view.backgroundColor = .systemBackground
        setupViews()
        title = "Кинопоиск"
        
        presenter.fetchTopFilms()
        
    }
    
    
    // MARK: - Other funcs
    
    private func setupViews() {
        view.addSubviews(tableView, navBar)
        setupTableView()
        makeConstraints()
        
        setupNavBar()
    }
    
    private func setupNavBar() {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 1
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.text = "Фильмы"
        
        let searchButton = UIButton()
        searchButton.setImage(UIImage(systemName: "magnifyingglass", withConfiguration: symbolConfig), for: .normal)
        searchButton.tintColor = .blue
        
        navBar.addSubviews(titleLabel, searchButton)
        
        navBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(35)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(navBar)
            make.leading.equalTo(navBar).inset(25)
        }
        
        searchButton.snp.makeConstraints { make in
            make.centerY.equalTo(navBar)
            make.trailing.equalTo(navBar).inset(35)
        }
        
        
    }
    
    
    private func setupTableView() {
        tableView.backgroundColor = .systemBackground
        tableView.separatorColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TopFilmCell.self, forCellReuseIdentifier: TopFilmCell.id)
        view.addSubview(tableView)
    }
    
    private func setupEmptyView() {
        let book = UIImageView()
        book.image = UIImage(systemName: "book.closed.fill")
        book.tintColor = .systemBlue
        
        emptyView.addSubview(book)
        book.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(24)
        }
        emptyView.layer.cornerRadius = (72 / 2)
        emptyView.backgroundColor = .lightGray
        emptyView.isHidden = true
    }
    
    private func makeConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view)
            make.top.equalTo(navBar.snp.bottom).offset(20)
        }
        
//        emptyView.snp.makeConstraints { make in
//            make.center.equalTo(view)
//            make.width.height.equalTo(72)
//        }
    }
    
    private func spinnerViewSetup() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
    
}



// MARK: - TableView
extension MainVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.topFilms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TopFilmCell.id, for: indexPath) as! TopFilmCell
        let currentFilm = presenter.topFilms[indexPath.row]
        cell.setupCell(film: currentFilm)
        
        let back = UIView()
        back.backgroundColor = .clear
        cell.selectedBackgroundView = back
        return cell
    }
    
}

// MARK: - UItableViewDelegate
extension MainVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentFilm = presenter.topFilms[indexPath.row]
        print(currentFilm)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            if !presenter.isFetching {
                presenter.isFetching = true
                
                self.tableView.tableFooterView = spinnerViewSetup()
                presenter.fetchTopFilms()
            }
        }
    }
}

// MARK: - Protocol
extension MainVC: MainViewProtocol {
    
    func success() {
        print(presenter.topFilms)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func failure(error: Error) {
        "Hello)))"
    }
    
}


