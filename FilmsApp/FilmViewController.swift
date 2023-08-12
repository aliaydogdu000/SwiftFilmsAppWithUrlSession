//
//  FilmViewController.swift
//  FilmsApp
//
//  Created by Ali Aydoğdu on 5.02.2023.
//

import UIKit

class FilmViewController: UIViewController {

    @IBOutlet weak var filmCollectionView: UICollectionView!
    var filmListesi = [Filmler]()
    var kategori : Kategoriler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        filmCollectionView.delegate = self
        filmCollectionView.dataSource = self
        
        let design:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = self.filmCollectionView.frame.size.width
        
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let cellWidth = (width-30)/2
        design.itemSize = CGSize(width: cellWidth, height: cellWidth*1.85)
        
        design.minimumInteritemSpacing = 10
        design.minimumLineSpacing = 10
        
        filmCollectionView.collectionViewLayout = design
        
        
        if let k = kategori{
            if let kid = Int(k.kategori_id!){
                navigationItem.title = k.kategori_ad
                getFilmsByCategory(kategori_id: kid )
            }
            
        }
        
        
    }
    func getFilmsByCategory(kategori_id:Int ){
        var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/filmler/filmler_by_kategori_id.php")!)
        request.httpMethod = "POST"
        let body = "kategori_id=\(kategori_id)"
        request.httpBody = body.data(using: .utf8)
        URLSession.shared.dataTask(with: request){ data,response,error in
            if error != nil || data == nil{
                print( "HATA!")
                return
            }
            do{
                let response = try JSONDecoder().decode(Film.self,from: data!)
                if let filmList = response.filmler {
                    self.filmListesi = filmList
                }
                DispatchQueue.main.async {
                    self.filmCollectionView.reloadData()
                }
            }catch{
                print(error.localizedDescription
                )
            }
            
        }.resume()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        let toVc = segue.destination as! FimDetailViewController
        toVc.film = filmListesi[indeks!]
    }

  
}
extension FilmViewController:UICollectionViewDelegate,UICollectionViewDataSource,FilmCellProtocol{
    func addTo(indexPath: IndexPath) {
        print("added \(filmListesi[indexPath.row].film_ad!)")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filmListesi.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let film = filmListesi[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filmCell",for: indexPath) as! CollectionViewCell
        cell.labelFilmName.text = film.film_ad
        cell.labelFilmPrice.text = "14.00TL"
        
        if let url = URL(string: "http://kasimadalan.pe.hu/filmler/resimler/\(film.film_resim!)"){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    cell.imageFilm.image = UIImage(data: data!)
                }
            }
        }
        
        cell.imageFilm.image = UIImage(named: film.film_resim ?? "")
        cell.cellProtocol = self
        cell.indexPath = indexPath
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetail", sender: indexPath.row)
    }
    
}
