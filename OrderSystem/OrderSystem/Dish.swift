//
//  Dish.swift
//  OrderSystem
//
//  Created by zhangxihao on 5/20/20.
//  Copyright © 2020 zhangxihao. All rights reserved.
//
import Foundation
import UIKit


class Dish: UITableViewController{
    var RstName:String!
    private static let dishCell = "DishName"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sqlite = SQLManagement.sharedInstance
        if !sqlite.opendDB() {return 0}
        let data = sqlite.execQuerySQL(sql: "SELECT * FROM dishDB where restName = '" + RstName + "';")
        sqlite.closeDB()
        return data!.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Select Dish"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Dish.dishCell, for: indexPath)
        
        let sqlite = SQLManagement.sharedInstance
        if !sqlite.opendDB() {return cell}
        let data = sqlite.execQuerySQL(sql: "select * from dishDB where restName = '" + RstName + "';")
        cell.textLabel?.text = data?[indexPath.row]["dishName"] as? String
        let number = data?[indexPath.row]["id"]
        let image = Dish.LoadImage(id: number as! Int)
        cell.imageView?.image = image
        sqlite.closeDB()
        return cell
    }

    static func LoadImage(id:Int) -> UIImage
    {
        let sqlite = SQLManagement.sharedInstance
        if !sqlite.opendDB(){return UIImage(named: "1")!}
        let sql = "SELECT picture from dishDB WHERE id = \(id)"
        let data = sqlite.exeLoadBlob(sql: sql)
        sqlite.closeDB()
        if data != nil{
            return UIImage(data: data!)!
        }
        else
        {
            return  UIImage(named: "1")!
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DishToDetail"
        {
            let vc = segue.destination as! Detail
            
            let sqlite = SQLManagement.sharedInstance
            if !sqlite.opendDB() {return}
            
            let selectRow = tableView.indexPathForSelectedRow!.row
            let data = sqlite.execQuerySQL(sql: "select * from dishDB where restName = '" + RstName + "';")
            vc.selectDishName = (data?[selectRow]["dishName"] as! String)
            vc.selectDetail = data?[selectRow]["detail"] as? String
            vc.selectPrice = data?[selectRow]["price"] as? Int
            vc.selectId = data?[selectRow]["id"]as? Int
            vc.selectRstName = data?[selectRow]["restName"] as? String
            sqlite.closeDB()
        }
    }
}
