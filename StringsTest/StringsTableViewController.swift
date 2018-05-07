//
//  StringsTableViewController.swift
//  StringsTest
//
//  Created by Vadym Yankovskiy on 5/6/18.
//  Copyright © 2018 Vadym Yankovskiy. All rights reserved.
//

import UIKit

class StringsTableViewController: UITableViewController, TableRouterDelegate {

    var router: StringsTableRouter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.router.delegate = self
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.router.modelsCount
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: TextTapTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TextTapTableViewCell
        
        cell.stringPresenter = self.router.model(for: indexPath.row)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            router.deleteModel(at: indexPath.row)
        }
    }
    
    func routerUpdateData() {
        tableView.reloadData()
    }
    
    func routerRecognized(word: String) {
        let alertVC = UIAlertController(title: "Recognized word", message: word, preferredStyle: UIAlertControllerStyle.alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
        
        self.present(alertVC, animated: true, completion: nil)
    }
}
