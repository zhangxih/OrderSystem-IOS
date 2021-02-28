//
//  Restaurant.swift
//  OrderSystem
//
//  Created by zhangxihao on 5/19/20.
//  Copyright © 2020 zhangxihao. All rights reserved.
//

import Foundation
import UIKit

class Restaurant: UITableViewController {
    private static let restaurantCell = "RestaurantName"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let sqlite = SQLManagement.sharedInstance
        if !sqlite.opendDB() {return}
        
        if !sqlite.execNoneQuerySQL(sql: "DELETE FROM restaurants")
        {sqlite.closeDB();return}
        if !sqlite.execNoneQuerySQL(sql: "DELETE FROM sqlite_sequence WHERE name = 'restaurants';")
        {sqlite.closeDB() ; return }
        
        let createSQL = "CREATE TABLE IF NOT EXISTS restaurants('id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, " + "'restName' TEXT);"
        if !sqlite.execNoneQuerySQL(sql: createSQL)
        {
            sqlite.closeDB();
            return
        }
        let restaurant1 = "INSERT INTO restaurants(restName) VALUES('KFC');"
        let restaurant2 = "INSERT INTO restaurants(restName) VALUES('Mcdonalds');"
        let restaurant3 = "INSERT INTO restaurants(restName) VALUES('BurgerKing');"
        if !sqlite.execNoneQuerySQL(sql: restaurant1)
        {
            sqlite.closeDB();
            return
        }
        if !sqlite.execNoneQuerySQL(sql: restaurant2)
        {
            sqlite.closeDB();
            return
        }
        if !sqlite.execNoneQuerySQL(sql: restaurant3)
        {
            sqlite.closeDB();
            return
        }
        
        
        
        let createSQL2 = "CREATE TABLE IF NOT EXISTS orders('id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, " + "'restName' TEXT, 'dishName' TEXT, 'price' INTEGER,'numb' INTEGER);"
        if !sqlite.execNoneQuerySQL(sql: createSQL2)
        {
            sqlite.closeDB();
            return
        }
        
        if !sqlite.execNoneQuerySQL(sql: "DELETE FROM dishDB")
        {sqlite.closeDB();return}
        if !sqlite.execNoneQuerySQL(sql: "DELETE FROM sqlite_sequence WHERE name = 'dishDB';")
        {sqlite.closeDB() ; return }
        
        let createSQL3 = "CREATE TABLE IF NOT EXISTS dishDB('id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, " + "'restName' TEXT , 'dishName' TEXT , 'price' INTEGER , 'detail' TEXT , 'picture' BLOB );"
        if !sqlite.execNoneQuerySQL(sql: createSQL3)
        {
            sqlite.closeDB();
            return
        }
        
