//
//  customCell.swift
//  PrimoSwift
//
//  Created by fabrizio on 03/06/14.
//  Copyright (c) 2014 Fabrizio Radica. All rights reserved.
//

import Foundation
import UIKit

class customCell: UITableViewCell{
    @IBOutlet var mioTesto : UILabel!
    @IBOutlet var mioSubtitle : UILabel!
    @IBOutlet var miaImmagine : UIImageView!
    @IBOutlet weak var _activity: UIActivityIndicatorView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        // Initialization code
    }

    func setup(){
        self.miaImmagine.layer.cornerRadius=self.miaImmagine.frame.size.height*0.5
        self.miaImmagine.clipsToBounds=true;
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}