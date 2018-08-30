//
//  CollectibleTableVC.swift
//  Collector
//
//  Created by Vu Duong on 8/29/18.
//  Copyright © 2018 Vu Duong. All rights reserved.
//

import UIKit

class CollectibleTableVC: UITableViewController {

    var allCollectibles = [Collectible]()
    
    override func viewWillAppear(_ animated: Bool) {
        getCollectibles()
    }
    func getCollectibles() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let collectiblesFromCD = try? context.fetch(Collectible.fetchRequest()) {
                if let collectibles = collectiblesFromCD as? [Collectible] {
                    allCollectibles = collectibles
                    tableView.reloadData()
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCollectibles.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let currentCollectibles = allCollectibles[indexPath.row]
        cell.textLabel?.text = currentCollectibles.title
        //Convert from Data to UImage
        if let data = currentCollectibles.image {
        cell.imageView?.image = UIImage(data: data)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let currentCollectibles = allCollectibles[indexPath.row]
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                context.delete(currentCollectibles)
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                getCollectibles()
            }
        }
    }
}
