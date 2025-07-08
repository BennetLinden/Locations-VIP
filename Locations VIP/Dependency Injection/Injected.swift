//
//  Injected.swift
//
//  Created by Bennet van der Linden on 27/06/2022.
//

import Foundation

@propertyWrapper
struct Injected<Value> {
    private let keyPath: KeyPath<DependencyContainer, Value>

    init(_ keyPath: KeyPath<DependencyContainer, Value>) {
        self.keyPath = keyPath
    }

    var wrappedValue: Value {
        DependencyContainer[keyPath]
    }
}
