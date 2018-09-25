//
//  NewViewController.swift
//  new
//
//  Created by Ahmed Burham on 12/22/17.
//  Copyright © 2017 Ahmed Burham. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {
    var curr:Movie!
    @IBOutlet weak var overview: UITextView!
   
    @IBOutlet weak var newtitle: UILabel!
    @IBOutlet weak var voting: UILabel!
    @IBOutlet weak var newimage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        overview.text = curr.overview
        newtitle.text = curr.title
        voting.text = "voting \(curr.vote_average)"
        //newimage.text = curr.poster_path
        overview.isEditable = false
        let myURL = URL(string: curr.poster_path)!
        downloadImage(url: myURL, myImage: newimage)
        
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
            //print("Download Finished")
            DispatchQueue.main.async() {
                myImage.image = UIImage(data: data)
            }
        }
    }

}