        let dish1 = "INSERT OR REPLACE INTO dishDB(restName,dishName,price,detail) VALUES('KFC','鸡米花',18,'由新鲜鸡脯肉挂糊炸制而成');"
        let dish2 = "INSERT OR REPLACE INTO dishDB(restName,dishName,price,detail) VALUES('KFC','香辣鸡腿堡',20,'整块无骨鸡腿肉，浓郁汉堡酱，香脆鲜辣多汁');"
        let dish3 = "INSERT OR REPLACE INTO dishDB(restName,dishName,price,detail) VALUES('KFC','土豆泥',9,'将土豆泥赋予了一种全新的味道，不但口感更加香滑软糯，而且内容更是丰富多多');"
        let dish4 = "INSERT OR REPLACE INTO dishDB(restName,dishName,price,detail)VALUES('Mcdonalds','麦辣鸡翅', 12 ,'麦辣鸡翅是以鸡翅、面粉、洋葱、姜片、生抽、料酒、糖、胡椒粉、盐为主材制作');"
        let dish5 = "INSERT OR REPLACE INTO dishDB(restName,dishName,price,detail)VALUES('Mcdonalds','薯条', 10 ,'以马铃薯为原料，切成条状后油炸而成');"
        let dish6 = "INSERT OR REPLACE INTO dishDB(restName,dishName,price,detail)VALUES('Mcdonalds','甜筒', 12 ,'制作原料主要有淡奶油、牛奶等，口味清凉冰甜，适宜夏季消暑');"
        let dish7 = "INSERT OR REPLACE INTO dishDB(restName,dishName,price,detail)VALUES('BurgerKing','霸王鸡条', 15 ,'由条状鸡肉炸成，外脆里嫩，鲜嫩美味');"
        let dish8 = "INSERT OR REPLACE INTO dishDB(restName,dishName,price,detail)VALUES('BurgerKing','天椒皇堡', 30 ,'100%火烤牛肉，肉质紧实，鲜嫩多汁，加入番茄、酸黄瓜等新鲜蔬菜，更添美味爽口。');"
        let dish9 = "INSERT OR REPLACE INTO dishDB(restName,dishName,price,detail)VALUES('BurgerKing','果木香风味火烤鸡腿堡', 22 ,'采用鸡腿肉，真正火烤，鲜嫩多汁；独特果木香气，口味浓郁。搭配黑胡椒蛋黄酱，带给你舌尖上的无穷回味。');"
        if !sqlite.execNoneQuerySQL(sql: dish1)
        {
            sqlite.closeDB();
            return
        }
        if !sqlite.execNoneQuerySQL(sql: dish2)
        {
            sqlite.closeDB();
            return
        }
        if !sqlite.execNoneQuerySQL(sql: dish3)
        {
            sqlite.closeDB();
            return
        }
        if !sqlite.execNoneQuerySQL(sql: dish4)
        {
            sqlite.closeDB();
            return
        }
        if !sqlite.execNoneQuerySQL(sql: dish5)
        {
            sqlite.closeDB();
            return
        }
        if !sqlite.execNoneQuerySQL(sql: dish6)
        {
            sqlite.closeDB();
            return
        }
        if !sqlite.execNoneQuerySQL(sql: dish7)
        {
            sqlite.closeDB();
            return
        }
        if !sqlite.execNoneQuerySQL(sql: dish8)
        {
            sqlite.closeDB();
            return
        }
        if !sqlite.execNoneQuerySQL(sql: dish9)
        {
            sqlite.closeDB();
            return
        }
        
        let image1 = UIImage(named: "1")
        Restaurant.SaveImage(id: 1, img: image1)
        
        let image2 = UIImage(named: "2")
        Restaurant.SaveImage(id: 2, img: image2)
        
        let image3 = UIImage(named: "3")
        Restaurant.SaveImage(id: 3, img: image3)
        
        let image4 = UIImage(named: "4")
        Restaurant.SaveImage(id: 4, img: image4)
        
        let image5 = UIImage(named: "5")
        Restaurant.SaveImage(id: 5, img: image5)
        
        let image6 = UIImage(named: "6")
        Restaurant.SaveImage(id: 6, img: image6)
        
        let image7 = UIImage(named: "7")
        Restaurant.SaveImage(id: 7, img: image7)
        
        let image8 = UIImage(named: "8")
        Restaurant.SaveImage(id: 8, img: image8)
        
        let image9 = UIImage(named: "9")
        Restaurant.SaveImage(id: 9, img: image9)
        
        sqlite.closeDB()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sqlite = SQLManagement.sharedInstance
        if !sqlite.opendDB() {return 0}
        let data = sqlite.execQuerySQL(sql: "SELECT * FROM restaurants")
        sqlite.closeDB()
        return data!.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Select Restaurant"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Restaurant.restaurantCell, for: indexPath)
        let sqlite = SQLManagement.sharedInstance
        if !sqlite.opendDB() {return cell}
        let data = sqlite.execQuerySQL(sql: "select * from restaurants")
        cell.textLabel?.text = data?[indexPath.row]["restName"] as? String
        sqlite.closeDB()
        return cell
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "RestaurantToDish"
        {
            let vc1 = segue.destination as! Dish
            
            let sqlite = SQLManagement.sharedInstance
            if !sqlite.opendDB() {return}
            
            let selectRow = tableView.indexPathForSelectedRow!.row
            let data = sqlite.execQuerySQL(sql: "select * from restaurants")
            vc1.RstName = data?[selectRow]["restName"] as! String
            sqlite.closeDB()
        }
    }
    
    static func SaveImage(id:Int,img:UIImage?)
    {
        if img == nil {return}
        let sqlite = SQLManagement.sharedInstance
        if !sqlite.opendDB(){return}
        let sql = "UPDATE dishDB SET picture = ? WHERE id = \(id)"
        let data = img!.jpegData(compressionQuality: 1.0) as NSData?
        sqlite.execSaveBlob(sql: sql, blob: data!)
        sqlite.closeDB()
        return
    }
}
