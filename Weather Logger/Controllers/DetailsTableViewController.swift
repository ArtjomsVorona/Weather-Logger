//
//  DetailsTableViewController.swift
//  Weather Logger
//
//  Created by Artjoms Vorona on 17/01/2020.
//  Copyright © 2020 Artjoms Vorona. All rights reserved.
//

import UIKit

class DetailsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath)

        cell.textLabel?.text = "No data to display"

        return cell
    }

}
