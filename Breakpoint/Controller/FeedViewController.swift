//
//  FeedViewController
//  Breakpoint
//
//  Created by Jibran Syed on 10/24/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController 
{
    @IBOutlet weak var tableFeeds: UITableView!
    
    var feedMessages = [Message]()
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableFeeds.delegate = self
        tableFeeds.dataSource = self
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) 
    {
        super.viewDidAppear(animated)
        
        // Check for any changes to feeds that happen on the server
        DataService.instance.REF_FEED.observe(.value) { (snapshot) in
            // Get the latest feeds
            DataService.instance.getAllFeedMessages { (returnedMessages) in
                self.feedMessages = returnedMessages.reversed() // Show the most recent posts on top
                self.tableFeeds.reloadData()
            }
        }
    }
    
    
    
    
    
}



extension FeedViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int 
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int 
    {
        return feedMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: REUSE_ID_FEED_CELL) as? FeedCell else {return UITableViewCell() }
        
        let image = UIImage(named: "defaultProfileImage")
        let message = self.feedMessages[indexPath.row]
        
        DataService.instance.getUsername(forUID: message.senderId) { (returnedUsername) in
            cell.configureCell(profileImage: image!, email: returnedUsername, message: message.text)
        }
        
        return cell
    }
}

