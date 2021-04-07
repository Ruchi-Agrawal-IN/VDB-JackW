//
//  ViewController-UITableViewDataSource.swift
//  JackGit
//
//  Created by Ruchi Agrawal on 4/6/21.
//

import UIKit

extension ViewController {
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: tableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! tableViewCell
        //        cell.tag = indexPath.row
        let jackProject = viewModel[indexPath.row]
        
        cell.nameLabel!.text = jackProject?.name
        cell.descriptionLabel.text = jackProject?.description
        cell.languageLabel.text = jackProject?.language
        cell.openIssuesLabel.text = String(jackProject?.open_issues ?? 0)
        cell.watcherCountLabel.text = String(jackProject?.watchers ?? 0)
        //Fire Event by checking index with total count
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView,
                            willDisplay cell: UITableViewCell,
                            forRowAt indexPath: IndexPath){
        
        if (indexPath.row == viewModel.count-3) {
            // print("indexpath.row is : \(indexPath.row) & viewModelCount is :\(viewModel.count)")
            activityIndicator.start {
                DispatchQueue.global(qos: .userInitiated).async {
                    self.viewModel.downloadData()
                    DispatchQueue.main.async { [weak self] in
                        self?.activityIndicator.stop()
                    }
                }
            }
            //            self.viewModel.downloadData()
            //            self.activityIndicator.stop()
            //   print("hello")
        }
        
    }
}




