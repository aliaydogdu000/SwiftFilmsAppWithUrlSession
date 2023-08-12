//
//  FimDetailViewController.swift
//  FilmsApp
//
//  Created by Ali Aydoğdu on 5.02.2023.
//

import UIKit

class FimDetailViewController: UIViewController {
    
    var film:Filmler?

    @IBOutlet weak var labelFilmName: UILabel!
    @IBOutlet weak var labelFilmYear: UILabel!
    @IBOutlet weak var labelFilmCategory: UILabel!
    @IBOutlet weak var labelFilmDirector: UILabel!
    @IBOutlet weak var imageFilmDetail: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let f = film {
            if let url = URL(string: "http://kasimadalan.pe.hu/filmler/resimler/\(f.film_resim!)"){
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url)
                    
                    DispatchQueue.main.async {
                        self.imageFilmDetail.image = UIImage(data: data!)
                    }
                    
                }
            }
            labelFilmName.text = f.film_ad
            labelFilmYear.text = f.film_yil
            labelFilmCategory.text = f.kategori?.kategori_ad
            labelFilmDirector.text = f.yonetmen?.yonetmen_ad
        }
    }
    


}
