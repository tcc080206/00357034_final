//
//  MemoriesTableViewController.swift
//  00357034_final
//
//  Created by user_17 on 2017/6/17.
//  Copyright © 2017年 user_17. All rights reserved.
//

import UIKit

class MemoriesTableViewController: UITableViewController {
    var memories:[[String:Any]] = []
    var refresh: UIRefreshControl!
    
    func getAddMemoryNoti(noti:Notification){
        let memory = noti.userInfo as? [String:Any]
        
        memories.insert(memory!, at: 0)
        
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("memories.txt")
        (memories as NSArray).write(to: url!, atomically: true)
        
        
        tableView.reloadData()
        
        

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("memories.txt")
        let array = NSArray(contentsOf: url!)
        if array != nil {
            memories = array as! [[String:Any]]
        }
        
        let notiName = Notification.Name("AddMemory")
        NotificationCenter.default.addObserver(self, selector: #selector(MemoriesTableViewController.getAddMemoryNoti(noti:)), name: notiName, object: nil)
        
        refresh = UIRefreshControl();
        refresh.addTarget(self, action: #selector(likereset), for: .valueChanged)
        self.tableView.refreshControl = refresh
        print(url)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memories.count
    }

    func likereset(){
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("memories.txt")
        let array = NSArray(contentsOf: url!)
        if array != nil {
            memories = array as! [[String:Any]]
        }

        self.tableView.reloadData()
        refresh.endRefreshing()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoryCell", for: indexPath) as! MemoriesTableViewCell

        // Configure the cell...
        let dic = memories[indexPath.row]
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        cell.nameLabel.text = dic["name"] as? String
        cell.dateLabel.text = formatter.string(
            from: dic["date"] as! Date)
        
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent(dic["photo"]! as! String)
        cell.photo.image = UIImage(contentsOfFile: url!.path)
        let index:String = "\((dic["like"])!)"
        cell.likeCount.text = index
        
        return cell
    }
    override func tableView(_ tableView: UITableView, commit
        editingStyle: UITableViewCellEditingStyle, forRowAt
        indexPath: IndexPath) {
        memories.remove(at: indexPath.row)
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("memories.txt")
        (memories as NSArray).write(to: url!, atomically: true)
        tableView.reloadData()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is MemoryDetailsViewController{
        let indexPath = tableView.indexPathForSelectedRow
        let dic = memories[(indexPath?.row)!]
        let check = dic["inner"] as! Bool
        
            if !check{
            let controller = segue.destination as? MemoryDetailsViewController
            controller?.memoryDic = dic
            }
            else{
                    let alertController = UIAlertController(title:"驗證",message:"請輸入密碼",preferredStyle: .alert)
                    alertController.addTextField {
                        (textField: UITextField!) -> Void in
                        textField.placeholder = "密碼"
                        textField.isSecureTextEntry = true;
                    }
                    let cancelAction = UIAlertAction(title:"取消",style: .cancel,handler:nil)
                    alertController.addAction(cancelAction)
                    let okAction = UIAlertAction(title:"進入",style:UIAlertActionStyle.default){
                        (action: UIAlertAction!) -> Void in
                        
                        let password =
                            alertController.textFields?.first?.text
                        
                        if password == (dic["pw"] as! String){
                            let controller = segue.destination as? MemoryDetailsViewController
                            controller?.memoryDic = dic
                            self.navigationController?.pushViewController(controller!, animated: true)

                        }
                    }
                    alertController.addAction(okAction)
                    present(
                    alertController,
                    animated: true,
                    completion: nil)
                
                }
            
        }
    }
    
    func privateCheck(){
        
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
