import 'package:flutter/material.dart';

import '../core/core.exports.dart';
import 'loadify_overlay_entry.dart';

class LoadifyBuilder extends StatefulWidget {
  /// A widget that manages the global loading overlay for the entire application.
  ///
  /// The [LoadifyBuilder] creates an [Overlay] that allows displaying a loading
  /// indicator globally across the app without needing to modify each individual screen.
  ///
  /// Key Responsibilities:
  /// - Creates a global overlay for loading indicators
  /// - Manages the insertion of loading indicators into the widget tree
  /// - Provides a flexible mechanism for showing and hiding loading states
  ///
  /// Usage Example:
  /// ```dart
  /// MaterialApp(
  ///   builder: Loadify.initialize(), // Uses LoadifyBuilder internally
  ///   home: MyHomePage(),
  /// )
  /// ```
  ///
  /// ## How It Works
  /// 1. Initializes a [LoadifyOverlayEntry] for the loading indicator
  /// 2. Embeds the loading indicator in an [Overlay]
  /// 3. Allows dynamic showing/hiding of the loading indicator
  ///
  /// ## Design Considerations
  /// - Wraps child widget in [Material] for consistent theming
  /// - Uses [Overlay] to render loading indicator above other widgets
  /// - Supports optional child widget
  const LoadifyBuilder({
    super.key,
    required this.child,
  });

  /// The widget to be displayed beneath the loading overlay.
  final Widget? child;

  @override
  State<LoadifyBuilder> createState() => _LoadifyBuilderState();
}

class _LoadifyBuilderState extends State<LoadifyBuilder> {
  /// Stores the overlay entry for the loading indicator.
  ///
  /// This entry can be dynamically updated and removed based on loading state.
  late final LoadifyOverlayEntry? _loadifyOverlayEntry;

  @override
  void initState() {
    super.initState();

    // Create an overlay entry for the loading indicator
    // Uses the current indicator from LoadifyController or a shrink box
    _loadifyOverlayEntry = LoadifyOverlayEntry(
      builder: (context) =>
          LoadifyController().indicatorWidget ?? const SizedBox.shrink(),
    );

    // Initialize the overlay entry in the controller
    LoadifyController().initEntry(_loadifyOverlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      // Wrap in Material for consistent theming
      child: Overlay(
        // Create an overlay with two entries:
        // 1. The main child widget
        // 2. The loading indicator (if available)
        initialEntries: [
          LoadifyOverlayEntry(
            builder: (context) => widget.child ?? const SizedBox.shrink(),
          ),
          if (_loadifyOverlayEntry != null) _loadifyOverlayEntry,
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Clean up overlay entry to prevent memory leaks
    _loadifyOverlayEntry?.remove();
    _loadifyOverlayEntry?.dispose();
    _loadifyOverlayEntry = null;
    super.dispose();
  }
}
