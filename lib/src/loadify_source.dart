import 'package:flutter/material.dart';

import 'package:loadify/src/widgets/indicator_wrapper.dart';

import 'core/core.exports.dart';
import 'enums/enums.exports.dart';
import 'utils/utils.exports.dart';
import 'widgets/loadify_builder.dart';

/// A utility class for managing global loading indicators across a Flutter application.
///
/// [Loadify] provides a simple, static interface for showing and hiding
/// loading indicators with minimal configuration. It acts as a centralized
/// loading state management solution.
///
/// ## Key Features
/// - Global loading indicator management
/// - Easy initialization and usage
/// - Customizable loading appearance
/// - Status tracking and callbacks
///
/// ## Usage Examples
///
/// ### Basic Initialization
/// ```dart
/// MaterialApp(
///   builder: Loadify.initialize(),
///   home: MyHomePage(),
/// )
/// ```
///
/// ### Showing and Hiding Loading
/// ```dart
/// // Show loading
/// Loadify.show();
///
/// // Custom loading indicator
/// Loadify.show(
///   builder: (context) => CustomLoadingWidget(),
///   backgroundColor: Colors.black54,
/// );
///
/// // Hide loading
/// Loadify.hide();
/// ```
///
/// ### Status Change Tracking
/// ```dart
/// Loadify.onStatusChanged((status) {
///   print('Loading status: $status');
/// });
/// ```
///
/// ## Design Principles
/// - Provides a singleton-like interface for loading management
/// - Minimizes boilerplate code for showing/hiding loaders
/// - Supports custom loading indicator designs
///
/// @see [LoadifyController]
/// @see [LoadifyBuilder]
/// @see [LoadifyStatus]
abstract final class Loadify {
  /// Private constructor to prevent instantiation.
  ///
  /// [Loadify] is a static utility class and should not be instantiated.
  const Loadify._();

  /// Internal controller managing the loading state.
  ///
  /// Provides core functionality for loading indicator management.
  static final LoadifyController _controller = LoadifyController();

  /// Initializes the Loadify system for use in a Flutter application.
  ///
  /// [builder] Optional custom initialization builder that wraps the [LoadifyBuilder].
  ///
  /// Returns a builder function compatible with MaterialApp's builder parameter.
  ///
  /// ### Parameters
  /// - [builder]: Optional custom initialization callback
  ///
  /// ### Returns
  /// A function that creates a [LoadifyBuilder] with optional customization
  static LoadifyInitializationCallBack initialize({
    LoadifyInitializationCallBack? builder,
  }) {
    return (BuildContext context, Widget? child) {
      if (builder != null) {
        return builder(context, LoadifyBuilder(child: child));
      } else {
        return LoadifyBuilder(child: child);
      }
    };
  }

  /// Registers a callback to be invoked when the loading status changes.
  ///
  /// [callback] Function to be called with the new loading status
  ///
  /// ### Usage
  /// ```dart
  /// Loadify.onStatusChanged((status) {
  ///   // React to loading status changes
  /// });
  /// ```
  static void onStatusChanged(LoadifyLoadingStatusCallback callback) {
    _controller.onStatusChanged(callback);
  }

  /// Shows the loading indicator with optional customization.
  ///
  /// [builder] Optional custom widget builder for the loading indicator
  /// [backgroundColor] Background color of the loading overlay
  ///
  /// ### Parameters
  /// - [builder]: Custom loading indicator widget builder
  /// - [backgroundColor]: Overlay background color, defaults to semi-transparent black
  ///
  /// ### Example
  /// ```dart
  /// Loadify.show(
  ///   builder: (context) => CustomSpinner(),
  ///   backgroundColor: Colors.white60,
  /// );
  /// ```
  static void show({
    WidgetBuilder? builder,
    Color backgroundColor = Colors.black26,
  }) {
    _controller
      ..updateIndicatorWidget(IndicatorWrapper(
        builder: builder,
        backgroundColor: backgroundColor,
      ))
      ..updateStatus(LoadifyStatus.loading)
      ..refresh();
  }

  /// Hides the currently displayed loading indicator.
  ///
  /// Resets the loading status to idle and removes the loading overlay.
  ///
  /// ### Usage
  /// ```dart
  /// Loadify.hide(); // Dismisses the loading indicator
  /// ```
  static void hide() {
    _controller
      ..updateIndicatorWidget(null)
      ..updateStatus(LoadifyStatus.idle)
      ..refresh();
  }
}
