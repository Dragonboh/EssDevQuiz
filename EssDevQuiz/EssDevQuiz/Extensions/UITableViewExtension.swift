//
//  UiTableViewExtension.swift
//  EssDevQuiz
//
//  Created by admin on 03.07.2024.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T>(_ type: T.Type) -> T? {
        let identifier = String(describing: type)
        let cell = self.dequeueReusableCell(withIdentifier: identifier) as? T
        return cell
    }
    
    func register<T>(_ cellType: T.Type) {
        let identifier = String(describing: cellType)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
}
