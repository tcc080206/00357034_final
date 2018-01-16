//
//  AddMemoriesTableViewController.swift
//  00357034_final
//
//  Created by user_17 on 2017/6/17.
//  Copyright © 2017年 user_17. All rights reserved.
//

import UIKit


class AddMemoriesTableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    
    
    @IBAction func done(_ sender: Any) {
        if nameTextField.text?.characters.count==0{
            let controller = UIAlertController(title: "警告", message: "未輸入名稱", preferredStyle: UIAlertControllerStyle.alert)
            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action)in})
            controller.addAction(action)
            present(controller, animated: true, completion: nil)
            return
        }
        if imageView.image==nil{
            let controller = UIAlertController(title: "警告", message: "未選取圖片", preferredStyle: UIAlertControllerStyle.alert)
            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action)in})
            controller.addAction(action)
            present(controller, animated: true, completion: nil)
            return
        }
        
        
        
        let number = Date().timeIntervalSinceReferenceDate
        let dic:[String:Any]=["name":nameTextField.text!, "photo":"\(number)","inner":innerSwitch.isOn,"pw":pwTextField.text!,"date":myDatePicker.date,"note":wordTextField.text!,"like":0]
        
        let data = UIImageJPEGRepresentation(imageView.image!, 0.8)
        
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("\(number)")
        
        try? data?.write(to: url!)
        
        let notiName = Notification.Name("AddMemory")
        NotificationCenter.default.post(name: notiName, object: nil, userInfo: dic)
        
        
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var wordTextField: UITextView!
    @IBOutlet weak var myDatePicker: UIDatePicker!
    @IBOutlet weak var innerSwitch: UISwitch!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pwTextField: UITextField!
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectPhoto(_ sender: Any) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        
        show(controller, sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
