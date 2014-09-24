//
//  imageViewCell.swift
//  FlickrGenerics
//
//  Created by Parthasarathy Gudivada on 9/24/14.
//  Copyright (c) 2014 Eagle River Solutions. All rights reserved.
//

import UIKit

class ImageViewCell: UICollectionViewCell
{
    var imageView : UIImageView?
    
    
   
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder : aDecoder)
      
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        imageView = UIImageView()
        self.imageView!.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.imageView!.contentMode = UIViewContentMode.ScaleToFill
        self.contentView.addSubview(imageView!)
        let viewsDictionary = [ "imageView" : imageView!]
        let iv_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|[imageView]|",
            options:NSLayoutFormatOptions.allZeros,
            metrics: nil,
            views: viewsDictionary)
        let iv_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|[imageView]|",
            options:NSLayoutFormatOptions.allZeros, metrics: nil, views: viewsDictionary)
        self.contentView.addConstraints(iv_constraint_H)
        self.contentView.addConstraints(iv_constraint_V)

    }
    
    
}
