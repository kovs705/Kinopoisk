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
    
    private var navBar = NavigationBar(isSearch: false)
    let symbolConfig = UIImage.SymbolConfiguration(pointSize: 22)
    
    // no internet error:
    let noInternetImage = UIImageView()
    let containerForNoInt = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: 25))
    let noInternetLabel = UILabel()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        
        view.backgroundColor = .systemBackground
        setupViews()
        title = "Кинопоиск"
        
        presenter.fetchTopFilms()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    // MARK: - Other funcs
    
    private func setupViews() {
        view.addSubviews(tableView, navBar, emptyView)
        setupTableView()
        setupEmptyView()
        makeConstraints()
        
        setupNavBar()
    }
    
    private func setupNavBar() {
        
        navBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(35)
        }
        
    }
    
    func setupNavBarTarget() {
        if !navBar.isSearch {
            navBar.searchButton.setImage(UIImage(systemName: "magnifyingglass", withConfiguration: symbolConfig), for: .normal)
            navBar.searchButton.addTarget(self, action: #selector(openVC), for: .touchUpInside)
        } else { return }
    }
    
    func setBadConnection() {
        DispatchQueue.main.async { [self] in
            tableView.isHidden = true
            emptyView.isHidden = false
            containerForNoInt.isHidden = false
            noInternetImage.isHidden = false
            noInternetLabel.isHidden = false
            
            navBar.searchButton.setImage(UIImage(systemName: "arrow.counterclockwise", withConfiguration: symbolConfig), for: .normal)
            navBar.searchButton.addTarget(self, action: #selector(repeatSearch), for: .touchUpInside)
        }
    }
    
    func setGoodConnection() {
        DispatchQueue.main.async { [self] in
            tableView.reloadData()
            tableView.isHidden = false
            emptyView.isHidden = true
            containerForNoInt.isHidden = true
            noInternetImage.isHidden = true
            noInternetLabel.isHidden = true
            
            navBar.searchButton.setImage(UIImage(systemName: "magnifyingglass", withConfiguration: symbolConfig), for: .normal)
            navBar.searchButton.addTarget(self, action: #selector(openVC), for: .touchUpInside)
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
        
        emptyView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.width.height.equalTo(100)
        }
        
        setupNoInternet()
    }
    
    private func makeConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view)
            make.top.equalTo(navBar.snp.bottom).offset(20)
        }
    }
    
    private func spinnerViewSetup() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
    
    func setupNoInternet() {
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 90)

        noInternetLabel.text = "Нет соединения"
        noInternetLabel.textColor = .white
        noInternetLabel.textAlignment = .center
        
        noInternetLabel.isUserInteractionEnabled = true

        containerForNoInt.translatesAutoresizingMaskIntoConstraints = false
        containerForNoInt.backgroundColor = UIColor(named: Colors.rtBlue)
        containerForNoInt.layer.cornerRadius = 18
        containerForNoInt.isUserInteractionEnabled = false
        
        emptyView.addSubviews(containerForNoInt)
        containerForNoInt.addSubviews(noInternetLabel)

        noInternetLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(containerForNoInt).inset(8)
            make.leading.trailing.equalTo(containerForNoInt).inset(10)
        }


        noInternetImage.image = UIImage(systemName: "icloud.slash", withConfiguration: symbolConfig)
        noInternetImage.tintColor = UIColor(named: Colors.rtBlue)

        emptyView.addSubviews(noInternetImage)
        
        noInternetImage.snp.makeConstraints { make in
            make.top.centerX.equalTo(emptyView)
        }
        containerForNoInt.snp.makeConstraints { make in
            make.top.equalTo(noInternetImage.snp.bottom)
            make.centerX.equalTo(emptyView)
        }
        
    }
    
    
    // MARK: - Obj-c funcs
    @objc func openVC() {
        let coordinator = Builder()
        navigationController?.pushViewController(coordinator.getSearchModule(), animated: true)
    }
    
    @objc func repeatSearch() {
        print("Trying to make a search again..")
        presenter.fetchTopFilms()
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
        self.setGoodConnection()
    }
    
    func failure(error: Error) {
        self.setBadConnection()
    }
    
}


