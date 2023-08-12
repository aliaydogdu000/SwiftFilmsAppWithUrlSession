//
//  CollectionViewCell.swift
//  FilmsApp
//
//  Created by Ali Aydoğdu on 5.02.2023.
//

import UIKit

protocol FilmCellProtocol{
    func addTo(indexPath:IndexPath)
}


class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var labelFilmPrice: UILabel!
    @IBOutlet weak var labelFilmName: UILabel!
    @IBOutlet weak var imageFilm: UIImageView!
    
    var cellProtocol:FilmCellProtocol?
    var indexPath:IndexPath?
    
    @IBAction func buttonAdd(_ sender: Any) {
        cellProtocol?.addTo(indexPath: indexPath!)
    }
}
