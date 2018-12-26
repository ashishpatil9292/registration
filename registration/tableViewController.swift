
//
//  tableViewController.swift
//  registration
//
//  Created by Student016 on 26/12/18.
//  Copyright © 2018 ra. All rights reserved.
//

import UIKit

class tableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tablview: UITableView!
    var fnamearay = [String]()
    var lnamearay = [String]()
    var mobilearay = [String]()
    var emailaray = [String]()
    var birtharay = [String]()
    var genderaray = [String]()
    var addressaray = [String]()
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
let selectquery = "select * from regiter "
   let result = Dbwrapper.sharedobj.alltaskquery(query: selectquery)
         fnamearay = result.0
        lnamearay = result.1
        mobilearay = result.2
        emailaray = result.3
        birtharay = result.4
        genderaray = result.5
        addressaray = result.6
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fnamearay.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")as! TableViewCell
        cell.fname.text = fnamearay[indexPath.row]
        cell.lname.text = lnamearay[indexPath.row]
        cell.mobnu.text = mobilearay[indexPath.row]
        cell.emailt.text = emailaray[indexPath.row]
        cell.brth.text = birtharay[indexPath.row]
        cell.gend.text = genderaray[indexPath.row]
        cell.addr.text = addressaray[indexPath.row]
        
        return cell
    }
    }
    
    

