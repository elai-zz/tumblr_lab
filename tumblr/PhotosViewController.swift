//
//  ViewController.swift
//  tumblr
//
//  Created by Minnie Lai on 10/13/16.
//  Copyright © 2016 minnie. All rights reserved.
//

import UIKit
import AFNetworking

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var posts : [NSDictionary] = [NSDictionary]()
    
    @IBOutlet weak var photosTableView: UITableView!

    
    override func viewDidLoad() {
        photosTableView.rowHeight = 320
    
        let apiKey = "Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV"
        let url = URL(string:"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=\(apiKey)")
        let request = URLRequest(url: url!)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(with: request,completionHandler: { (dataOrNil, response, error) in
            if let data = dataOrNil {
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
                    //NSLog("response: \(responseDictionary)")
                    self.posts = (responseDictionary["response"] as! NSDictionary)["posts"] as! [NSDictionary]
                    self.photosTableView.reloadData()
                }
            }
        });
        task.resume()
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        photosTableView.dataSource = self
        photosTableView.delegate = self
        
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(self.refreshControlAction(refreshControl:)), for: UIControlEvents.valueChanged)

        // add refresh control to table view
        photosTableView.insertSubview(refreshControl, at: 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = photosTableView.dequeueReusableCell(withIdentifier: "com.reuse.cell", for: indexPath) as! PhotosViewCell
        let actualURL = URL(string: getURL(indexPath: indexPath))
        cell.photoImageView.setImageWith(actualURL!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func getURL(indexPath: IndexPath) -> String {
        let images = ((posts[indexPath.row]["photos"] as! [NSDictionary])[0])
        let imageObject = images["alt_sizes"] as! [NSDictionary]
        let imagesURL = imageObject[0]["url"]
        let string = imagesURL ?? nil
        return string as! String
    }

    func tableView(didSelectRowAtIndexPath indexPath: IndexPath) {
        photosTableView.deselectRow(at: indexPath, animated:true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! PhotoDetailsViewController
        let indexPath = photosTableView.indexPath(for: sender as! PhotosViewCell)
        vc.photoURL = getURL(indexPath: indexPath!)
    }
    
    // Makes a network request to get updated data
    // Updates the tableView with the new data
    // Hides the RefreshControl
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        let apiKey = "Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV"
        let url = URL(string:"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=\(apiKey)")
        let request = URLRequest(url: url!)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        
        let task : URLSessionDataTask = session.dataTask(with: request,completionHandler: { (dataOrNil, response, error) in
            if let data = dataOrNil {
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
                    //NSLog("response: \(responseDictionary)")
                    self.posts = (responseDictionary["response"] as! NSDictionary)["posts"] as! [NSDictionary]
                    self.photosTableView.reloadData()
                    refreshControl.endRefreshing()
                }
            }
        });
        task.resume()
    }


}

