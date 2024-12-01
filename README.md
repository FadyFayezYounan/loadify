# Loadify

Loadify is a simple and flexible loading indicator management package for Flutter applications. It provides an easy-to-use API for showing and hiding loading indicators across your app with minimal boilerplate code.

## Features

- 🚀 Simple global loading management
- 🎨 Customizable loading indicator
- 📦 Minimal setup required
- 🔄 Easy status tracking and callbacks

## Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  loadify: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## Quick Start

### 1. Initialize Loadify in your App

In your main app widget or `MaterialApp`:

```dart
MaterialApp(
  builder: Loadify.initialize(),
  // ... other properties
)
```

### 2. Show Loading Indicator

```dart
// Simple loading
Loadify.show();

// Custom loading indicator
Loadify.show(
  builder: (context) => CustomLoadingWidget(),
  backgroundColor: Colors.black54,
);
```

### 3. Hide Loading Indicator

```dart
Loadify.hide();
```

### 4. Track Loading Status (Optional)

```dart

void listener(LoadifyStatus status) {
  if (status == LoadifyStatus.loading) {
    // Loading started
  } else {
    // Loading completed
  }
}
Loadify.addStatusListener(listener);

// Don't forget to remove the listener when no longer needed
Loadify.removeStatusListener(listener);
```

### 5. LoadifyPopScope: Preventing Back Button

Wrap your scaffold with `LoadifyPopScope` to prevent the back from dismissing current screen when loading.

```dart
LoadifyPopScope(
  child: Scaffold(
    // Your content
  ),
);
```

## Customization

### Custom Loading Indicator

You can provide a custom loading widget when showing the loader:

```dart
Loadify.show(
  builder: (context) => SpinKitCubeGrid(
    color: Colors.blue,
    size: 50.0,
  ),
);
```

### Background Color

Customize the background color of the loading overlay:

```dart
Loadify.show(
  backgroundColor: Colors.white.withOpacity(0.7),
);
```

## API Reference

### Methods

- `Loadify.initialize()`: Initialize Loadify in your app
- `Loadify.show()`: Display loading indicator
- `Loadify.hide()`: Dismiss loading indicator
- `Loadify.addStatusListener()`: Listen to loading status changes
- `Loadify.removeStatusListener()`: Remove status listener
- `Loadify.clearStatusListeners()`: Remove all status listeners
-

### Loading Status

- `LoadifyStatus.idle`: No loading in progress
- `LoadifyStatus.loading`: Loading in progress

## Best Practices

- Always call `Loadify.hide()` when your async operation completes
- Use custom builders to match your app's design

## Example

```dart
void fetchData() async {
  try {
    Loadify.show();
    // Your async operation
    final result = await apiCall();
    // Process result
  } catch (e) {
    // Handle error
  } finally {
    Loadify.hide();
  }
}
```

## Troubleshooting

- Ensure `Loadify.initialize()` is called in the app's builder
- Check that you're calling `hide()` in all scenarios (success, error)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
