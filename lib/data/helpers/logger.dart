import 'dart:isolate';

import 'package:password_management/data/common/env.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Logger {
  static Future<void> reportError(Object error, StackTrace? stackTrace) async {
    try {
      var discordWebhookUrl = await Env.getdiscordWebhookUrl();
      await Isolate.run(() async {
        final String errorMessage = error.toString();
        final String stack = stackTrace?.toString() ?? 'No stack trace';

        final Map<String, dynamic> payload = {
          'content':
              '**Error**\n'
              '```$errorMessage```\n' 
              '**Stacktrace:**\n'
              '```$stack```',
        };
        await http.post(
          Uri.parse(discordWebhookUrl!),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(payload),
        );
      });
    } catch (e) {
      // print(e);
      //
    }
  }
}
