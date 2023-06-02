//
//  ImageClient.swift
//  Reshenie-Test
//
//  Created by Kovs on 02.06.2023.
//


import UIKit

protocol ImageClientService {
    func downloadImage<Request: DataRequest>(request: Request, completion: @escaping (UIImage?, Error?) -> Void)
    func setImage(from url: String, placeholderImage: UIImage?, completion: @escaping (UIImage?) -> Void)
}

final class ImageClient {
    
    static let shared = ImageClient(
        responseQueue: .main,
        session: URLSession.shared
    )
    
    private(set) var cachedImage: [String: UIImage]
    
    let responseQueue: DispatchQueue?
    let session: URLSession
    
    init(responseQueue: DispatchQueue?, session: URLSession) {
        self.cachedImage = [:]
        
        self.responseQueue = responseQueue
        self.session = session
    }
    
    private func dispatchImage(
        image: UIImage? = nil,
        error: Error? = nil,
        completion: @escaping (UIImage?, Error?
        ) -> Void) {
        
        guard let responseQueue = responseQueue else {
            completion(image, error)
            return
        }
        
        responseQueue.async {
            completion(image, nil)
        }
    }
}

extension ImageClient: ImageClientService {
    func downloadImage<Request: DataRequest>(request: Request,
                                             completion: @escaping (UIImage?, Error?) -> Void) {
        
        let service: NetworkService = DefaultNetworkService()
        
        service.request(request) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let response):
                guard let image: UIImage = response as? UIImage else {
                    return
                }
                
                self.dispatchImage(image: image, completion: completion)
            case .failure(let error):
                self.dispatchImage(error: error, completion: completion)
            }
        }
    }
    
    func setImage(from url: String,
                  placeholderImage: UIImage?,
                  completion: @escaping (UIImage?) -> Void) {
        let request = ImageRequest(url: url)
        if let cacheImage = cachedImage[url] {
            completion(cacheImage)
        } else {
            downloadImage(request: request) { [weak self] image, error in
                guard let self = self else { return }
                if error != nil {
                    completion(placeholderImage)
                }
                guard let image = image else {
                    completion(placeholderImage)
                    return
                }
                self.cachedImage[url] = image
                completion(self.cachedImage[url])
            }
        }
    }
}

