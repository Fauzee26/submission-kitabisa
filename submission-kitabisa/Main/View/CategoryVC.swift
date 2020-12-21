//
//  CategoryVC.swift
//  submission-kitabisa
//
//  Created by Muhammad Hilmy Fauzi on 21/12/20.
//

import UIKit

class CategoryVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let categories = [MovieType.popular, MovieType.upcoming, MovieType.topRated, MovieType.nowPlaying]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func btnCancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CategoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell")!
        
        let category = categories[indexPath.row]
        cell.textLabel?.text = beautifyString(from: category)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCategory = categories[indexPath.row]
        NotificationCenter.default.post(name: K.Notif.NOTIF_CATEGORY_SELECTED, object: selectedCategory)
        
        self.dismiss(animated: true, completion: nil)
    }
}
