//
//  CustomCell.swift
//  my-music-app
//
//  Created by luis salazar on 10/29/19.
//  Copyright © 2019 F Productions. All rights reserved.
//

import Foundation
import UIKit

class CustomCell : UITableViewCell {
    var albumName : String?
    var artistName : String?
    var albumImage: UIImage?
    
    //Stack to center album image inside row
    var verticalStack1 : UIStackView = {
           var stack = UIStackView()
           stack.axis = .horizontal
           stack.alignment = .center
           stack.translatesAutoresizingMaskIntoConstraints = false
           stack.distribution = .fillEqually
           return stack
    }()
    
    //Stack is a non-rendering element, so no background color unless I add a UIView inside it
    var verticalStack2 : UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.spacing = -60
        return stack
    }()
    
    var albumImageView : UIImageView = {
       var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var albumView : UILabel = {
        var myAlbumView = UILabel()
        myAlbumView.translatesAutoresizingMaskIntoConstraints = false
        myAlbumView.textAlignment = NSTextAlignment.center
        myAlbumView.font = myAlbumView.font.withSize(20)
        myAlbumView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        return myAlbumView
    }()
    
    var artistView : UILabel = {
        var myArtistView = UILabel()
        myArtistView.translatesAutoresizingMaskIntoConstraints = false
        myArtistView.textAlignment = NSTextAlignment.center
        return myArtistView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(verticalStack1)
        self.addSubview(verticalStack2)
        self.addSubview(albumImageView)
        self.addSubview(albumView)
        self.addSubview(artistView)
        
        //Stack constraints for Album Image
        verticalStack1.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        verticalStack1.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        verticalStack1.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        verticalStack1.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        //Vertical Stack constraints for UILabels
        verticalStack2.leftAnchor.constraint(equalTo: self.verticalStack1.rightAnchor).isActive = true
        verticalStack2.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        verticalStack2.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        verticalStack2.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        //Nesting labels in Stacks
        verticalStack1.addArrangedSubview(albumImageView)
        verticalStack2.addArrangedSubview(albumView)
        verticalStack2.addArrangedSubview(artistView)
        
        //Album image constraints
        albumImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        albumImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        albumImageView.centerXAnchor.constraint(equalTo: self.verticalStack1.centerXAnchor).isActive = true
        albumImageView.centerYAnchor.constraint(equalTo: self.verticalStack1.centerYAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let image = albumImage {
            albumImageView.image = image
        }
        if let album = albumName {
            albumView.text = album
        }
        if let artist = artistName {
            artistView.text = artist
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
