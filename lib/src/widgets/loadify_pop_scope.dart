import 'package:flutter/material.dart';
import '../../loadify.dart';

class LoadifyPopScope extends StatefulWidget {
  /// A widget that wraps another widget and controls whether the wrapped widget
  /// can be popped based on the loading status.
  ///
  /// The [LoadifyPopScope] listens to the loading status changes from the
  /// `Loadify` class and updates its internal state accordingly. When the
  /// loading status is active, the wrapped widget cannot be popped. When the
  /// loading status is inactive, the wrapped widget can be popped.
  ///
  /// The [child] parameter is the widget that will be wrapped by the
  /// [LoadifyPopScope].
  ///
  /// Example usage:
  /// ```dart
  /// LoadifyPopScope(
  ///   child: YourWidget(),
  /// );
  /// ```
  const LoadifyPopScope({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  State<LoadifyPopScope> createState() => _LoadifyPopScopeState();
}

class _LoadifyPopScopeState extends State<LoadifyPopScope> {
  late final ValueNotifier<bool> _loadingNotifier;

  @override
  void initState() {
    super.initState();
    _loadingNotifier = ValueNotifier<bool>(false);
    Loadify.onStatusChanged(_statusCallback);
  }

  @override
  void dispose() {
    _loadingNotifier.dispose();
    super.dispose();
  }

  void _statusCallback(LoadifyStatus status) {
    if (status.isLoading) {
      _loadingNotifier.value = true;
    } else {
      _loadingNotifier.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _loadingNotifier,
      builder: (context, isLoading, child) => PopScope(
        canPop: isLoading == false,
        child: child!,
      ),
      child: widget.child,
    );
  }
}
