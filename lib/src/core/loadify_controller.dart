import 'package:flutter/material.dart';

import '../enums/enums.exports.dart';
import '../utils/utils.exports.dart';
import '../widgets/widgets.exports.dart';

/// A singleton controller class for managing the Loadify loading indicator and its callbacks.
///
/// The `LoadifyController` class provides methods to update the loading indicator widget,
/// manage status callbacks, and refresh the overlay entry.
///
/// Usage:
/// ```dart
/// final loadifyController = LoadifyController();
/// ```
///
/// Methods:
/// - `LoadifyController()` - Factory constructor to get the singleton instance.
/// - `updateIndicatorWidget(Widget? widget)` - Updates the loading indicator widget.
/// - `addStatusCallback(LoadifyLoadingStatusCallback callback)` - Adds a status callback.
/// - `removeStatusCallback(LoadifyLoadingStatusCallback callback)` - Removes a status callback.
/// - `clearStatusCallbacks()` - Clears all status callbacks.
/// - `updateCallbacks(LoadifyStatus status)` - Updates all registered callbacks with the given status.
/// - `initEntry(LoadifyOverlayEntry? entry)` - Initializes the overlay entry.
/// - `refresh()` - Refreshes the overlay entry and asserts if it is not initialized.
///
/// Properties:
/// - `indicatorWidget` - Gets the current loading indicator widget.

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

  final Set<LoadifyLoadingStatusCallback> _loadifyStatusCallbacks = {};
  void addStatusCallback(LoadifyLoadingStatusCallback callback) {
    _loadifyStatusCallbacks.add(callback);
  }

  void removeStatusCallback(LoadifyLoadingStatusCallback callback) {
    _loadifyStatusCallbacks.remove(callback);
  }

  void clearStatusCallbacks() {
    _loadifyStatusCallbacks.clear();
  }

  void updateCallbacks(LoadifyStatus status) {
    for (var callback in _loadifyStatusCallbacks) {
      callback(status);
    }
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
