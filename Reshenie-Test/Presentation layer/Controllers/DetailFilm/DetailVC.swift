//
//  DetailVC.swift
//  Reshenie-Test
//
//  Created by Kovs on 03.06.2023.
//

//
//  DetailVC.swift
//  NewsToDay
//
//  Created by Kovs on 15.05.2023.
//

import UIKit
import SnapKit

final class DetailVC: UIViewController {
    
    var presenter: DetailViewPresenterProtocol!
    let symbolConfig = UIImage.SymbolConfiguration(pointSize: 22)
    
    // MARK: - Dynamic UI Properties
    
    let titleLabel = UILabel()
    let bodyLabel = UILabel(textAlignment: .natural, numberOfLines: 0, textColor: .systemGray)
    let genreLabel = UILabel(textAlignment: .natural, numberOfLines: 0, textColor: .systemGray)
    let countryLabel = UILabel(textAlignment: .natural, numberOfLines: 0, textColor: .systemGray)
    let yearLabel = UILabel(textAlignment: .natural, numberOfLines: 0, textColor: .systemGray)
    
    // MARK: - Static UI Properties
    let backB = UIButton()
    let linkB = UIButton()
    
    
    // MARK: - Main properties
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .systemBackground
        scrollView.alwaysBounceHorizontal = false
        scrollView.contentInsetAdjustmentBehavior = .never
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    lazy var formView: UIView = {
        let formView = UIView()
        formView.backgroundColor = .systemBackground
        formView.layer.cornerRadius = 12
        
        formView.translatesAutoresizingMaskIntoConstraints = false
        
        return formView
    }()
    
    lazy var imageContainer: UIView = {
        let imageContainer = UIView()
        imageContainer.backgroundColor = .clear
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        
        return imageContainer
    }()
    
    lazy var backImage: FilmImageView = {
        let back = FilmImageView(frame: .zero)
        back.backgroundColor = .black
        back.contentMode = .scaleAspectFill
        back.clipsToBounds = true
        back.isUserInteractionEnabled = true
        
        back.translatesAutoresizingMaskIntoConstraints = false
        
        return back
    }()
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setfilm(film: presenter.film!)
        
        navigationController?.isNavigationBarHidden = true
        
        addViews()
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeGesture.direction = .right
        view.addGestureRecognizer(swipeGesture)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    
    // MARK: - UI Elements functions
    func configureBodyLabel() {
        formView.addSubviews(bodyLabel)
        bodyLabel.textAlignment = .natural
        bodyLabel.numberOfLines = 0
        bodyLabel.textColor = .systemGray
        
        bodyLabel.snp.makeConstraints { make in
            make.leading.equalTo(formView).offset(25)
            make.trailing.equalTo(formView).offset(-25)
            make.top.equalTo(titleLabel).inset(30)
        }
    }
    
