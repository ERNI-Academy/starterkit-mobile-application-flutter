# Architecture Overview

## State Management
The project's state management will be using the [MVVM (Model-View-View Model)](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel) design pattern, built on top of [Provider](pub.dev/packages/provider). Combined with [Clean Achitecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html), this pattern promotes a clear separation of concerns (UI, business logic, data) by making each layer cohesive with one another.

## Layers

- **Data Layer** - Access the information to be used in the app. Sources include local data (databases, caches) or through web services (APIs).
- **Domain Layer** - Contains abstractions of the different business logics.
- **Business Layer** - Implementations of the domain layer. Here resides your business logics, as well as model classes like entities and data contracts.
- **UI Layer** - Concerns how the data will be presented to the user.