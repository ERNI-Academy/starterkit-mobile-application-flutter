# Architecture Overview

## State Management using Model-View-View Model (MVVM)

A software architecture pattern to separate concerns and improve code maintainability. It aims to provide a clear separation between the user interface (View), the data and business logic (ViewModel), and the underlying data models (Model).

While MVVM typically uses Observables or Reactive programming libraries, such as streams or Rx, in Flutter, you can also implement MVVM using [`ValueListenable`](https://api.flutter.dev/flutter/foundation/ValueListenable-class.html) for data binding.

Read more about it [here](presentation/state_management.md).

## Clean Architecture

Another software architecture pattern that emphasizes separation of concerns and maintainability. It provides a clear and modular structure for building applications by dividing them into distinct layers.

By adopting Clean Architecture in your Flutter application, you can achieve a modular and testable codebase. Each layer has a specific responsibility and can be developed and tested independently. The separation of concerns also allows for easier maintenance and future changes as the application grows.


### Layers
In the context of Flutter, Clean Architecture can be implemented as follows:

#### Data

The Data layer is responsible for handling data-related operations and interactions with external sources such as databases, APIs, or local storage. It encapsulates all the data access logic, including retrieving, saving, updating, and deleting data. This layer provides a repository pattern that abstracts the underlying data sources, allowing the rest of the application to remain independent of the specific implementation details. In Flutter, the Data layer commonly includes repositories, data sources, and models representing the data.

#### Domain

The Domain layer, also known as the *Business Logic* layer, contains the core business rules, use cases, and business logic of the application. It represents the abstract, high-level concepts and behaviors of the application domain. The Domain layer is independent of any external frameworks or technologies and focuses solely on implementing the business requirements. This layer defines interfaces and interacts with the Data layer through repositories, allowing the application to fetch and manipulate data without worrying about the specific data sources or implementation details.

#### Presentation

The Presentation layer is responsible for the user interface (UI) and user interaction aspects of the application. It handles the rendering of data, user input, and presentation logic. In Flutter, this layer typically consists of widgets and classes that define the UI components and their behavior. The Presentation layer communicates with the Domain layer to fetch data and execute business logic, but it doesn't contain any business rules itself. It serves as a bridge between the user and the underlying functionality of the application.

### Data Flow

The flow of data and dependencies in Clean Architecture follows a unidirectional pattern:

```
+------------------------+       +------------------------+       +------------------------+
| Presentation Layer     | ----> | Domain Layer           | ----> | Data Layer             |
+------------------------+       +------------------------+       +------------------------+
|                        |       |                        |       |                        |
|  Widgets               |       |  Services              |       |  Repositories          |
|  Views                 |       |  Entities              |       |  APIs                  |
|  View Models           |       |  Mappers               |       |  Databases             |
|  Models                |       |  Validators            |       |  Data Contracts        |
+------------------------+       +------------------------+       +------------------------+
```

- The Presentation layer depends on the Domain layer and uses interfaces or abstract classes defined in the Domain layer to retrieve data and execute business logic operations.
- The Domain layer depends on the Data layer through interfaces or abstract classes defined in the Domain layer. It uses repositories to retrieve and store data without being aware of the specific data sources or implementation details.
- The Data layer interacts with external data sources and provides the necessary data access and management methods to the Domain layer.

## Project Structure

```
├── core
│   ├── data
│   ├── domain
│   ├── infrastructure
│   └── presentation
├── features
│   └── feature1
│       ├── data
│       ├── domain
│       └── presentation
└── shared
    ├── localization
    └── resources
```

### Core

Typically contains the foundational components and common utilities that are shared across the application.

### Features

Represents different functional modules or features of the application. Each feature can have its own self-contained set of packages.

### Shared

 Holds components or resources that are shared across multiple features or modules.