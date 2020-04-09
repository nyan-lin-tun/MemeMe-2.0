//
//  MemeTableViewController.swift
//  Meme
//
//  Created by Nyan Lin Tun on 08/04/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var memes = [Meme]()

    override func viewWillAppear(_ animated: Bool) {
        self.memes = appDelegate.memes
        self.tableView.reloadData()
        
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
        return self.memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let memeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "memeTableViewCell") as! MemeTableViewCell
        let meme = self.memes[indexPath.row]
        memeTableViewCell.memeImage.image = meme.memeImage
        memeTableViewCell.memeText.text = "\(meme.topText)\n\(meme.bottomText)"

        return memeTableViewCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memeDetailVC = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        memeDetailVC.modalPresentationStyle = .fullScreen
        memeDetailVC.meme = self.memes[indexPath.row]
        self.navigationController?.pushViewController(memeDetailVC, animated: true)
    }
    

}
