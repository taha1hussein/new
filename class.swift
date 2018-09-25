//
//  class.swift
//  new
//
//  Created by Ahmed Burham on 12/11/17.
//  Copyright © 2017 Ahmed Burham. All rights reserved.
//

import Foundation
import SwiftyJSON
class Movie{
    var id:Int!
    var vote_average:Int!
    var title:String!
    var poster_path:String!
    var overview:String!
    var adult:Bool!
    init(json:[String:Any]){
        id = json["id"]as! Int
        title = json["title"]as! String
        vote_average = json["vote_average"]as! Int
        let cover = json["poster_path"]as! String
        poster_path = "https://image.tmdb.org/t/p/w500\(cover)"
        overview = json["overview"]as! String
        adult = json["adult"]as! Bool
    }
}
