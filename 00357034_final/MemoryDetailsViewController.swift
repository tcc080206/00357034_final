//
//  MemoryDetailsViewController.swift
//  00357034_final
//
//  Created by user_17 on 2017/6/17.
//  Copyright © 2017年 user_17. All rights reserved.
//

import UIKit

class MemoryDetailsViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var memoryImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var notes: UITextView!
    var memoryDic:[String:Any]!
    
    /*func getAddMemoryNoti(noti:Notification){
        let memory = noti.userInfo as? [String:Any]
        memoryDic = memory
        
                
        
    }*/

    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*let notiName = Notification.Name("EditMemory")
        NotificationCenter.default.addObserver(self, selector: #selector(MemoryDetailsViewController.getAddMemoryNoti(noti:)), name: notiName, object: nil)*/
        // Do any additional setup after loading the view.
        nameLabel.text = memoryDic["name"] as? String
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent(memoryDic["photo"]! as! String)
        memoryImage.image = UIImage(contentsOfFile: url!.path)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dateLabel.text = formatter.string(
            from: memoryDic["date"] as! Date)
        notes.text = memoryDic["note"] as? String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
