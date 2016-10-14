//
//  PhotoDetailsViewController.swift
//  Pods
//
//  Created by Minnie Lai on 10/13/16.
//
//

import UIKit
import AFNetworking

class PhotoDetailsViewController: UIViewController {
    
    @IBOutlet weak var detailImageView: UIImageView!
    var photoURL : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        detailImageView.setImageWith(URL(string: photoURL)!)
        
        // Do any additional setup after loading the view.
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
