//
//  ViewController.swift
//  new
//
//  Created by Ahmed Burham on 12/11/17.
//  Copyright © 2017 Ahmed Burham. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    var array = [Movie]()
    @IBOutlet weak var collection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let  url = "https://api.themoviedb.org/3/movie/top_rated?api_key=90b29a16adf0d3f819e9f2a88ae669d9"
        Alamofire.request(url).responseJSON{response in
        
        let  switftyjson = JSON(response.result.value as Any)
        
            let jsonobject = switftyjson["results"].rawValue as! [[String:Any]]
            for  item in jsonobject{
               self.array.append(Movie(json:item))
            self.collection.reloadData()
            }
        }
           }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    func downloadImage(url: URL, myImage:UIImageView) {
        //print("Download Started")
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
          //  print("Download Finished")
            DispatchQueue.main.async() {
                myImage.image = UIImage(data: data)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)as! CollectionViewCell
      let y = URL(string: array[indexPath.row].poster_path)
        downloadImage(url: y!, myImage: cell.image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let main = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = main.instantiateViewController(withIdentifier: "NewViewController" )as! NewViewController
        vc.curr = array[indexPath.row]
        self.show(vc, sender: self)
 
        //array.remove(at: indexPath.row)
 }

}













