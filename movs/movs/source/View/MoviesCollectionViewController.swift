//
//  FirstViewController.swift
//  movs
//
//  Created by Lorien on 15/04/19.
//  Copyright © 2019 Lorien. All rights reserved.
//

import UIKit

class MoviesCollectionViewController: UIViewController, MoviesViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: MoviesPresenter!
    var favoritesPresenter: FavoritesPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        
        presenter = MoviesPresenter(vc: self)
        presenter.getMovies()
        
        favoritesPresenter = FavoritesPresenter(vc: self)
        favoritesPresenter.getFavorites()
    }
    
    func updateData() {
        collectionView.reloadData()
    }

}

extension MoviesCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionCell
        cell.setup(with: presenter.movies[indexPath.row])
        return cell
    }
    
}

extension MoviesCollectionViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !presenter.isRequesting else { return }
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            presenter.getNewPage()
        }
    }
    
}
