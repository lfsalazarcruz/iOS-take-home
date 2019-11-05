//
//  Genres.swift
//  my-music-app
//
//  Created by luis salazar on 10/31/19.
//  Copyright © 2019 F Productions. All rights reserved.
//

import UIKit

class Genres: Codable {
    let genreId : String
    let name : String
    let url : String
    
    init(genreId: String, name: String, url: String) {
        self.genreId = genreId
        self.name = name
        self.url = url
    }
}
