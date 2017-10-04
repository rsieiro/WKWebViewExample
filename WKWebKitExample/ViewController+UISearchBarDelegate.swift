//
//  ViewController+UISearchBarDelegate.swift
//  WKWebKitExample
//
//  Created by Scotty on 02/10/2017.
//  Copyright © 2017 Diligent Robot. All rights reserved.
//

import UIKit

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        filterTowns(filter: searchText)
    }
    
        func filterTowns(filter: String) {
            let js = "filter(\"\(filter)\");"
            webView.evaluateJavaScript(js) { (count, error) in
                if let error = error {
                    self.processJSError(error)
                    return
                }
                
                DispatchQueue.main.async {
                    if let count = count as? Int {
                        self.countLabel.text = "\(count) town(s)"
                    } else {
                        self.countLabel.text = ""
                    }
                }
            }
        }
    
    private func processJSError(_ error: Error) {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error",
                                          message: error.localizedDescription,
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default,
                                          handler: nil))
            
            self.present(alert,
                         animated: true,
                         completion: nil)
        }
    }
    
}
