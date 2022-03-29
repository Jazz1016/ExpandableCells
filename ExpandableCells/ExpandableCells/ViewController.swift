//
//  ViewController.swift
//  ExpandableCells
//
//  Created by James Lea on 3/28/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    class Section {
        let title: String
        let options: [String]
        var isOpened: Bool = false
        
        init(title: String, options: [String], isOpened: Bool = false) {
            self.title      = title
            self.options    = options
            self.isOpened   = isOpened
        }
    }
        
    private var sections = [Section]()
    

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //Set up model
        sections = [
            Section(title: "Section1", options: [1,2,3].compactMap({ return "Cell \($0)"})),
            Section(title: "Section2", options: [1,2,3].compactMap({ return "Cell \($0)"})),
            Section(title: "Section3", options: [1,2,3].compactMap({ return "Cell \($0)"})),
            Section(title: "Section4", options: [1,2,3].compactMap({ return "Cell \($0)"}))
        ]
        view.addSubview(tableView)
        tableView.delegate      = self
        tableView.dataSource    = self
        
        tableView.frame = view.bounds
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        
        if section.isOpened {
            return section.options.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//            cell.textLabel!.text = "Hello"
            cell.textLabel?.text = sections[indexPath.section].title
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        sections[indexPath.section].isOpened = !sections[indexPath.section].isOpened
        tableView.reloadSections([indexPath.section], with: .none)
    }

}//End of Class