    func configureTitleLabel() {
        formView.addSubviews(titleLabel)
        titleLabel.textAlignment = .natural
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = 0
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(formView.snp.top).offset(25)
            make.leading.equalTo(formView.snp.leading).inset(25)
            make.trailing.equalTo(formView.snp.trailing).offset(-25)
        }
    }
    
    func configureGenreLabel() {
        guard let text = genreLabel.text else { return }
        
        formView.addSubviews(genreLabel)
        
        genreLabel.font = UIFont.systemFont(ofSize: 16)
        genreLabel.attributedText = UILabel.returnAttributedStringForElementsInDetail(of: Texts.genres, for: text)
        
        genreLabel.snp.makeConstraints { make in
            make.top.equalTo(bodyLabel.snp.bottom).offset(10)
            make.leading.equalTo(formView.snp.leading).inset(25)
            make.trailing.equalTo(formView.snp.trailing).offset(-25)
        }
    }
    
    func configureCountryLabel() {
        guard let text = countryLabel.text else { return }
        formView.addSubviews(countryLabel)
        print(text)
        
        countryLabel.font = UIFont.systemFont(ofSize: 16)
        countryLabel.attributedText = UILabel.returnAttributedStringForElementsInDetail(of: Texts.countries, for: text)
        
        countryLabel.snp.makeConstraints { make in
            make.top.equalTo(genreLabel.snp.bottom).offset(10)
            make.leading.equalTo(formView.snp.leading).inset(25)
            make.trailing.equalTo(formView.snp.trailing).offset(-25)
        }
    }
    
    func configureYearLabel() {
        guard let text = yearLabel.text else { return }
        formView.addSubviews(yearLabel)
        
        yearLabel.font = UIFont.systemFont(ofSize: 16)
        yearLabel.attributedText = UILabel.returnAttributedStringForElementsInDetail(of: Texts.year, for: text)
        
        yearLabel.snp.makeConstraints { make in
            make.top.equalTo(countryLabel.snp.bottom).offset(10)
            make.leading.equalTo(formView.snp.leading).inset(25)
            make.trailing.equalTo(formView.snp.trailing).offset(-25)
        }
    }
    

    
    func configureBackButton() {
        backImage.addSubview(backB)
        backImage.bringSubviewToFront(backB)
        backB.translatesAutoresizingMaskIntoConstraints = false
        
        backB.setImage(UIImage(systemName: "arrow.backward", withConfiguration: symbolConfig), for: .normal)
        backB.tintColor = .white
        
        backB.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        backB.isUserInteractionEnabled = true
        
        backB.snp.makeConstraints { make in
            make.top.equalTo(backImage.snp.top).offset(120)
            make.leading.equalTo(backImage.snp.leading).inset(25)
        }
    }
    
    
    // MARK: - Main Layout functions
    func configureSV() {
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
    }
    
    func configureContainer() {
        let g = scrollView.contentLayoutGuide
        
        NSLayoutConstraint.activate([
            imageContainer.widthAnchor.constraint(equalToConstant: view.bounds.width),
            imageContainer.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.7),
            
            imageContainer.topAnchor.constraint(equalTo: g.topAnchor, constant: -50),
            imageContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func configureImage() {
        let topConstant = backImage.topAnchor.constraint(equalTo: view.topAnchor, constant: -50)
        topConstant.priority = .defaultHigh

        let heightConstraint = backImage.heightAnchor.constraint(greaterThanOrEqualTo: imageContainer.heightAnchor)
        heightConstraint.priority = .required
        
        NSLayoutConstraint.activate([
            backImage.widthAnchor.constraint(equalToConstant: view.bounds.width),
            heightConstraint,
            
            topConstant,
            backImage.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor),
            backImage.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor)

        ])
    }
    
    func configureFormView() {
        let g = scrollView.contentLayoutGuide
        
        NSLayoutConstraint.activate([
            formView.widthAnchor.constraint(equalToConstant: view.bounds.width),
            formView.heightAnchor.constraint(equalToConstant: view.bounds.height - 80),
            
            formView.topAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: -40),
            formView.leadingAnchor.constraint(equalTo: g.leadingAnchor),
            formView.trailingAnchor.constraint(equalTo: g.trailingAnchor),
            formView.bottomAnchor.constraint(equalTo: g.bottomAnchor)
        ])
    }

    
    
    // MARK: - Other functions
    @objc func closeVC() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func gav() {
        print("gav")
    }
    
    @objc func bookmarkIt() {
        print("book")
    }
    
    @objc func openSafari() {
        presenter?.openLink(vc: self)
        print("open safari")
    }
    
    @objc func handleSwipeGesture(_ gestureRecognizer: UISwipeGestureRecognizer) {
        if gestureRecognizer.direction == .right {
            navigationController?.popViewController(animated: true)
        }
    }
    
    func addViews() {
        view.addSubviews(scrollView)
        scrollView.addSubviews(imageContainer, backImage, formView)
        
        // base
        configureSV()
        configureContainer()
        configureImage()
        configureFormView()
       
        // labels
        configureTitleLabel()
        configureBodyLabel()
        configureGenreLabel()
        configureCountryLabel()
        configureYearLabel()

        configureBackButton()
        
    }
    
    
}

// MARK: - DetailViewProtocol
extension DetailVC: DetailViewProtocol {
    
    func setfilm(film: Film) {
        // UI code here
        titleLabel.text = film.nameRu
        bodyLabel.text = film.description
        genreLabel.text = getGenres(film: film)
        countryLabel.text = getCountries(film: film)
        yearLabel.text = "\(Texts.year)\(film.year)"
        
        backImage.setupImage(film: film)
    }
    
    func getGenres(film: Film) -> String {
        var finalString = Texts.genres
        if film.genres.count > 1 {
            for genre in film.genres {
                finalString.append(contentsOf: genre.genre)
                finalString.append(", ")
            }
        } else {
            for genre in film.genres {
                finalString.append(contentsOf: genre.genre)
            }
        }
        return finalString
    }
    
    func getCountries(film: Film) -> String {
        var finalString = Texts.countries
        if film.countries.count > 1 {
            for country in film.countries {
                finalString.append(contentsOf: country.country)
                finalString.append(", ")
            }
        } else {
            for country in film.countries {
                finalString.append(contentsOf: country.country)
            }
        }
        return finalString
    }
    
    
}
