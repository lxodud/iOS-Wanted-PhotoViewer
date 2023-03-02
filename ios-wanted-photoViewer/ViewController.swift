//
//  ViewController.swift
//  ios-wanted-photoViewer
//
//  Created by 이태영 on 2023/03/01.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet var imageViews: [UIImageView]!
    
    private let imageURL: [String] = [ "https://wallpaperaccess.com/download/europe-4k-1369012",
        "https://wallpaperaccess.com/download/europe-4k-1318341",
        "https://wallpaperaccess.com/download/europe-4k-1379801",
        "https://wallpaperaccess.com/download/cool-lion-167408",
        "https://wallpaperaccess.com/download/ironman-hd-323408"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for (index, urlString) in imageURL.enumerated() {
            let url = URL(string: urlString)!
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard error == nil else { return }
                
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode)
                else {
                    return
                }
                
                guard let data = data,
                      let image = UIImage(data: data)
                else {
                    return
                }
                
                DispatchQueue.main.sync {
                    self.imageViews[index].image = image
                }
            }.resume()
        }
    }
}

// MARK: View Configuration
extension ViewController {
    private func configureSubview() {
        
    }
}
