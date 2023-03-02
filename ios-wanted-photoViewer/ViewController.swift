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
    private let semaphore = DispatchSemaphore(value: 1)
    
    @IBOutlet var imageViews: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func loadImage(with url: URL, at index: Int) {
        imageViews[index].image = UIImage(systemName: "photo")
    
        imageLoader.loadImage(with: url) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.imageViews[index].image = image
                    self.semaphore.signal()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: Action Method
extension ViewController {
    @IBAction func tapFirstImageLoadButton(_ sender: UIButton) {
        let index = sender.tag
        
        guard let url = ImageLoadRequest(path: ImageNumber.mountain.rawValue).convertURL() else {
            return
        }
        
        loadImage(with: url, at: index)
    }
    
    @IBAction func tapSecondImageLoadButton(_ sender: UIButton) {
        let index = sender.tag
        
        guard let url = ImageLoadRequest(path: ImageNumber.river.rawValue).convertURL() else {
            return
        }
        
        loadImage(with: url, at: index)
    }
    
    @IBAction func tapThirdImageLoadButton(_ sender: UIButton) {
        let index = sender.tag
        
        guard let url = ImageLoadRequest(path: ImageNumber.alley.rawValue).convertURL() else {
            return
        }
        
        loadImage(with: url, at: index)
    }
    
    @IBAction func tapFourthImageLoadButton(_ sender: UIButton) {
        let index = sender.tag
        
        guard let url = ImageLoadRequest(path: ImageNumber.lion.rawValue).convertURL() else {
            return
        }
        
        loadImage(with: url, at: index)
    }
    
    @IBAction func tapFifthImageLoadButton(_ sender: UIButton) {
        let index = sender.tag
        
        guard let url = ImageLoadRequest(path: ImageNumber.ironMan.rawValue).convertURL() else {
            return
        }
        
        loadImage(with: url, at: index)
    }
    
    @IBAction func tapLoadAllButton(_ sender: Any) {
        for (index, imageNumber) in zip(0...4, ImageNumber.allCases) {
            guard let url = ImageLoadRequest(path: imageNumber.rawValue).convertURL() else {
                return
            }
            
            loadImage(with: url, at: index)
        }
    }
}
