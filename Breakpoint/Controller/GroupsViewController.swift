//
//  GroupsViewController
//  Breakpoint
//
//  Created by Jibran Syed on 10/24/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import UIKit

class GroupsViewController: UIViewController 
{
    @IBOutlet weak var tableGroupsListing: UITableView!
    
    
    var groups = [Group]()
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableGroupsListing.delegate = self
        tableGroupsListing.dataSource = self
    }

    
    override func viewDidAppear(_ animated: Bool) 
    {
        super.viewDidAppear(animated)
        
        // Check for new groups in real time
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            // Download all groups associated with this user
            DataService.instance.getAllGroupsOfCurrentUser { (returnedGroups) in
                self.groups = returnedGroups
                self.tableGroupsListing.reloadData()
            }
        }
        
    }
    

    
}


extension GroupsViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int 
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int 
    {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: REUSE_ID_GROUPS_CELL) as? GroupsCell else {return UITableViewCell()}
        
        let group = self.groups[indexPath.row]
        cell.configureCell(title: group.title, description: group.description, memberCount: group.memberCount)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) 
    {
        guard let groupFeedVC = storyboard?.instantiateViewController(withIdentifier: STRY_BRD_GROUP_FEED_VC) as? GroupFeedViewController else { return }
        
        groupFeedVC.setupData(withGroup: self.groups[indexPath.row])
        
        //present(groupFeedVC, animated: true, completion: nil)
        presentDetail(groupFeedVC)
    }
}

