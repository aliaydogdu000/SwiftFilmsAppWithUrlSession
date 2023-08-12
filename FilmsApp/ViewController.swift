//
//  ViewController.swift
//  FilmsApp
//
//  Created by Ali Aydoğdu on 5.02.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var categoryTableView: UITableView!
    
    var kategoriListe = [Kategoriler]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        getAllCategory()
    }
    func getAllCategory(){
        let url = URL(string: "http://kasimadalan.pe.hu/filmler/tum_kategoriler.php")!
        
        URLSession.shared.dataTask(with: url){ data,response,error in
            if error != nil || data == nil{
                print( "HATA!")
                return
            }
            do{
                let response = try JSONDecoder().decode(Kategori.self,from: data!)
                if let categoryList = response.kategoriler {
                    self.kategoriListe = categoryList
                }
                DispatchQueue.main.async {
                    self.categoryTableView.reloadData()
                }
            }catch{
                print(error.localizedDescription
                )
            }
            
        }.resume()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = sender as? Int
        let toVc = segue.destination as! FilmViewController
        toVc.kategori = kategoriListe[index!]
    }
    

}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kategoriListe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kategori = kategoriListe[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell",for: indexPath) as! CategoryCellTableViewCell
        cell.labelCategoryName.text = kategori.kategori_ad
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toFilm", sender: indexPath.row)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
}
