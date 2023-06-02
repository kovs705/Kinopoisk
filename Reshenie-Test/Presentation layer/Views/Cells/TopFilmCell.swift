//
//  TopFilmCell.swift
//  Reshenie-Test
//
//  Created by Kovs on 02.06.2023.
//

import UIKit
import SnapKit

class TopFilmCell: UITableViewCell {

    static let id = "topFilmCell"
    
    private var baseBack = UIView()
    private var nameLabel = UILabel()
    private var filmImageView = UIImageView()
    private var genreAndYearLabel = UILabel()
    
    private var loadingActivityIndicator = UIActivityIndicatorView(style: .medium)
    let placeholderImg = UIImage(named: Images.kinopoisk)
    
    func setupCell(film: TopFilm) {
        configure(film: film)
        
        setupViews()
        setLayout()
    }
    
    private func configure(film: TopFilm) {
        nameLabel.text = film.nameRu
        genreAndYearLabel.text = "\(getGenres(film: film)) (\(film.year))"
        print(film.genres)
        setupImage(film: film)
    }
    
    func getGenres(film: TopFilm) -> String {
        var finalString = ""
        for genre in film.genres {
            finalString.append(contentsOf: genre.genre)
            finalString.append(", ")
        }
        return finalString
    }
    
    func setupImage(film: TopFilm) {
        guard let urlToImage = film.posterUrlPreview else {
            filmImageView.image = placeholderImg
            filmImageView.contentMode = .scaleAspectFill
            loadingActivityIndicator.stopAnimating()
            return
        }
        ImageClient.shared.setImage(
            from: urlToImage.absoluteString,
            placeholderImage: placeholderImg
        ) { [weak self] image in
            guard let self = self else { return }
            guard let image else {
                self.filmImageView.image = image
                self.filmImageView.contentMode = .scaleAspectFill
                self.loadingActivityIndicator.stopAnimating()
                return
            }
            self.filmImageView.image = image
            self.filmImageView.contentMode = .scaleAspectFill
            self.loadingActivityIndicator.stopAnimating()
        }
    }
    
    // MARK: - Setup configurations
    private func setupViews() {
        loadingActivityIndicator.startAnimating()
        setupBaseBack()
        setupFilmImageView()
        setupNameLabel()
        setupGenreAndYearLabel()
    }
    
    private func setupFilmImageView() {
        filmImageView.clipsToBounds = true
        filmImageView.layer.cornerRadius = 12
        filmImageView.contentMode = .scaleAspectFill
        filmImageView.backgroundColor = .lightGray
    }
    
    private func setupNameLabel() {
        nameLabel.numberOfLines = 1
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        genreAndYearLabel.textColor = .label
    }
    
    private func setupGenreAndYearLabel() {
        genreAndYearLabel.numberOfLines = 2
        genreAndYearLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        genreAndYearLabel.textColor = .gray
    }
    
    private func setupBaseBack() {
        baseBack.layer.cornerRadius = 20
        baseBack.backgroundColor = .systemBackground
        baseBack.addShadow(color: UIColor.black.cgColor, opacity: 0.3, shadowOffset: CGSize(width: 0, height: 5), shadowRadius: 10)
        
    }
    
    
    // MARK: - Setup Layout and Constraints
    
    private func setLayout() {
        contentView.addSubviews(baseBack)
        makeConstraints()
    }
    
    private func makeConstraints() {
        baseBack.addSubviews(nameLabel, filmImageView, genreAndYearLabel, loadingActivityIndicator)
        
        baseBack.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(contentView).inset(10)
        }
        
        filmImageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalTo(baseBack).inset(12)
            make.width.equalTo(60)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(baseBack.snp.top).offset(25)
            make.leading.equalTo(filmImageView.snp.trailing).inset(-20)
            make.trailing.equalTo(baseBack.snp.trailing).inset(25)
        }
        
        genreAndYearLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.leading.equalTo(filmImageView.snp.trailing).inset(-20)
            make.trailing.equalTo(baseBack.snp.trailing).inset(25)
        }
    }
    

}

