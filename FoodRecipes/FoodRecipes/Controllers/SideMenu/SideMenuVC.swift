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

    @IBOutlet weak var sideMenuTableView: UITableView!
    
    @IBOutlet weak var sideMenuImageBackground: UIImageView!
    //declare the delegate
    var delegate: SideMenuVCDelegate?
    var defaultHighlightedCell: Int = 0
    
    var menu: [SideMenu] = [
        SideMenu(icon: UIImage(named: "searchIcon")!, title: "Search Recipes".localized),
        SideMenu(icon: UIImage(named: "saveIcon")!, title: "Saved Recipes".localized),
        SideMenu(icon: UIImage(named: "settings")!, title: "Settings".localized),
        SideMenu(icon: UIImage(named: "aboutUsIcon")!, title: "About Us".localized)
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TableView
        self.sideMenuTableView.delegate = self
        self.sideMenuTableView.dataSource = self
        self.sideMenuTableView.separatorStyle = .none
        
        
        // Start observing style change
         startObserving(&UserInterfaceStyleManager.shared)

        //Background of The SideMenu
        sideMenuImageBackground.image = UIImage(named: "1")

        // Set Highlighted Cell
        DispatchQueue.main.async {
            let defaultRow = IndexPath(row: self.defaultHighlightedCell, section:0)
            self.sideMenuTableView.selectRow(at: defaultRow, animated: false, scrollPosition: .none)
    }
        
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
      return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.selectedCell(indexPath.row)
    }


}
