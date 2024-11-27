/// An enumeration representing the status of a loading operation.
///
/// The `LoadifyStatus` enum has two possible values:
/// - `loading`: Indicates that a loading operation is currently in progress.
/// - `idle`: Indicates that no loading operation is currently in progress.
///
/// This enum also provides two convenience getters:
/// - `isLoading`: Returns `true` if the status is `loading`, otherwise `false`.
/// - `isIdle`: Returns `true` if the status is `idle`, otherwise `false`.
enum LoadifyStatus {
  loading,
  idle;

  bool get isLoading => this == LoadifyStatus.loading;
  bool get isIdle => this == LoadifyStatus.idle;
}
