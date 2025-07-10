// Created on 17/07/2020

import UIKit

extension UICollectionView {
    /// Registers a reusable cell class with the collection view.
    ///
    /// - Parameter cellType: The cell class to register. Must conform to `UICollectionViewCell` and `Reusable`.
    final func register<Cell: UICollectionViewCell & Reusable>(cellType: Cell.Type) {
        register(cellType.self, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }

    /// Dequeues a reusable cell of the specified type for the given index path.
    ///
    /// - Parameters:
    ///   - indexPath: The index path specifying the location of the cell.
    ///   - cellType: The cell class to dequeue. Defaults to the inferred type.
    /// - Returns: A reusable cell of the specified type.
    /// - Note: Crashes at runtime if the cell hasn't been registered or if the cast fails.
    final func dequeueReusableCell<Cell: UICollectionViewCell & Reusable>(
        for indexPath: IndexPath,
        cellType: Cell.Type = Cell.self
    ) -> Cell {
        guard
            let cell = dequeueReusableCell(
                withReuseIdentifier: cellType.reuseIdentifier,
                for: indexPath
            ) as? Cell
        else {
            fatalError("Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). Check that you registered the cell beforehand.")
        }
        return cell
    }
}
