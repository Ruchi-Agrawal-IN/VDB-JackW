//
//  ViewController.swift
//  JackGit
//
//  Created by Ruchi Agrawal on 4/6/21.
//

import UIKit

class ViewController: UITableViewController {
    let viewModel = ViewModel();
    var activityIndicator: LoadMoreActivityIndicator!
    override func viewDidLoad() {
        super.viewDidLoad()
       // viewModel.addEntry()
        viewModel.downloadData()
        //tableView.delegate = self

        tableView.dataSource = self
        tableView.delegate=self
        tableView.tableFooterView = UIView()

        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "updateUI"), object: nil, queue: OperationQueue.main) { (notification) in
            self.tableView.reloadData()
        }
        activityIndicator = LoadMoreActivityIndicator(scrollView: tableView, spacingFromLastCell: 10, spacingFromLastCellWhenLoadMoreActionStart: 360)
    }
}

