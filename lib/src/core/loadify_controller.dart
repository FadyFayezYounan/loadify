import 'package:flutter/material.dart';

import '../enums/enums.exports.dart';
import '../utils/utils.exports.dart';
import '../widgets/widgets.exports.dart';

/// A singleton controller class for managing the Loadify loading indicator.
///
/// The `LoadifyController` class provides methods to update and manage the
/// loading indicator widget, loading status, and overlay entry. It ensures
/// that only one instance of the controller exists throughout the application.
///
/// Usage:
/// ```dart
/// final loadifyController = LoadifyController();
/// ```
///
/// Methods:
/// - `updateIndicatorWidget(Widget? widget)`: Updates the loading indicator widget.
/// - `onStatusChanged(LoadifyLoadingStatusCallback callback)`: Registers a callback to be called when the loading status changes.
/// - `updateStatus(LoadifyStatus status)`: Updates the loading status and calls the registered callback.
/// - `initEntry(LoadifyOverlayEntry? entry)`: Initializes the overlay entry for the loading indicator.
/// - `refresh()`: Refreshes the overlay entry and asserts that Loadify is initialized.
///
/// Properties:
/// - `indicatorWidget`: Gets the current loading indicator widget.
/// - `loadifyStatus`: Gets the current loading status.

final class LoadifyController {
  static LoadifyController? _instance;

  LoadifyController._internal();

  factory LoadifyController() {
    _instance ??= LoadifyController._internal();
    return _instance!;
  }

  Widget? _indicatorWidget;
  Widget? get indicatorWidget => _indicatorWidget;
  void updateIndicatorWidget(Widget? widget) {
    _indicatorWidget = widget;
  }

  LoadifyStatus? _loadifyStatus;
  LoadifyStatus? get loadifyStatus => _loadifyStatus;
  LoadifyLoadingStatusCallback? _loadifyLoadingStatusCallback;
  void onStatusChanged(LoadifyLoadingStatusCallback callback) {
    _loadifyLoadingStatusCallback = callback;
  }

  void updateStatus(LoadifyStatus status) {
    _loadifyStatus = status;
    _loadifyLoadingStatusCallback?.call(status);
  }

  LoadifyOverlayEntry? _loadifyOverlayEntry;

  void initEntry(LoadifyOverlayEntry? entry) {
    _loadifyOverlayEntry = entry;
  }

  void refresh() {
    assert(
      _loadifyOverlayEntry != null,
      '''Loadify is not initialized. 
    Please make sure to call Loadify.initialize() before using Loadify.show() or Loadify.hide()
    in your MaterialApp builder method.
    e.g. MaterialApp(
      builder: Loadify.initialize(),
    ),
    ''',
    );
    _loadifyOverlayEntry?.markNeedsBuild();
  }
}
