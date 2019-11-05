//
//  AlbumListScreen.swift
//  my-music-app
//
//  Created by luis salazar on 10/29/19.
//  Copyright © 2019 F Productions. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class AlbumListScreen: UITableViewController {
    var API_URL = "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/25/explicit.json"

    @IBOutlet var myTableView: UITableView!
    
    // Variable storing fetched album data when app starts
    var albumsArray = [AnyObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fetching data from API and updating the albumsArray variable
        fetchData()
        
        //Using my custom cell
        self.tableView.register(CustomCell.self, forCellReuseIdentifier: "custom")
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.rowHeight = 150

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return albumsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "custom") as! CustomCell

        let album = albumsArray[indexPath.row]["name"]
        let artist = albumsArray[indexPath.row]["artistName"]
        let imageLink = albumsArray[indexPath.row]["artworkUrl100"] as? String
        
        if let url = URL(string: imageLink!) {
            cell.albumImageView.kf.setImage(with: url)
        }
//        if let imageUrl = URL(string: imageLink!) {
//            let data = try? Data(contentsOf: imageUrl)
//            if let data = data {
//                let image = UIImage(data: data)
//                    cell.albumImage = image
//            }
//        }
        
        
        
        cell.albumName = album as? String
        cell.artistName = artist as? String
 
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        return cell
    }
    
    // Passing data to AlbumData controller when clicked on a table row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewData = storyboard?.instantiateViewController(withIdentifier: "AlbumData") as? AlbumData
        let album = albumsArray[indexPath.row]["name"]
        let artist = albumsArray[indexPath.row]["artistName"]
        let imageLink = albumsArray[indexPath.row]["artworkUrl100"] as? String
        let recordLabel = albumsArray[indexPath.row]["copyright"]
        let releasedDate = albumsArray[indexPath.row]["releaseDate"]
        let genreArray = albumsArray[indexPath.row]["genres"]

        var genreString = ""
        
        //Creates a string of genres for every album
        for genre in genreArray as! [[String:Any]] {
            let name = genre["name"] as! String
            if name != "Music" {
                genreString += "\(name) "
            }
        }
        
        viewData?.albumString = album as! String
        viewData?.artistString = artist as! String
        viewData?.record = recordLabel as! String
        viewData?.date = releasedDate as! String
        viewData?.musicGenre = genreString
        
        
        if let imageUrl = URL(string: imageLink!) {
            let data = try? Data(contentsOf: imageUrl)
            if let data = data {
                let image = UIImage(data: data)
                    viewData?.imageUrl = image!
            }
        }
        
        self.navigationController?.pushViewController(viewData!, animated: true)
    }
    
    // MARK: - FETCHING DATA
    func fetchData(){
        DispatchQueue.main.async {
            Alamofire.request(self.API_URL, method: .get).responseJSON(completionHandler: {(response) in
                
                let result = response.result
                if let dict = result.value as? Dictionary<String,AnyObject> {
                    if let innerDict = dict["feed"] {
                        if let innerDict = innerDict["results"] {
                            // Updates albumsArray variable with new data
                            self.albumsArray = innerDict as! [AnyObject]
                            // Reloads the rows and sections of the tableview with the album's data after receiving the response from Apple's API
                            self.tableView.reloadData()
                            print(self.albumsArray)
                        }
                    }
                }
            })
        }
    }

    //override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    //return 1
    //}
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
