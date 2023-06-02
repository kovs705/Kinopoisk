//
//  FilmCell.swift
//  Reshenie-Test
//
//  Created by Kovs on 02.06.2023.
//

import UIKit
import SnapKit

class FilmCell: UITableViewCell {

    static let id = "filmCell"
    
    private var baseBack = UIView()
    private var nameLabel = UILabel()
    private var filmImageView = UIImageView()
    private var genreAndYearLabel = UILabel()
    
    private var loadingActivityIndicator = UIActivityIndicatorView(style: .medium)
    let placeholderImg = UIImage(named: Images.kinopoisk)
    
    func setupCell(film: Film) {
        configure(film: film)
        
        setupViews()
        setLayout()
    }
    
    private func configure(film: Film) {
        nameLabel.text = film.nameRu
        genreAndYearLabel.text = "\(film.genres) (\(film.year))"
        setupImage(film: film)
    }
    
    func setupImage(film: Film) {
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
        nameLabel.font = UIFont.systemFont(ofSize: 17)
    }
    
    private func setupGenreAndYearLabel() {
        genreAndYearLabel.numberOfLines = 2
        genreAndYearLabel.font = UIFont.systemFont(ofSize: 14)
        genreAndYearLabel.textColor = .gray
    }
    
    private func setupBaseBack() {
        baseBack.layer.cornerRadius = 20
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
            make.leading.trailing.top.bottom.equalTo(contentView).inset(20)
        }
        
        filmImageView.snp.makeConstraints { make in
            make.centerX.equalTo(baseBack)
            make.top.leading.bottom.equalTo(baseBack)
            make.width.equalTo(35)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(baseBack).inset(25)
            make.leading.equalTo(filmImageView.snp.trailing).inset(15)
            make.trailing.equalTo(baseBack.snp.trailing).inset(25)
        }
        
        genreAndYearLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).inset(15)
            make.leading.equalTo(filmImageView.snp.trailing).inset(15)
            make.trailing.equalTo(baseBack.snp.trailing).inset(25)
        }
    }
    

}
