//
//  CollectionViewCell.swift
//  carousel effect with infinite scrolling
//
//  Created by Atik Hasan on 7/6/25.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgView.layer.cornerRadius = 12
        self.imgView.clipsToBounds = true
    }
}
