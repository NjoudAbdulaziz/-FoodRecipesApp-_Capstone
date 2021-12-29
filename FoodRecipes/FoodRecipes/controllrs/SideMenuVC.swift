//
//  SideMenuVC.swift
//  FoodRecipes
//
//  Created by Njoud Alrshidi on 24/05/1443 AH.
//

import UIKit


//To detect which cell has been selected, use a delegate to pass the row number.
protocol SideMenuVCDelegate {
    
    func selectedCell(_ row: Int)
}

class SideMenuVC: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var sideMenuTableView: UITableView!
    
    //declare the delegate
    var delegate: SideMenuVCDelegate?
    var defaultHighlightedCell: Int = 0
    
    var menu: [SideMenu] = [
        SideMenu(icon: UIImage(named: "launchScreen-1")!, title: "Home"),
        SideMenu(icon: UIImage(named: "launchScreen-1")!, title: "Search"),
        SideMenu(icon: UIImage(named: "launchScreen-1")!, title: "Saved"),
        SideMenu(icon: UIImage(named: "launchScreen-1")!, title: "Settings"),
        SideMenu(icon: UIImage(named: "launchScreen-1")!, title: "Profile")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TableView
        self.sideMenuTableView.delegate = self
        self.sideMenuTableView.dataSource = self
        self.sideMenuTableView.separatorStyle = .none
        
        // Set Highlighted Cell
        DispatchQueue.main.async {
            let defaultRow = IndexPath(row: self.defaultHighlightedCell, section:0)
            self.sideMenuTableView.selectRow(at: defaultRow, animated: false, scrollPosition: .none)
        }
        // logOutBtn
        
        // Register TableView Cell
        self.sideMenuTableView.register(SideMenuTableViewCell.nib, forCellReuseIdentifier: SideMenuTableViewCell.identifire)
        
        // Update TableView with the data
        self.sideMenuTableView.reloadData()
    }
    
}
 
//MARK:- UITableViewDelegate

extension SideMenuVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
      }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuTableViewCell.identifire, for: indexPath) as? SideMenuTableViewCell else{fatalError("xib doesn't exist")}
        cell.iconImageView.image = self.menu[indexPath.row].icon
        cell.titleLabel.text = self.menu[indexPath.row].title
        
        // Highlighted color any color i want
        
      return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.selectedCell(indexPath.row)
    }
    //MARK:- ممكن اضيفه
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        // ...
//
//        // Remove highlighted color when you press the 'Profile' and 'Like us on facebook' cell
//        if indexPath.row == 4 || indexPath.row == 6 {
//            tableView.deselectRow(at: indexPath, animated: true)
//        }
//    }
}
