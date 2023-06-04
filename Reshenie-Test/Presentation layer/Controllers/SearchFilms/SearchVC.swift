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
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        presenter.searchRequest = "Ёлки"
        presenter.fetchFilms()
        
        navigationController?.navigationBar.isHidden = true
        setupViews()
        
    }
    
    
    // MARK: - Other funcs
    private func setupViews() {
        view.addSubviews(tableView, navBar)
        setupTableView()
        makeConstraints()
        setupNavBar()
    }
    
    
    private func makeConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view)
            make.top.equalTo(navBar.snp.bottom).offset(20)
        }
    }
    
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
    
    private func setupTableView() {
        tableView.backgroundColor = .systemBackground
        tableView.separatorColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FilmCell.self, forCellReuseIdentifier: FilmCell.id)
        view.addSubview(tableView)
    }
    
    private func spinnerViewSetup() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
    
    func stopIt() {
        
    }
    
    // MARK: - Obj-c func
    @objc func textFieldDidChange(_ textField: UITextField) {
        presenter.searchRequest = textField.text
        guard let request = presenter.searchRequest else {
            
            return
        }
        presenter.makeSearchRequest(from: request)
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
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

//    func configureCategoryLabel() {
//
//        let container = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: 25))
//        container.translatesAutoresizingMaskIntoConstraints = false
//        container.backgroundColor = UIColor(named: Colors.rtBlue)
//        container.layer.cornerRadius = 15
//
//        backImage.addSubview(container)
//        container.addSubview(categoryLabel)
//
//        // backImage.addSubview(categoryLabel)
////        categoryLabel.backgroundColor = UIColor(named: Colors.purplePrimary.rawValue)
////        categoryLabel.layer.cornerRadius = 10
////
//        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        categoryLabel.textAlignment = .center
//
//
//        container.snp.makeConstraints { make in
//
//            make.leading.equalTo(backImage.snp.leading).inset(25)
//
//        }
//
//        categoryLabel.snp.makeConstraints { make in
//            make.top.bottom.equalTo(container).inset(5)
//            make.leading.trailing.equalTo(container).inset(15)
//        }
//
//    }




// MARK: - Protocol
extension SearchVC: SearchViewProtocol {
    
    func success() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func failure(error: Error) {
        fatalError("No request")
    }
    
    
    
    
}
