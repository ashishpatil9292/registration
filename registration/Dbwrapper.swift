//
//  Dbwrapper.swift
//  registration
//
//  Created by Student016 on 26/12/18.
//  Copyright © 2018 ra. All rights reserved.
//

import UIKit
import SQLite3
class Dbwrapper: NSObject {
    
    
 static   let sharedobj = Dbwrapper()
    var db : OpaquePointer? = nil
    var stmt : OpaquePointer? = nil
    
    func getallpath()->String
    {
        let docarray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = docarray.first! + "/login"
        
        return path
        
    }
    
    
    func executequery(query:String)->Bool
    {
        let path = getallpath()
        var sucess = false
        
        if (sqlite3_open(path, &db)==SQLITE_OK)
        {
          if (sqlite3_prepare_v2(db, query, -1, &stmt, nil)==SQLITE_OK)
          {
            if (sqlite3_step(stmt)==SQLITE_DONE)
            {
                sucess = true
                sqlite3_close(db)
                sqlite3_finalize(stmt)
            }
            else
            {
                print("step failed:\(sqlite3_errmsg(db))")
            }
            
            }
          else
          {
            print("prepare v2 failed:\(sqlite3_errmsg(db))")
        }
        }
        else
        {
            print("data opening failed:\(sqlite3_errmsg(db))")
        }
        return sucess
    }
    
    
    func createtable()
    {
        let createquery = "create table if not exists regiter(firstn text,lastn text,mobnu text,emailid text,birth text,gend text,addrss text)"
        let success = executequery(query: createquery)
        if success{
            print("table created succesfully")
        }
        else
        {
            print("table creation failed")
        }
        
        
    }
    
    
    
    func alltaskquery(query:String)->([String],[String],[String],[String],[String],[String],[String])
    {
        let path = getallpath()
        
        var fnamearray = [String]()
        var lnamearray = [String]()
        var mobilearray = [String]()
        var emailarray = [String]()
        var birtharray = [String]()
        var genderarray = [String]()
        var addressarray = [String]()
       
        if (sqlite3_open(path, &db)==SQLITE_OK)
        {
            if(sqlite3_prepare_v2(db, query, -1, &stmt, nil)==SQLITE_OK)
            {
                if(sqlite3_step(stmt)==SQLITE_ROW)
                {
                   let fname = sqlite3_column_text(stmt, 0)
                    let fstr = String(cString: fname!)
                    fnamearray.append(fstr)
                    
                    let lname = sqlite3_column_text(stmt, 1)
                    let lstr = String(cString: lname!)
                    lnamearray.append(lstr)
                    
                    let mobn = sqlite3_column_text(stmt, 2)
                    let mstr = String(cString: mobn!)
                    mobilearray.append(mstr)
                    
                    let email = sqlite3_column_text(stmt, 3)
                    let emilstr = String(cString: email!)
                    emailarray.append(emilstr)
                   
                    let birth = sqlite3_column_text(stmt, 4)
                    let bstr = String(cString: birth!)
                    birtharray.append(bstr)
                    
                    let geng = sqlite3_column_text(stmt, 5)
                    let gstr = String(cString: geng!)
                    genderarray.append(gstr)
                    
                    let add = sqlite3_column_text(stmt, 6)
                    let addstr = String(cString: add!)
                    addressarray.append(addstr)
                }
                else
                {
                    print("step failed:\(sqlite3_errmsg(db))")
                }
            }
            else{
                print("prepare v2 failed:\(sqlite3_errmsg(db))")
            }
        }
        else
        {
            print("data opening failed:\(sqlite3_errmsg(db))")
        }
        return(fnamearray,lnamearray,mobilearray,emailarray,birtharray,genderarray,addressarray)
    }

}
