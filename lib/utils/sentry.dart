import 'package:flutter_boilerplate/blocs/mainBloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sentry/sentry.dart';

import 'helpers.dart';

// Sentry client, we use sentry.io to report errors
final SentryClient _sentry = SentryClient(dsn: DotEnv().env['SENTRY_APP_DSN']);

// Report an error in the console if we are in debug mode
// Otherwise report it to sentry
Future<void> reportError(dynamic error, dynamic stackTrace) async {
  // Print the exception to the console.
  mainBloc.logger.e('Caught error: $error');
  if (isInDebugMode) {
    // Print the full stacktrace to the console in debug mode.
    mainBloc.logger.d(stackTrace);
    return;
  } else {
    // Send the Exception and Stacktrace to Sentry in Production mode.
    _sentry.captureException(
      exception: error,
      stackTrace: stackTrace,
    );
  }
}