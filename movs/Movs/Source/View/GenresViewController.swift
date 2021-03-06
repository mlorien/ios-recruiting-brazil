//
//  GenresViewController.swift
//  movs
//
//  Created by Lorien Moisyn on 20/04/19.
//  Copyright © 2019 Auspex. All rights reserved.
//

import Foundation

class GenresViewController: BaseFilterViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getGenres()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        parent?.children.forEach{
            guard let filterVC = $0 as? FilterTypesTableViewController else { return }
            filterVC.genreNames = selected
        }
    }
    
}
