//
//  HistoryViewController.swift
//  trackYourPoison
//
//  Created by Yvonne on 14.01.20.
//  Copyright © 2020 Ines&Yvonne. All rights reserved.
//

import UIKit
import CoreData

class HistoryViewController : UIViewController {
    
    var time : [String] = ["morning","noon","evening"]
    var morning : [Consumed] = []
    var noon : [Consumed] = []
    var evening : [Consumed] = []
    var history : [Consumed] = []
    @IBOutlet weak var historyTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTable.delegate = self
        historyTable.dataSource = self
        requestData()
        sortData()
    }
    
    func sortData() {
        for x in history.enumerated() {
            if x.element.time == "morning" {
                morning.append(x.element)
            } else if x.element.time == "noon"  {
                noon.append(x.element)
            } else if x.element.time == "evening" {
                evening.append(x.element)
            }
        }
    }
        
    func requestData() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<Consumed>(entityName: "Consumed")
        let sortDescriptor = NSSortDescriptor(key: "time", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        if let data = try? context.fetch(request){
            self.history = data
        }
    }
}

extension HistoryViewController : UITableViewDelegate {}
extension HistoryViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return morning.count
        } else if section == 1 {
            return noon.count
        } else {
            return evening.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryCell
        cell.name.text = history[indexPath.row].food?.name
        cell.name.numberOfLines = 2
        cell.amount.text = history[indexPath.row].time
        cell.imageView?.image = UIImage(named: history[indexPath.row].food?.image ?? " ")
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return time[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return time.count
    }

        
    
    
    
    
}
