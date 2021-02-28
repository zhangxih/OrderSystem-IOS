//
//  Order.swift
//  OrderSystem
//
//  Created by zhangxihao on 5/20/20.
//  Copyright © 2020 zhangxihao. All rights reserved.
//
import Foundation
import UIKit

class Order: UITableViewController {
    private static let orderCell = "OrderSelected"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sqlite = SQLManagement.sharedInstance
        if !sqlite.opendDB() {return 0}
        let data = sqlite.execQuerySQL(sql: "SELECT * FROM orders")
        sqlite.closeDB()
        return data!.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Orders"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Order.orderCell, for: indexPath)
        
        let sqlite = SQLManagement.sharedInstance
        if !sqlite.opendDB() {return cell}
        let data = sqlite.execQuerySQL(sql: "select * from orders")
        cell.textLabel?.text = data?[indexPath.row]["dishName"] as? String
        var number : Int!
        number = data?[indexPath.row]["numb"] as? Int
        cell.detailTextLabel?.text = String(number)
        sqlite.closeDB()
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OrderToCancel"
        {
            let vc = segue.destination as! Cancel
            
            let sqlite = SQLManagement.sharedInstance
            if !sqlite.opendDB() {return}
            let timedata = sqlite.execQuerySQL(sql: "select * from orders")
            let selectRow = tableView.indexPathForSelectedRow!.row
            var DishName : String!
            DishName = timedata?[selectRow]["dishName"] as? String
            let data = sqlite.execQuerySQL(sql: "select * from orders where dishName = '" + DishName + "';")
            vc.selectDishName = (data?[selectRow]["dishName"] as! String)
            vc.selectPrice = data?[selectRow]["price"] as? Int
            sqlite.closeDB()
        }
    }
    
    
    @IBAction func CheckButtonClicked(_ sender: UIButton) {
        self.tableView.reloadData()
        var total : Int! = 0
        let sqlite = SQLManagement.sharedInstance
        if !sqlite.opendDB() {return}
        let data = sqlite.execQuerySQL(sql: "select * from orders")
        let number = data!.count as! Int
        if (number == 0) {return}
        for i in 0...number-1{
            var price = data?[i]["price"] as! Int
            var numb = data?[i]["numb"] as! Int
            total = total + price*numb
        }
        let pay = String(total)
        let message = "You should pay " + pay + " !"
        let alert = UIAlertController(title: "Welcome!", message: message, preferredStyle:
        .alert)
        let action1 = UIAlertAction(title: "cancel", style: .default, handler: nil)
        let action2 = UIAlertAction(title: "confirm", style: .default, handler: {(UIAlertAction)in
            let sqlite = SQLManagement.sharedInstance
            if !sqlite.opendDB() {return}
            
            if !sqlite.execNoneQuerySQL(sql: "DELETE FROM orders")
            {sqlite.closeDB();return}
            
            if !sqlite.execNoneQuerySQL(sql: "DELETE FROM sqlite_sequence WHERE name = 'orders';")
            {sqlite.closeDB();}
            
            sqlite.closeDB();})
        alert.addAction(action1)
        alert.addAction(action2)
        present(alert, animated: true, completion: nil)
    }
}
