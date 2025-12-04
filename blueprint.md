# Project Blueprint

## Overview

This document outlines the architecture, features, and design of the Flutter application. The app serves as a directory for various services, allowing users to browse, view details, and for administrators to manage and view service statistics.

## Existing Features

### 1. Authentication

*   **User Registration:** Users can create an account with their name, email, and password. User types can be specified (e.g., 'user', 'admin').
*   **User Sign-in:** Registered users can sign in using their email and password.
*   **Password Reset:** Users can request a password reset email.
*   **State Management:** The `AuthBloc` manages the authentication state, providing the rest of the app with the current user's status (authenticated, unauthenticated).
*   **Error Handling:** Uses a custom `FirebaseExceptions` class and `FirebaseFailure` to manage and report authentication errors.

### 2. Service Management

*   **Create Service:** Authenticated users can create new services, providing details like name, description, category, and contact information.
*   **View Services:** All users can view a list of available services.
*   **View Service Details:** Users can tap on a service to see a detailed view.
*   **Update and Delete:** Service owners or administrators can update or delete service listings.
*   **Reviews:** Users can add and view reviews for services.
*   **State Management:** The `ServiceBloc` handles all service-related operations.

## Newly Implemented Feature: Service Metadata & Analytics

### 1. Feature Overview

The "Service Metadata" feature introduces analytics for services. It tracks and displays key metrics, providing valuable insights into service performance and user engagement. Access to this feature is restricted to admin users.

### 2. Technical Implementation

*   **Architecture:** Follows the existing layered architecture (Presentation, Domain, Data).
    *   **Presentation:**
        *   `ServiceMetadataPage`: A new page to display the statistics.
        *   `ServiceMetadataDisplay`: A widget that presents the data and includes a form for submitting reviews.
        *   `ServiceMetadataBloc`: Manages the state for the analytics page.
    *   **Domain:**
        *   `ServiceMetadata` Entity: Defines the data structure for the analytics (clicks, review count, average rating).
        *   `ServiceMetadataRepository`: Abstract interface for data operations.
        *   Use Cases: `GetServiceMetadata`, `IncrementServiceClicks`, `UpdateServiceReview`.
    *   **Data:**
        *   `ServiceMetadataRepositoryImpl`: Implements the repository, handling the conversion of exceptions to failures.
        *   `ServiceMetadataRemoteDataSource`: Interface for the remote data source.
        *   `ServiceMetadataRemoteDataSourceImpl`: Communicates with Firestore to fetch and update analytics data.
*   **Data Storage:** A new `serviceMetadata` collection is used in Firestore. Each document in the collection corresponds to a service and stores its analytics data.
*   **Error Handling:** The implementation correctly uses the established `FirebaseExceptions` and `FirebaseFailure` pattern for consistent error handling throughout the app.

### 3. Integration with Existing UI

*   A "Statistics" icon button has been added to the `ServiceDetailsScreen`.
*   This button is only visible to users with a `userType` of 'admin', ensuring that the analytics are a protected feature.
*   Tapping the button navigates the admin user to the `ServiceMetadataPage` for the selected service.

## Design and Styling

*   **Theme:** The app uses a Material Design theme with a primary color scheme based on orange and deep orange.
*   **Typography:** The app uses standard Material Design typography.
*   **Layout:** The app uses a combination of `CustomScrollView`, `SliverAppBar`, and `SliverList` for a modern, scrollable user experience. Cards are used to group and display information.
*   **Iconography:** The app uses Material Design icons to enhance usability and visual appeal.

## Plan for the Current Request

The goal was to implement a service analytics feature accessible only to administrators.

1.  **DONE:** Create the layered architecture for the `serviceMetadata` feature (Bloc, Use Cases, Repository, Data Source).
2.  **DONE:** Implement the data source to interact with a `serviceMetadata` collection in Firestore.
3.  **DONE:** Implement the repository to handle data operations and error conversion.
4.  **DONE:** Implement the domain layer with entities and use cases.
5.  **DONE:** Implement the presentation layer with a BLoC, a page to display the data, and widgets to render the statistics.
6.  **DONE:** Register all new dependencies in the `service_locator.dart` file.
7.  **DONE:** Add a button to the `ServiceDetailsScreen` that navigates to the new `ServiceMetadataPage`.
8.  **DONE:** Restrict the visibility of the statistics button to admin users only.
9.  **DONE:** Ensure the new feature's error handling is consistent with the rest of the application by using `FirebaseExceptions` and `FirebaseFailure`.
