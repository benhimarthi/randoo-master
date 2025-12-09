
# Project Blueprint

## Overview

This is a Flutter application that allows users to find and review services in their local area. The app includes features for user authentication, service browsing and filtering, and service creation and management.

## Features

*   **User Authentication:** Users can sign in, register, and reset their password.
*   **Service Browsing:** Users can browse services by category, town, and search query.
*   **Service Details:** Users can view detailed information about a service, including its description, contact information, and reviews.
*   **Service Creation and Management:** Authenticated users can create, edit, and delete their own services.
*   **Service Reviews:** Authenticated users can add reviews and ratings for services.
*   **Admin Dashboard:** Administrators can view service statistics.
*   **Dark Mode:** The app supports both light and dark themes.

## Style and Design

The app uses the Material Design 3 design system. It features a clean and modern user interface with a focus on usability. The color scheme is based on a deep orange primary color, and the typography is clear and legible.

## Current Task: Refactor Service Feature from Bloc to Cubit

The `service` feature was refactored to use a `Cubit` instead of a `Bloc` for state management. This change was made to simplify the codebase and improve performance.

### Steps Taken

1.  Created `lib/features/service/presentation/cubit/service_cubit.dart` and `lib/features/service/presentation/cubit/service_state.dart`.
2.  Updated `lib/core/services/service_locator.dart` to provide the `ServiceCubit`.
3.  Updated `lib/main.dart` to use the `ServiceCubit`.
4.  Updated the following screens to use the `ServiceCubit`:
    *   `lib/features/service/presentation/views/all_services_screen.dart`
    *   `lib/features/service/presentation/views/create_service_screen.dart`
    *   `lib/features/service/presentation/views/edit_service_screen.dart`
    *   `lib/features/service/presentation/views/service_details_screen.dart`
    *   `lib/features/service/presentation/views/services_screen.dart`
5.  Deleted `lib/features/service/presentation/bloc/service_bloc.dart` and `lib/features/service/presentation/bloc/service_event.dart`.
