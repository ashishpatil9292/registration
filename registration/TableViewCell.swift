//
//  TableViewCell.swift
//  registration
//
//  Created by Student016 on 26/12/18.
//  Copyright © 2018 ra. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var fname: UITextField!
    
    @IBOutlet weak var lname: UITextField!
    
    
    @IBOutlet weak var mobnu: UITextField!
    
    @IBOutlet weak var emailt: UITextField!
    
    @IBOutlet weak var brth: UITextField!
    
    @IBOutlet weak var gend: UITextField!
    
    @IBOutlet weak var addr: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
