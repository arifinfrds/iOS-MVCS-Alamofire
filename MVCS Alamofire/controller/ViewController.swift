//
//  ViewController.swift
//  MVCS Alamofire
//
//  Created by Arifin Firdaus on 7/12/18.
//  Copyright © 2018 Arifin Firdaus. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        attemptFetchPhoto(withId: 1)
    }
    
    // MARK: - Networking
    func attemptFetchPhoto(withId id: Int) {
        DataService.shared.requestFetchPhoto(with: id) {[weak self] (photo, error) in
            if let error = error {
                print("error: \(error.localizedDescription)")
                return
            }
            guard let photo = photo else {
                return
            }
            self?.updateUI(with: photo)
        }
    }
    
    // MARK: - UI Setup
    func updateUI(with photo: Photo) {
        print("photo: \(photo)")
        // change http to https with own extension function first
        if
            let urlString = photo.url,
            let finalUrlString = String.replaceHttpToHttps(with: urlString),
            let url = URL(string: finalUrlString),
            let title = photo.title,
            let albumId = photo.albumID
        {
            headerImageView.sd_setImage(with: url, completed: nil)
            titleLabel.text = title
            subtitleLabel.text = "This photo has albumID: \(albumId)"
        }
    }
    
    
}

