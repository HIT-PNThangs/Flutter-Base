import 'dart:async';

import 'package:http/http.dart';

import 'exceptions/fatal_failure_exception.dart';
import 'exceptions/http_client_closed.dart';
import 'exceptions/request_limit_exceeded_exception.dart';
import 'exceptions/search_item_section_exception.dart';
import 'exceptions/transient_failure_exception.dart';
import 'reverse_engineering/youtube_http_client.dart';

/// Run the [function] each time an exception is thrown until the retryCount
/// is 0.
Future<T> retry<T>(YoutubeHttpClient? client, FutureOr<T> Function() function) async {
  var retryCount = 5;

  // ignore: literal_only_boolean_expressions
  while (true) {
    try {
      return await function();
      // ignore: avoid_catches_without_on_clauses
    } on Exception catch (e) {
      if (client != null && client.closed) {
        throw HttpClientClosedException();
      }

      retryCount -= getExceptionCost(e);
      if (retryCount <= 0) {
        rethrow;
      }
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }
}

/// Get "retry" cost of each YoutubeExplode exception.
int getExceptionCost(Exception e) {
  if (e is TransientFailureException || e is FormatException || e is SearchItemSectionException || e is ClientException) {
    return 1;
  }

  if (e is RequestLimitExceededException) {
    return 2;
  }

  if (e is FatalFailureException) {
    return 3;
  }

  return 100;
}
