import 'package:flutter/material.dart' show BuildContext, Widget;

import '../enums/enums.exports.dart';

/// Callback function for overlay initialization
typedef LoadifyInitializationCallBack = Widget Function(
  BuildContext context,
  Widget? child,
);

/// Callback for overlay loading status.
typedef LoadifyLoadingStatusCallback = void Function(
  LoadifyStatus loadingStatus,
);
