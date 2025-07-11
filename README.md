# Locations VIP

An iOS application built using the VIP architecture.

## Features

- Fetches a list of predefined locations
- Displays the locations in a scrollable list
- If the user has granted location permissions:
  - Calculates the distance from the user's current location to each destination
  - Sorts the list by proximity

## Highlights

- **Network layer** (`NetworkService.swift`, `NetworkRequest.swift`, etc.): A flexible, async/await-driven abstraction over Alamofire with strong typing, error handling, and clear extensibility.
- **Use Cases**: The domain logic lives in dedicated UseCases, which can easily be tested and shared between interactors.
- **Dependency injection**: A simple container and `@Injected` property wrappers with KeyPaths.
