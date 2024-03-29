//
//  TableViewController.swift
//  test
//
//  Created by Vladimir on 16.11.2020.
//  Copyright © 2020 Vladimir. All rights reserved.
//

import UIKit




class TableViewController: UITableViewController, MyChildrenInfoCellDelegate, AddChildrenInfoCellDelegate {

    let headerTitles = ["My info", "My children's info"]
    var childsInfo = [Person]()
    var myInfo: Person?
    var indexOfCellToDelete: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "InputInfoCell", bundle: nil), forCellReuseIdentifier: "InputInfoCell")
        self.tableView.register(UINib(nibName: "AddChildrenInfoCell", bundle: nil), forCellReuseIdentifier: "AddChildrenInfoCell")
        self.tableView.register(UINib(nibName: "MyChildrenInfoCell", bundle: nil), forCellReuseIdentifier: "MyChildrenInfoCell")
        
    }
    
    func addperson() {
        let alert = UIAlertController(title: "Type child's info", message: "", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Age"
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let nameTextField = alert?.textFields![0]
            let ageTextField = alert?.textFields![1]
            self.childsInfo.append(Person(name: (nameTextField?.text)!, age: (ageTextField!.text!)))
            //                self.numberOfCellsInSections[1] += 1
            self.tableView.reloadData()
            print(self.childsInfo)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func deletePersonInfo(on index: Int) {
        if childsInfo.count < 5{
            childsInfo.remove(at: index - 1)
            tableView.reloadData()
        }else{
            childsInfo.remove(at: index)
            tableView.reloadData()
        }
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 2
        }else{
            if childsInfo.count < 5 {
                return childsInfo.count + 1
            }
            else{
                return childsInfo.count
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            if indexPath.row == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "InputInfoCell", for:indexPath) as? InputInfoCell
                cell?.textField.placeholder = "Type your name"
                return cell!
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "InputInfoCell", for:indexPath) as? InputInfoCell
                cell?.textField.placeholder = "Type your age"
                return cell!
            }
        }else{
            if indexPath.row == 0 {
                if childsInfo.count < 5 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "AddChildrenInfoCell", for:indexPath) as? AddChildrenInfoCell
                    cell?.delegate = self
                    return cell!
                }else{
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "MyChildrenInfoCell", for:indexPath) as! MyChildrenInfoCell
                    cell.index = indexPath.row
                    cell.nameLabel.text = childsInfo[indexPath.row].name
                    cell.ageLabel.text = childsInfo[indexPath.row].age
                    return cell
                }
            }
            if childsInfo.count < 5{
                let cell = tableView.dequeueReusableCell(withIdentifier: "MyChildrenInfoCell", for:indexPath) as! MyChildrenInfoCell
                cell.index = indexPath.row
                cell.nameLabel.text = childsInfo[indexPath.row - 1].name
                cell.ageLabel.text = childsInfo[indexPath.row - 1].age
                cell.delegate = self
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "MyChildrenInfoCell", for:indexPath) as! MyChildrenInfoCell
                cell.index = indexPath.row
                cell.nameLabel.text = childsInfo[indexPath.row].name
                cell.ageLabel.text = childsInfo[indexPath.row].age
                cell.delegate = self

                return cell
            }
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < headerTitles.count {
            return headerTitles[section]
        }
        return nil
    }
    
}

        
