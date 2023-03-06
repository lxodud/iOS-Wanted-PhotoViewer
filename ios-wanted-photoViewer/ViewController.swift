//
//  ViewController.swift
//  ios-wanted-photoViewer
//
//  Created by 이태영 on 2023/03/01.
//

import UIKit

enum ImageNumber: String, CaseIterable {
    case mountain = "1369012"
    case river = "1318341"
    case alley = "1379801"
    case lion = "167408"
    case ironMan = "323408"
}

final class ViewController: UIViewController {
    private let imageLoader = ImageLoader()
    
    @IBOutlet private var imageViews: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func loadImage(with request: Requestable, at index: Int) {
        imageViews[index].image = UIImage(systemName: "photo")
    
        imageLoader.loadImage(with: request) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.imageViews[index].image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: Action Method
extension ViewController {
    @IBAction private func tapFirstImageLoadButton(_ sender: UIButton) {
        let index = sender.tag
        
        let imageLoadRequest = ImageLoadRequest(path: ImageNumber.mountain.rawValue)
        loadImage(with: imageLoadRequest, at: index)
    }
    
    @IBAction private func tapSecondImageLoadButton(_ sender: UIButton) {
        let index = sender.tag
        
        let imageLoadRequest = ImageLoadRequest(path: ImageNumber.river.rawValue)
        loadImage(with: imageLoadRequest, at: index)
    }
    
    @IBAction private func tapThirdImageLoadButton(_ sender: UIButton) {
        let index = sender.tag
        
        let imageLoadRequest = ImageLoadRequest(path: ImageNumber.alley.rawValue)
        loadImage(with: imageLoadRequest, at: index)
    }
    
    @IBAction private func tapFourthImageLoadButton(_ sender: UIButton) {
        let index = sender.tag
        
        let imageLoadRequest = ImageLoadRequest(path: ImageNumber.lion.rawValue)
        loadImage(with: imageLoadRequest, at: index)
    }
    
    @IBAction private func tapFifthImageLoadButton(_ sender: UIButton) {
        let index = sender.tag
        
        let imageLoadRequest = ImageLoadRequest(path: ImageNumber.ironMan.rawValue)
        loadImage(with: imageLoadRequest, at: index)
    }
    
    @IBAction private func tapLoadAllButton(_ sender: Any) {
        for (index, imageNumber) in zip(0...4, ImageNumber.allCases) {
            let imageLoadRequest = ImageLoadRequest(path: imageNumber.rawValue)
            loadImage(with: imageLoadRequest, at: index)
        }
    }
}
