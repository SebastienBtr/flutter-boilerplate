// Check if the app is in debug mode
bool get isInDebugMode {
  // Assume you're in production mode.
  bool inDebugMode = false;

  // Assert expressions are only evaluated during development. They are ignored
  // in production. Therefore, this code only sets `inDebugMode` to true
  // in a development environment.
  assert(inDebugMode = true);

  return inDebugMode;
}

// Return true if the String given is a numeric value
// False otherwise
bool isNumeric(String value) {
  if (value == null || value == '') {
    return false;
  }
  return double.tryParse(value) != null;
}
