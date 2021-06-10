//
//  LoggedDataSource.swift
//  BMT-Mobile
//
//  Created by Giuliano Accorsi on 23/05/21.
//

import UIKit


final class LoggedDataSource: NSObject {
    
    private weak var tableView: UITableView?
    private var immobileList: [Immobile] = []
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        registerCells()
        setupDataSource()
        
    }
    
    private func registerCells() {
        tableView?.register(ImmobileCell.self, forCellReuseIdentifier: "ImmobileCell")
    }
    
    private func setupDataSource() {
        tableView?.dataSource = self
        tableView?.delegate = self
    }
    
    func updateImmobile(immobiles: [Immobile]) {
        self.immobileList = immobiles
        tableView?.reloadData()
    }
    
}

extension LoggedDataSource: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return immobileList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ImmobileCell = tableView.dequeueReusableCell(withIdentifier: "ImmobileCell", for: indexPath) as? ImmobileCell else { return UITableViewCell()}
        let immobile = immobileList[indexPath.row]
        cell.setupCell(immobile: immobile)
        return cell
    }
}

