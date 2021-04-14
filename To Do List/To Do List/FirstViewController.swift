//
//  FirstViewController.swift
//  To Do List
//
//  Created by RuiJun haung on 2020/7/20.
//  Copyright © 2020 RuiJun haung. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    
    var items:[String] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return items.count
        
        
    }

    
    
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    
    }
    override func viewDidAppear(_ animated: Bool) {
        let itemsObject = UserDefaults.standard.object(forKey: "items")
        
        
        if let tempitems = itemsObject as? [String]{
            items = tempitems
            
        }
        table.reloadData()
    }
   /* func tableView(_ tableView: UITableView,commit editingStyle:UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            items.remove(at: indexPath.row)
            table.reloadData()
            UserDefaults.standard.set(items, forKey: "items")
            
            
            
        }
    }
 */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

