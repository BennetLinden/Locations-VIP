// Created on 17/07/2020

import UIKit

extension UITableView {
    /// Registers a reusable cell class with the table view.
    ///
    /// - Parameter cellType: The cell class to register. Must conform to `UITableViewCell` and `Reusable`.
    final func register<Cell: UITableViewCell & Reusable>(cellType: Cell.Type) {
        register(cellType.self, forCellReuseIdentifier: cellType.reuseIdentifier)
    }

    /// Dequeues a reusable cell of the specified type for the given index path.
    ///
    /// - Parameters:
    ///   - indexPath: The index path specifying the location of the cell.
    ///   - cellType: The cell class to dequeue. Defaults to the inferred type.
    /// - Returns: A reusable cell of the specified type.
    /// - Note: Crashes at runtime if the cell hasn't been registered or if the cast fails.
    final func dequeueReusableCell<Cell: UITableViewCell & Reusable>(
        for indexPath: IndexPath,
        cellType: Cell.Type = Cell.self
    ) -> Cell {
        guard
            let cell = dequeueReusableCell(
                withIdentifier: cellType.reuseIdentifier,
                for: indexPath
            ) as? Cell
        else {
            fatalError("Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). Check that you registered the cell beforehand.")
        }
        return cell
    }
}
