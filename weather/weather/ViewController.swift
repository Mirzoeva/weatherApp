//
//  ViewController.swift
//  weather
//
//  Created by Ума Мирзоева on 17.11.2020.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

}

extension ViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        print(searchBar.text!)
    }
    
}
