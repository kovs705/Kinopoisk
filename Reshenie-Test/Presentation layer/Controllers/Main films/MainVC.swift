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
    
    private let searchController = UISearchController()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        title = "Кинопоиск"
        presenter.fetchTopFilms()
        
        setupViews()
    }
    
    
    // MARK: - Other funcs
    
    private func setupViews() {
        view.addSubviews(tableView, emptyView)
        setupTableView()
        makeConstraints()
    }
    
    
    private func setupTableView() {
        tableView.frame = view.bounds
        tableView.backgroundColor = .clear
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
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
//        emptyView.snp.makeConstraints { make in
//            make.center.equalTo(view)
//            make.width.height.equalTo(72)
//        }
    }
    
}


// MARK: - SearchBar
extension MainVC {
    func configureSearchController() {
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search movie"
    }

    func configureNavigation() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}


//MARK: - UISearchResultsUpdating
extension MainVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else { return }
        print(query)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
     print(#function)
    }
}


//MARK: - UISearchBarDelegate

extension MainVC: UISearchBarDelegate {
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let coordinator = Builder()
        let resultViewController = coordinator.getSearchModule(request: searchBar.text!)
        navigationController?.pushViewController(resultViewController, animated: true)
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
        back.backgroundColor = .systemBackground
        cell.selectedBackgroundView = back
        return cell
    }
    
    
}

extension MainVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentFilm = presenter.topFilms[indexPath.row]
        print(currentFilm)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
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
        "Hello"
    }
    
    
    
    
}
