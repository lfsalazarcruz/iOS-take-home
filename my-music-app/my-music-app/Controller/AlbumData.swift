//
//  AlbumData.swift
//  my-music-app
//
//  Created by luis salazar on 10/30/19.
//  Copyright © 2019 F Productions. All rights reserved.
//

import UIKit

class AlbumData: UIViewController {

    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var dateReleased: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var recordLabel: UILabel!
    
    var albumString = ""
    var artistString = ""
    var imageUrl = UIImage()
    var date = ""
    var musicGenre = ""
    var record = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumImage.image = imageUrl
        albumName.text = albumString
        artistName.text = artistString
        dateReleased.text = date
        genre.text = musicGenre
        recordLabel.text = record
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
