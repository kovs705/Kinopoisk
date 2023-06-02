//
//  MainVC.swift
//  Reshenie-Test
//
//  Created by Kovs on 31.05.2023.
//

import UIKit

class MainVC: UIViewController {
    
    var presenter: MainPresenterProtocol!
    
    private var tableView = UITableView()
    private var emptyView = UIView()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
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
            make.leading.trailing.top.bottom.equalTo(view)
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

extension MainVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.topFilms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TopFilmCell.id, for: indexPath) as! TopFilmCell
        let currentFilm = presenter.topFilms[indexPath.row]
        cell.setupCell(film: currentFilm)
        return cell
    }
    
    
}

extension MainVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentFilm = presenter.topFilms[indexPath.row]
        print(currentFilm)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
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
