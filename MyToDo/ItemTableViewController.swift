//
//  ItemTableViewController.swift
//  MyToDo
//
//  Created by Angie Mugo on 17/01/2018.
//  Copyright © 2018 Angie Mugo. All rights reserved.
//

import UIKit

class ItemTableViewController: UITableViewController {

    let viewModel = ItemTableViewModel()
    
    //1
//    private let defaults = UserDefaults.standard

    //2
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    //3
    func configureView() {
        //Only display the cells with content
        tableView.tableFooterView = UIView(frame: .zero)
        //Add color gradient to the view
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = self.tableView.bounds
        gradientLayer.colors = [UIColor.red.withAlphaComponent(5).cgColor,UIColor.yellow.withAlphaComponent(0.5).cgColor]
        let backgroundView = UIView(frame: self.tableView.bounds)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        self.tableView.backgroundView = backgroundView

    }

    //MARK: IBActions
    //4
    @IBAction func didTapAdd(_ sender: Any) {

        let alert = UIAlertController(title: viewModel.alertTitle, message: viewModel.alertMessage, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: viewModel.actionTitle, style: .default, handler: { (_) in

            if let title = alert.textFields![0].text {
                guard !title.isEmpty else { return }
                let newIndex = self.viewModel.todoList.count
                self.viewModel.addToDo(title) 

                self.tableView.insertRows(at: [IndexPath(row: newIndex, section: 0)], with: .top)

                self.viewModel.saveData()
            }

        }))

        self.present(alert, animated: true, completion: nil)

    }
    
    // MARK: - Table view data source
    //5
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //6
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.todoList .count
    }

    // MARK: - Table view delegate methods
    //7
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = UIColor.clear

        if indexPath.row < viewModel.todoList.count
        {
            let item = viewModel.todoList[indexPath.row]
            cell.textLabel?.text = item.title
            
            //MARK: set the checkmark for item done
            let accessory: UITableViewCellAccessoryType = item.done ? .checkmark : .none
            cell.accessoryType = accessory
        }

        return cell
    }

    //MARK: mark as done
    //8
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row < self.viewModel.todoList.count {

//            self.viewModel.todoList[indexPath.row].done = !self.viewModel.todoList[indexPath.row].done
            
            viewModel.toggleDone(row: indexPath.row)
            
            tableView.reloadRows(at: [indexPath], with: .automatic)

            viewModel.saveData()
        }
    }

    //MARK: delete items
    //9
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

        if indexPath.row < self.viewModel.todoList.count {

           self.viewModel.deleteItem(indexPath.row)

            tableView.deleteRows(at: [indexPath], with: .top)
            viewModel.saveData()
        }
    }
    
    //MARK: fetch data from user defaults
    //10
//    func fetchData() {
//
//        if let list = defaults.value(forKey: "encodedList") as? [[String: Any]] {
//
//            for item in list {
//                guard let todoItem = ToDoItem(item) else { return }
//
//                self.viewModel.todoList.append(todoItem)
//            }
//        }
//    }
    
    
    //MARK: Save data to user defaults
    //11
//    func saveData() {
//
//        var encodedList = [[String: Any]]()
//
//        for item in self.viewModel.todoList {
//            encodedList.append(item.toPropertyList())
//        }
//
//        defaults.set(encodedList, forKey: "encodedList")
//    }
    
}
