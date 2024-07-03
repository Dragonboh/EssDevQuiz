//
//  TableViewHelpers.swift
//  EssDevQuizTests
//
//  Created by admin on 02.07.2024.
//

import UIKit

extension UITableView {
    func cell(row: Int, section: Int) -> UITableViewCell? {
        let indexPath = IndexPath(row: row, section: section)
        return dataSource?.tableView(self, cellForRowAt: indexPath)
    }
    
    func select(row: Int, section: Int) {
        let indexPath = IndexPath(row: row, section: section)
        self.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        delegate?.tableView?(self, didSelectRowAt: indexPath)
    }
    
    func deselect(row: Int, section: Int) {
        let indexPath = IndexPath(row: row, section: section)
        self.deselectRow(at: indexPath, animated: false)
        delegate?.tableView?(self, didDeselectRowAt: indexPath)
    }
}
