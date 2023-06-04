//
//  FilmImageView.swift
//  Reshenie-Test
//
//  Created by Kovs on 03.06.2023.
//

import UIKit

class FilmImageView: UIImageView {
    
    let cache               = ImageClient.shared.cachedImage
    let placeholderImage    = UIImage(named: Images.kinopoisk)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setupImage(film: Film) {
        guard let urlToImage = film.posterUrlPreview else { return }
        ImageClient.shared.setImage(
            from: urlToImage,
            placeholderImage: placeholderImage
        ) { [weak self] image in
            guard let image else {
                self?.image = image
                return
            }
            self?.image = image
        }
    }
    
}

