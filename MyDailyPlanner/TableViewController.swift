//
//  TableViewController.swift
//  MyDailyPlanner
//
//  Created by Ivan Ignatkov on 2019-01-11.
//  Copyright © 2019 TechCompetence. All rights reserved.
//
import Foundation
import UIKit

class TableViewController: UITableViewController {
    
   
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
  
    
    
    
    @IBAction func pushEditAction(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing , animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.tableView.reloadData()
        }
        
    }
    
    @IBAction func pushAddAction(_ sender: Any) {
        
        let alertTitle = NSLocalizedString("Create new item", comment: "")
        let alertText = NSLocalizedString("New item name", comment: "")
        let alertTitle2 = NSLocalizedString("Cancel", comment: "")
        let alertTitle3 = NSLocalizedString("Create", comment: "")
        
        
       let alertController = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = alertText
        }
        
       
    
        let alertAction2 = UIAlertAction(title: alertTitle3, style: .cancel) { (alert) in
            let newItem = alertController.textFields![0].text
            addItem(nameItem: newItem!)
            self.tableView.reloadData()
            // add new text
        }
        
        let alertAction1 = UIAlertAction(title: alertTitle2, style: .destructive) { (alert) in
            
        }
    
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        
       present(alertController, animated: true, completion: nil)
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ToDoItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as? MyCell else { return UITableViewCell() }
        
        let currentItem = ToDoItems[indexPath.row]
        ///texting
        
        cell.nameLbl.text = currentItem["Name"] as? String
        

        ///
        
        if (currentItem["isCompleted"] as? Bool) == true {
            cell.statusImg?.image = #imageLiteral(resourceName: "check")
        } else {
            cell.statusImg?.image = #imageLiteral(resourceName: "uncheck")
        }
        
        if tableView.isEditing {
             cell.nameLbl.alpha = 0.4
             cell.statusImg.alpha = 0.4


        }else{
            cell.nameLbl.alpha = 1
            cell.statusImg.alpha = 1


        }
        cell.nextBtn.tag = indexPath.row
        cell.nextBtn.addTarget(self, action: #selector(self.segue(sender:)), for: UIControl.Event.touchUpInside)
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true )
        
        let cell = tableView.cellForRow(at: indexPath) as! MyCell
        
        
        if tableView.isEditing {
            cell.nameLbl.alpha = 0.4
            cell.statusImg.alpha = 0.4
            
            
            
        }else{
            cell.nameLbl.alpha = 1
            cell.statusImg.alpha = 1
            if changeState(at: indexPath.row ) {
                cell.statusImg.image = #imageLiteral(resourceName: "check")
            } else {
                cell.statusImg.image = #imageLiteral(resourceName: "uncheck")
            }
            
        }
        
    }
    
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        moveItemFrom(fromIndex: fromIndexPath.row, toIndex: to.row)
        tableView.reloadData()
    }
    
    @objc func segue(sender: UIButton) {
        self.performSegue(withIdentifier: "goNextPage", sender: sender)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let btnNext = sender as! UIButton
        
        let index = btnNext.tag
        let currentItem = ToDoItems[index]
        let destinationVC = segue.destination as! TextViewController
    
        
        if segue.identifier == "goNextPage" {
            
            let nameTxt = currentItem["Name"] as? String ?? ""
            var descriptionTxt = currentItem["Description"] as? String ?? ""
            if descriptionTxt == "" {
                descriptionTxt = /*"Type something here..."*/ ""
            }
            destinationVC.initData(name: nameTxt, text: descriptionTxt, item: index)
        }
    }

}
