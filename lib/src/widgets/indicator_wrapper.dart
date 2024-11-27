import 'package:flutter/material.dart';

class IndicatorWrapper extends StatelessWidget {
  /// A widget that wraps another widget with a modal barrier and an optional
  /// loading indicator.
  ///
  /// The [IndicatorWrapper] displays a [ModalBarrier] with a specified
  /// [backgroundColor] and a child widget built using the provided [builder].
  /// If the [builder] is null, a [CircularProgressIndicator] is displayed
  /// at the center of the screen.
  ///
  /// The [IndicatorWrapper] is useful for displaying a loading indicator
  /// while preventing user interaction with the underlying content.
  ///
  /// {@tool snippet}
  /// ```dart
  /// IndicatorWrapper(
  ///   backgroundColor: Colors.black54,
  ///   builder: (context) => MyCustomWidget(),
  /// )
  /// ```
  /// {@end-tool}
  ///
  /// See also:
  ///  * [ModalBarrier], which is used to create the barrier.
  ///  * [CircularProgressIndicator], which is used as the default loading indicator.
  const IndicatorWrapper({
    super.key,
    required this.builder,
    required this.backgroundColor,
  });
  final WidgetBuilder? builder;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ModalBarrier(
          color: backgroundColor,
          dismissible: false,
          semanticsLabel: 'IndicatorWrapper',
        ),
        builder?.call(context) ??
            const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
      ],
    );
  }
}
