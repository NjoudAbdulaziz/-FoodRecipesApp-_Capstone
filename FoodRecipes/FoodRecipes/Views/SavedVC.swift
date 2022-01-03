//
//  RecipesVC.swift
//  FoodRecipes
//
//  Created by Njoud Alrshidi on 10/05/1443 AH.
//

import UIKit

class SavedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)

        registerCells()
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName:RecipesListTableViewCell.identifier, bundle: nil),forCellReuseIdentifier: RecipesListTableViewCell.identifier)
    }
    
}

//extension SavedVC: UITableViewDelegate , UITableViewDataSource {
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        <#code#>
//    }
//
//
//
//
//}
