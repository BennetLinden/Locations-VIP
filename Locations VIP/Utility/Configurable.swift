// Created on 26/10/2021

import Foundation

/// A protocol that indicates a type can be initialized with a default initializer.
protocol Initializable {
    init()
}

/// A marker protocol used to provide configuration capabilities via extensions.
protocol Configurable { }

extension Configurable where Self: Initializable, Self: AnyObject {
    /// Creates and configures a new instance using the provided closure.
    ///
    /// - Parameter configurator: A closure that receives the new instance for configuration.
    /// - Returns: The configured instance.
    static func configure(with configurator: (Self) -> Void) -> Self {
        let instance = Self()
        configurator(instance)
        return instance
    }
}

extension Configurable where Self: AnyObject {
    /// Configures the current instance using the provided closure.
    ///
    /// - Parameter configurator: A closure that receives the instance for configuration.
    /// - Returns: The same instance, allowing for chaining.
    @discardableResult
    func configure(with configurator: (Self) -> Void) -> Self {
        configurator(self)
        return self
    }
}

extension Configurable {
    /// Configures the current value-type instance using the provided inout closure.
    ///
    /// - Parameter configurator: A closure that modifies the instance in place.
    /// - Returns: The modified instance.
    @discardableResult
    mutating func configure(with configurator: (inout Self) -> Void) -> Self {
        configurator(&self)
        return self
    }
}

/// Extends `NSObject` to conform to `Initializable` and `Configurable`,
/// enabling configuration on all `NSObject` subclasses.
extension NSObject: Initializable, Configurable { }
