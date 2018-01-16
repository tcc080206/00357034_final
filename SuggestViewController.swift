//
//  SuggestViewController.swift
//  00357034_final
//
//  Created by user_17 on 2017/6/20.
//  Copyright © 2017年 user_17. All rights reserved.
//

import UIKit

class SuggestViewController: UIViewController {
    var memories:[[String:Any]] = []
    var num:Int = 0
    var randomNum:Int = 0
    var dic:[String:Any]!
    var count:Int = 0
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ansLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("memories.txt")
        let array = NSArray(contentsOf: url!)
        if array != nil {
            memories = array as! [[String:Any]]
        }
        num = memories.count
        randomNum = roll(number: num)
        dic = memories[randomNum]
        let url2 = docUrl?.appendingPathComponent(dic["photo"]! as! String)
        imageView.image = UIImage(contentsOfFile: url2!.path)
    }
    
    func roll(number:Int)->Int{
        return Int(arc4random_uniform(UInt32(number)))
    }
    
    @IBAction func resetButton(_ sender: Any) {
        count+=1
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("memories.txt")
        let array = NSArray(contentsOf: url!)
        if array != nil {
            memories = array as! [[String:Any]]
        }
        num = memories.count
        randomNum = roll(number: num)
        dic = memories[randomNum]
        let url2 = docUrl?.appendingPathComponent(dic["photo"]! as! String)
        imageView.image = UIImage(contentsOfFile: url2!.path)
        switch count {
        case 0:ansLabel.text = "這張如何？"
        case 1:ansLabel.text = "那這張呢？"
        case 2:ansLabel.text = "這張總可以了吧？"
        case 3:ansLabel.text = "你很挑喔！"
        case 4:ansLabel.text = "別再挑了！"
        case 5:ansLabel.text = "最後一張！"
        default:ansLabel.text = "隨便你選拉！"
        }
    }
    
    @IBAction func like(_ sender: Any) {
        count=0;
        ansLabel.text = "謝謝你喜歡這張照片！"
        var likeCount = memories[randomNum]["like"] as! Int
        likeCount+=1
        memories[randomNum]["like"] = likeCount
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("memories.txt")
        (memories as NSArray).write(to: url!, atomically: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        randomNum = roll(number: num)
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
