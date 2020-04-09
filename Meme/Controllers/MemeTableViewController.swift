//
//  MemeTableViewController.swift
//  Meme
//
//  Created by Nyan Lin Tun on 08/04/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sent Memes"
        self.setUpNavigationItems()
        //Hide unwanted separator lines 
        self.tableView.tableFooterView = UIView()
        self.checkMemeDataAlert(memes: memes)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let memeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "memeTableViewCell") as! MemeTableViewCell
        let meme = memes[indexPath.row]
        memeTableViewCell.memeImage.image = meme.memeImage
        memeTableViewCell.memeText.text = "\(meme.topText)\n\(meme.bottomText)"

        return memeTableViewCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memeDetailVC = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        memeDetailVC.modalPresentationStyle = .fullScreen
        memeDetailVC.meme = memes[indexPath.row]
        self.navigationController?.pushViewController(memeDetailVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            memes.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
    

}
