// Created on 27/05/2020

import Foundation

/// A protocol for views (like UITableViewCell or UICollectionViewCell) that can be reused.
protocol Reusable {
    /// A reuse identifier derived from the conforming type's name.
    static var reuseIdentifier: String { get }
}

extension Reusable {
    /// Default implementation of `reuseIdentifier` using the type name.
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
