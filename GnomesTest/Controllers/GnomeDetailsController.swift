//
//  GnomeDetailsController.swift
//  GnomesTest
//
//  Created by Romelys Rivero on 6/17/19.
//  Copyright © 2019 Angel Rivero. All rights reserved.
//

import UIKit

class GnomeDetailsController: UIViewController {

    // MARK:- Variables Declarations
    
    @IBOutlet weak var gnomeThumbnail: UIImageView!
    
    @IBOutlet weak var gnomeName: UILabel!
    
    @IBOutlet weak var gnomeAge: UILabel!
    
    @IBOutlet weak var gnomeWeight: UILabel!
    
    @IBOutlet weak var gnomeHeight: UILabel!
    
    @IBOutlet weak var gnomeHairColor: UILabel!
    
    @IBOutlet weak var professionsAndFriends: UITableView!
    
    var gnome : Gnome!
    private var professionsAndFriendsArray = [ExpandableName]()
    private var sectionHeight: CGFloat = 24
    private let cellId = "cellId"
    
    // MARK: - View Inital Configuration
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        setUpGnome()
    }
    
    //MARK:- Setup Methods
    
    /**
     Set up the elements of the Gnome Details View using the existing gnome
     */
    private func setUpGnome() {
        gnomeName.text = self.gnome.name
        gnomeAge.text = "Age: " + String(self.gnome.age)
        gnomeWeight.text = "Weight: " + String(self.gnome.weight)
        gnomeHeight.text = "Height: " + String(self.gnome.height)
        gnomeHairColor.text = "Hair Color: " + self.gnome.hair_color
        guard let url = URL(string: self.gnome.thumbnail.toSecureHTTPS()) else {return}
        gnomeThumbnail.sd_setImage(with: url, completed: nil)
        gnomeThumbnail.setRounded()
        setUpTableViewData()
    }
    
    /**
     Set up the `professionsAndFriends` table view where checks if the gnome have professions and friends
     or only friends or professions
     */
    private func setUpTableViewData() {
        professionsAndFriends.tableFooterView = UIView()
        professionsAndFriends.allowsSelection = false
        professionsAndFriends.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        if gnome!.friends.count == 0, gnome!.professions.count == 0 {
            professionsAndFriends.isHidden = true
        }
        if gnome!.professions.count == 0 {
            professionsAndFriendsArray = [ExpandableName(isExpanded: false, names: gnome!.friends,isProfessions: false)]
        } else if gnome!.friends.count == 0 {
            professionsAndFriendsArray = [ExpandableName(isExpanded: false, names: gnome!.professions,isProfessions: true)]
        } else {
            professionsAndFriendsArray = [ExpandableName(isExpanded: false, names: gnome!.professions,isProfessions: true),
                                          ExpandableName(isExpanded: false, names: gnome!.friends,isProfessions: false)]
        }
        
    }
    
}

extension GnomeDetailsController: UITableViewDelegate, UITableViewDataSource {
    //MARK:- TableView Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return professionsAndFriendsArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !professionsAndFriendsArray[section].isExpanded {
            return 0
        }
        return professionsAndFriendsArray[section].names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = professionsAndFriendsArray[indexPath.section].names[indexPath.row]
        return cell
    }
    
    /**
     Handle when the selected section (professions or friends) is open or close,
     deleting or inserting rows depending the state of the button
     
     - Parameter button: Button pressed
     */
    @objc func handleOpenClose(button: UIButton) {
        
        let section = button.tag
        var indexPaths = [IndexPath]()
        for row in professionsAndFriendsArray[section].names.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        let isExpanded = professionsAndFriendsArray[section].isExpanded
        professionsAndFriendsArray[section].isExpanded = !isExpanded
        button.setTitle(isExpanded ? "Open" : "Close" , for: .normal)
        if isExpanded {
            professionsAndFriends.deleteRows(at: indexPaths, with: .fade)
        } else {
            professionsAndFriends.insertRows(at: indexPaths, with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as! HeaderView
        if professionsAndFriendsArray[section].isProfessions {
            headerView.title?.text = "Professions"
        } else {
            headerView.title?.text = "Friends"
        }
        headerView.openCloseButton.setTitle("Open", for: .normal)
        headerView.openCloseButton.addTarget(self, action: #selector(handleOpenClose), for: .touchUpInside)
        headerView.openCloseButton.tag = section
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeight
    }
    
}

