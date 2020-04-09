//
//  MemeTableViewController.swift
//  Meme
//
//  Created by Nyan Lin Tun on 08/04/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sent Memes"
        self.setUpNavigationItems()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let memeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "memeTableViewCell") as! MemeTableViewCell
        memeTableViewCell.memeImage.image = UIImage(named: "wow")
        memeTableViewCell.memeText.text = "First line \nBottom line"

        return memeTableViewCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memeDetailVC = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        memeDetailVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(memeDetailVC, animated: true)
    }
    

}
