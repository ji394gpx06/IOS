//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by RuiJun haung on 2020/12/17.
//

import UIKit
import CoreData
class RestaurantTableViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var restaurants: [RestaurantMO] = []
    
    

    var restaurantNames = ["Cafe Deadend","Homei","Teakha","Cafe Loisl","Petite Oyster","For Kee Restaurant","Po's Atelier","Bourke Street Bakery","Haigh's Chocolate","Palomino Espresso","Upstate","Traif","Graham Avenue Meats","Waffle & Wolf","Five Leaves","Cafe Lore","Confessional","Barrafina","Donostia","Royal Oak","CASK Pub and Kitchen"]
    var resaurantImages = ["cafedeadend","homei","teakha","cafeloisl","petiteoyster","forkeerestaurant","posatelier","bourkestreetbakery","haighschocolate","palominoespresso","upstate","traif","grahamavenuemeats","wafflewolf","fiveleaves","cafelore","confessional","barrafina","donostia","royaloak","caskpubkitchen"]
    var restaurantLocations = ["Hong Kong","Hong Kong","Hong Kong","Hong Kong","Hong Kong","Hong Kong","Hong Kong","Sydeny","Sydeny","Sydeny","New York","New York","New York","New York","New York","New York","New York","London","London","London","London"]
    var restaurantTypes = ["Coffee & Tea Shop","Cafe","Tea House","Austrian/Causual Drink","French","Barkery","Barkery","Chocolate","Cafe","American / seafood","American","American","Breakfast & Brunch","Coffee & Tea","Latin American","Spanish","Spanish","Britsh","Thai","Thai","Thai"]
    var restaurantIsVisited = Array(repeating: false, count: 21)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.cellLayoutMarginsFollowReadableWidth = true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurantNames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
        
        // Configure the cell...
        cell.nameLabel.text = restaurants[indexPath.row].name
        if let restaurantImage = restaurants[indexPath.row].image{
            cell.thumbnailImageView.image = UIImage(data: restaurantImage as Data)
        }
        cell.locationLabel.text = restaurants[indexPath.row].location
        cell.typeLabel.text = restaurants[indexPath.row].type
        if restaurantIsVisited[indexPath.row]{
            cell.accessoryType = .checkmark
            
            
        }else{
            
            cell.accessoryType = .none
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //create action list
        let optionMeun = UIAlertController(title: nil, message: "what do you want to do?", preferredStyle: .actionSheet)
        // join a action in list
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMeun.addAction(cancelAction)
        let callActionHandler = {(action:UIAlertAction!) -> Void
            in let alertmessage = UIAlertController(title: "Service Unavailable", message: "Sorry,the call feature is not available yet. Please retry later.", preferredStyle: .alert)
            alertmessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertmessage, animated: true, completion: nil)
        }
        let callaction = UIAlertAction(title: "Call"+"123-000-\(indexPath.row)", style: .default, handler: callActionHandler)
        optionMeun.addAction(callaction)
        let cheakInAction = UIAlertAction(title: "Cheak in", style: .default, handler: {(action:UIAlertAction!) -> Void in
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .checkmark
            self.restaurantIsVisited[indexPath.row] = true
        })
        let cheakoutaction = UIAlertAction(title: "Cheak out", style: .default) { (action:UIAlertAction!) -> Void in
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .none
            self.restaurantIsVisited[indexPath.row] = false
        }
        optionMeun.addAction(cheakInAction)
        optionMeun.addAction(cheakoutaction)
        //present
        present(optionMeun, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: false)
        if let popoverController = optionMeun.popoverPresentationController{
            if let cell = tableView.cellForRow(at: indexPath){
                popoverController.sourceView = cell
                popoverController.sourceRect = cell.bounds
            }
        }
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){
            (action,sourceView, completionHanler) in
            self.restaurantNames.remove(at: indexPath.row)
            self.restaurantLocations.remove(at: indexPath.row)
            self.restaurantIsVisited.remove(at: indexPath.row)
            self.restaurantTypes.remove(at: indexPath.row)
            self.resaurantImages.remove(at: indexPath.row)
            
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
            //呼叫完成處理器來取消動作按鈕
            completionHanler(true)
        }
        let shareAction = UIContextualAction(style: .normal, title: "Share"){
            (action,sourceView, completionHanler) in
            let defaultText = "Just checking in at"+self.restaurants[indexPath.row].name!
            let activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            if let restaurantImage = self.restaurants[indexPath.row].image,
               let imageToShare = UIImage(data:restaurantImage as Data){
                let activityController = UIActivityViewController(activityItems: [defaultText,imageToShare], applicationActivities: nil)
                
            }else{
               let activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
                
            }
            self.present(activityController, animated: true, completion: nil)
            completionHanler(true)
        }
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
        
        return swipeConfiguration
    }
        
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
