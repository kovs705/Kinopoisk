//
//  SearchVC.swift
//  Reshenie-Test
//
//  Created by Kovs on 02.06.2023.
//

import UIKit

class SearchVC: UIViewController {
    
    var presenter: SearchPresenterProtocol!
    
    private var tableView = UITableView()
    private var emptyView = UIView()
    
    private var navBar = NavigationBar(isSearch: true)
    
    // no internet error:
    let noInternetImage = UIImageView()
    let containerForNoInt = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: 25))
    let noInternetLabel = UILabel()
    
    // search error:
    let containerNoResults = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: 25))
    let noResultsLabel = UILabel()
    
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        
        presenter.searchRequest = ""
        check()
        presenter.fetchFilms()
        
        navigationController?.navigationBar.isHidden = true
        setupViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    func check() {
        if presenter.searchRequest!.isEmpty || presenter.films.isEmpty {
            tableView.isHidden = true
            emptyView.isHidden = false
            containerNoResults.isHidden = false
            noResultsLabel.isHidden = false
            noInternetImage.isHidden = true
            noInternetLabel.isHidden = true
            containerForNoInt.isHidden = true
        } else {
            tableView.isHidden = false
            emptyView.isHidden = true
            noResultsLabel.isHidden = true
            noInternetImage.isHidden = true
            noInternetLabel.isHidden = true
            noInternetImage.isHidden = true
            containerNoResults.isHidden = true
            containerForNoInt.isHidden = true
        }
    }
    
    
    // MARK: - Other funcs
    private func setupViews() {
        view.addSubviews(emptyView, tableView, navBar)
        setupTableView()
        makeConstraints()
        setupNavBar()
    }
    
    
    private func makeConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view)
            make.top.equalTo(navBar.snp.bottom).offset(20)
        }
        
        emptyView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.width.height.equalTo(100)
        }
        
        setupEmptyView()
        setupNoInternet()
    }
    
    // MARK: - NavBar
    private func setupNavBar() {
        
        navBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(30)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(35)
        }
        
        if navBar.isSearch {
            navBar.searchField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            navBar.backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        } else { return }
        
    }
    
    // MARK: - TableView
    private func setupTableView() {
        tableView.backgroundColor = .systemBackground
        tableView.separatorColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FilmCell.self, forCellReuseIdentifier: FilmCell.id)
        view.addSubview(tableView)
    }
    
    // MARK: - Loading view
    private func spinnerViewSetup() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
    
    // MARK: - No search results
    func setupEmptyView() {
        noResultsLabel.text = "Не найдено"
        noResultsLabel.textColor = .white
        noResultsLabel.textAlignment = .center
        
        containerNoResults.backgroundColor = UIColor(named: Colors.rtBlue)
        containerNoResults.layer.cornerRadius = 15
        
        emptyView.addSubviews(containerNoResults)
        containerNoResults.addSubviews(noResultsLabel)
        
        
        containerNoResults.snp.makeConstraints { make in
            make.center.equalTo(emptyView)
        }
        
        noResultsLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(containerNoResults).inset(8)
            make.leading.trailing.equalTo(containerNoResults).inset(15)
        }
    }
    
    // MARK: - No internet
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
    
    // MARK: - Obj-c func
    @objc func textFieldDidChange(_ textField: UITextField) {
        presenter.searchRequest = textField.text
        guard let request = presenter.searchRequest else {
            return
        }
        check()
        presenter.makeSearchRequest(from: request)
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func repeatSeah() {
        presenter.fetchFilms()
    }
    
}

// MARK: - TableView
extension SearchVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilmCell.id, for: indexPath) as! FilmCell
        let currentFilm = presenter.films[indexPath.row]
        cell.setupCell(film: currentFilm)
        
        let back = UIView()
        back.backgroundColor = .clear
        cell.selectedBackgroundView = back
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension SearchVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentFilm = presenter.films[indexPath.row]
        
        let coordinator = Builder()
        navigationController?.pushViewController(coordinator.getDetailModule(film: currentFilm), animated: true)
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
                presenter.fetchFilms()
            }
        }
    }
}




// MARK: - Protocol
extension SearchVC: SearchViewProtocol {
    
    func success() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func failure(error: Error) {
        DispatchQueue.main.async {
            self.tableView.isHidden = true
            self.emptyView.isHidden = false
            self.noResultsLabel.isHidden = true
            self.containerNoResults.isHidden = true
            self.noInternetImage.isHidden = false
            self.noInternetLabel.isHidden = false
            self.containerForNoInt.isHidden = false
        }

    }
    
    
    
    
}
