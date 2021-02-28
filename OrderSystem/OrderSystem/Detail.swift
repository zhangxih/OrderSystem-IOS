//
//  Detail.swift
//  OrderSystem
//
//  Created by zhangxihao on 5/20/20.
//  Copyright © 2020 zhangxihao. All rights reserved.
//
import Foundation
import UIKit

class Detail: UIViewController {
    var selectDishName : String!
    var selectDetail : String!
    var selectPrice : Int!
    var selectId : Int!
    var selectRstName : String!
    
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var dishName: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dishName.text = selectDishName
        detail.text = selectDetail
        price.text = String(selectPrice)
        image.image = Dish.LoadImage(id: selectId as! Int)
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        let price = String(selectPrice)
        let sqlite = SQLManagement.sharedInstance
        if !sqlite.opendDB() {return}
        let data = sqlite.execQuerySQL(sql: "select * from orders where dishName = '" + selectDishName + "';")
        if data!.count == 0{
            let order1 = "INSERT INTO orders (restName,dishName,price,numb) VALUES('"
            let order2 = ""+selectRstName+"','"+selectDishName+"',"+price+", 1);"
            let order = order1 + order2
            if !sqlite.execNoneQuerySQL(sql: order)
            {
                sqlite.closeDB();
                return
            }
        }
        else{
            var new : Int!
            new = data?[0]["numb"] as? Int
            new = new + 1
            let news = String(new)
            let order1 = "update orders set numb = "+news+""
            let order2 = " where dishName = '" + selectDishName + "';"
            let order = order1 + order2
            if !sqlite.execNoneQuerySQL(sql: order)
            {
                sqlite.closeDB();
                return
            }
        }
        sqlite.closeDB();
    }
}
