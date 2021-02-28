//
//  Cancel.swift
//  OrderSystem
//
//  Created by zhangxihao on 5/22/20.
//  Copyright © 2020 zhangxihao. All rights reserved.
//
import Foundation
import UIKit

class Cancel: UIViewController {
    var selectDishName : String!
    var selectPrice : Int!
    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var dishName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dishName.text = selectDishName
        price.text = String(selectPrice)
    }
    
    @IBAction func CancelButtonClicked(_ sender: UIButton) {
        let sqlite = SQLManagement.sharedInstance
        if !sqlite.opendDB() {return}
        let data = sqlite.execQuerySQL(sql: "select * from orders where dishName = '" + selectDishName + "';")
        var number : Int!
        number = data?[0]["numb"] as? Int
        if number == 1{
            let order = "delete from orders where dishName = '" + selectDishName + "';"
            if !sqlite.execNoneQuerySQL(sql: order)
            {
                sqlite.closeDB();
                return
            }
        }
        else{
            number = number - 1
            let news = String(number)
            let order1 = "update orders set numb = "+news+""
            let order2 = " where dishName = '" + selectDishName + "';"
            let order = order1 + order2
            if !sqlite.execNoneQuerySQL(sql: order)
            {
                sqlite.closeDB();
                return
            }
        }
        
        
    }
}
