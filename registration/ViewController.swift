//
//  ViewController.swift
//  registration
//
//  Created by Student016 on 26/12/18.
//  Copyright © 2018 ra. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate{
    let datepicker = UIDatePicker()
    let pickarray = ["Male","Female","Other"]
    let picker  = UIPickerView()
    @IBOutlet weak var firstname: UITextField!
    
    @IBOutlet weak var lastname: UITextField!
    
    
    @IBOutlet weak var mobnumber: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var datebirth: UITextField!
    
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var address: UITextField!
    
    
    @IBOutlet weak var alertlb: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
alertlb.isHidden = true
       alertlb.textColor = UIColor.red
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.isUserInteractionEnabled = true
        Dbwrapper.sharedobj.createtable()
        let okbutton = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(okbtn))
        
        let spacebutton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        let cancelbutton = UIBarButtonItem(title: "CANCEL", style: .plain, target: self, action: #selector(cancelbt))
        toolbar.setItems([okbutton,spacebutton,cancelbutton], animated: true)
        datepicker.datePickerMode = .date
        datebirth.inputAccessoryView = toolbar
        datebirth.inputView = datepicker
        
        //datepicker
        gender.inputView = picker
        picker.delegate = self

    }
    @objc func okbtn()
{
    let dateformatter = DateFormatter()
    dateformatter.dateFormat = "dd / MM / yyyy"
    datebirth.text = dateformatter.string(from:datepicker.date)
    view.endEditing(true)
    }
    
    @objc func cancelbt()
    {
        view.endEditing(true)

//        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
{
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickarray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickarray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gender.text = pickarray[row]
    }
    
    
    //email validation
    func isValidEmail(testStr:String) -> Bool
    {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: testStr)
        
    }
    
    @IBAction func submit(_ sender: UIButton) {
        alertlb.isHidden = true
        if (firstname.text?.isEmpty)! ||
            (lastname.text?.isEmpty)! ||
            (datebirth.text?.isEmpty)! ||
            (gender.text?.isEmpty)! ||
            (address.text?.isEmpty)! ||
            (email.text?.isEmpty)! ||
            (mobnumber.text?.isEmpty)!
        {alertlb.text = "All fields Required"
            alertlb.isHidden = true
            alertcontroller(Usermessage: "All fields Required")
            return
        }
        
        if (mobnumber.text?.count)! > 10
        {
            alertlb.isHidden = false
            alertlb.text = "Please enter proper Mobile number"
        }
       else if (mobnumber.text?.count)! < 10
        {
            alertlb.isHidden = false
            alertlb.text = "Please enter proper Mobile number"
        }
            
            
            
//        guard firstname.text?.count != 0 else {
//            alertlb.isHidden = false
//            alertlb.text = "please enter firstname"
//            return
//        }
//        guard lastname.text?.count != 0 else {
//            alertlb.isHidden = false
//            alertlb.text = "please enter lastname"
//            return
//        }
//        guard datebirth.text?.count != 0 else {
//            alertlb.isHidden = false
//            alertlb.text = "please enter datebirth"
//            return
//        }
//
//        guard gender.text?.count != 0 else {
//            alertlb.isHidden = false
//            alertlb.text = "please enter gender"
//            return
//        }
//        guard address.text?.count != 0 else {
//            alertlb.isHidden = false
//            alertlb.text = "please enter address"
//            return
//        }
//
//        guard email.text?.count != 0 else {
//            alertlb.isHidden = false
//            alertlb.text = "please enter Email Address"
//            return
//        }
//        guard mobnumber.text?.count != 0 else {
//            alertlb.isHidden = false
//            alertlb.text = "please enter mobile number"
//            return
//        }
        
       let insertquery = "insert into regiter(firstn,lastn,mobnu,emailid,birth,gend,addrss) values ('\(firstname.text)','\(lastname.text)','\(mobnumber.text)','\(email.text)','\(datebirth.text)','\(gender.text)','\(address.text)')"
     let success = Dbwrapper.sharedobj.executequery(query: insertquery)
        
        if success
        {
            
            print("insert data succesfully:\(firstname.text!),\(lastname.text!),\(email.text!)")
        }
        else
        {
            print("insert data failed")
        }
        
        
        
        
        
        let check = isValidEmail(testStr: email.text!)
        guard check != false else
        {
            alertlb.isHidden = false
            alertlb.text = "please enter proper Email Address"
            return
        }
        
        
       let next = self.storyboard?.instantiateViewController(withIdentifier: "tableViewController")as! tableViewController
        self.navigationController?.pushViewController(next, animated: true)
        
        
        
        
    }
    
    
    //alertcontroller
    func alertcontroller(Usermessage:String) -> Void
    {
        
        let alert = UIAlertController(title: "Alert", message: Usermessage, preferredStyle: .alert)
        
        let okaction = UIAlertAction(title: "OK", style: .default)
        {
            (action:UIAlertAction)in
        }
        alert.addAction(okaction)
        self.present(alert, animated: true, completion: nil)
    }
}

