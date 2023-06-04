//
//  DetailPresenter.swift
//  Reshenie-Test
//
//  Created by Kovs on 03.06.2023.
//

import UIKit
import SafariServices

protocol DetailViewProtocol: AnyObject {
    func setfilm(film: Film)
}

protocol DetailViewPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol, film: Film?)
    func openLink(vc: UIViewController)
    
    var film: Film? { get }
}


class DetailPresenter: DetailViewPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    var film: Film?
    
    required init(view: DetailViewProtocol, film: Film?) {
        self.view = view
        self.film = film
    }
    
    func openLink(vc: UIViewController) {
        let safariVC = SFSafariViewController(url: (URL(string: "https://github.com/kovs705"))!)
        safariVC.preferredControlTintColor = UIColor(named: Colors.rtBlue)
        vc.present(safariVC, animated: true)
    }
    
    
    
    
}
