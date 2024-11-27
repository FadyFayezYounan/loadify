import 'package:flutter/material.dart' show OverlayEntry;
import 'package:flutter/scheduler.dart' show SchedulerBinding, SchedulerPhase;
import 'package:flutter/widgets.dart';

/// A specialized [OverlayEntry] that provides safe rebuilding mechanisms.
///
/// [LoadifyOverlayEntry] extends the standard [OverlayEntry] with improved
/// build scheduling to prevent potential rendering issues during critical
/// rendering phases.
///
/// ## Key Features
/// - Safely schedules rebuilds during Flutter's rendering lifecycle
/// - Prevents potential frame-related rendering conflicts
/// - Ensures smooth updates to overlay entries
///
/// ### Rendering Safety
/// The class overrides [markNeedsBuild()] to handle scenarios where
/// rebuild requests occur during sensitive rendering phases.
///
/// ### Use Cases
/// - Global loading indicators
/// - Dynamic overlay management
/// - Rendering-safe widget updates
///
/// ### Technical Details
/// When a rebuild is requested during the persistent callbacks phase,
/// the rebuild is deferred to the next frame, preventing potential
/// rendering conflicts.
///
/// Example:
/// ```dart
/// LoadifyOverlayEntry overlayEntry = LoadifyOverlayEntry(
///   builder: (context) => LoadingIndicator(),
/// );
/// ```
///
/// @see [OverlayEntry]
/// @see [SchedulerBinding]
class LoadifyOverlayEntry extends OverlayEntry {
  /// Creates a [LoadifyOverlayEntry] with a required builder function.
  ///
  /// [builder] defines the widget to be rendered in the overlay.
  ///
  /// Inherits all properties from [OverlayEntry]
  LoadifyOverlayEntry({required super.builder});

  /// Safely marks the overlay entry as needing a rebuild.
  ///
  /// This method provides a safe rebuilding mechanism by:
  /// - Checking the current scheduler phase
  /// - Deferring rebuild if in a sensitive rendering phase
  /// - Immediately rebuilding if outside of critical phases
  ///
  /// ### Rendering Phase Handling
  /// - During [SchedulerPhase.persistentCallbacks], defers rebuild
  /// - In other phases, performs immediate rebuild
  ///
  /// @param None
  /// @returns void
  @override
  void markNeedsBuild() {
    // Get the current scheduler binding
    final binding = SchedulerBinding.instance;

    // Check if we're in a critical rendering phase
    if (binding.schedulerPhase == SchedulerPhase.persistentCallbacks) {
      // Defer rebuild to the next frame to prevent rendering conflicts
      binding.addPostFrameCallback((_) {
        super.markNeedsBuild();
      });
    } else {
      // Perform immediate rebuild if not in a critical phase
      super.markNeedsBuild();
    }
  }
}
