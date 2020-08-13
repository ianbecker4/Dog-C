//
//  IRBDogViewController.swift
//  Dog-C
//
//  Created by Ian Becker on 8/13/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

import UIKit

class IRBDogViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var dogSearchBar: UISearchBar!
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var dogBreedLabel: UILabel!
    
    var dog: IRBDog? {
        didSet {
            guard let dog = dog else {return}
            fetchImageAndUpdateViews(for: dog)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dogSearchBar.delegate = self
    }
    
    // MARK: - Private Methods
    private func fetchImageAndUpdateViews(for dog: IRBDog) {
        
        IRBDogController.sharedInstance().fetchDogImage(dog) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .none:
                    self.dogImageView.image = nil
                    self.dogBreedLabel.text = "No breed by that name..."
                case .some(let image):
                    self.dogImageView.image = image
                    self.dogBreedLabel.text = "\(self.dogSearchBar.text ?? "")"
                }
            }
        }
    }
}

extension IRBDogViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return}
        
        IRBDogController.sharedInstance().fetchDog(forSearchTerm: searchTerm) { (dog) in
            self.dog = dog
        }
    }
}
