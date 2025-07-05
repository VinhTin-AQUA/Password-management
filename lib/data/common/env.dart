import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static final String discordWebhookUrlKey = "DISCORD_WEBHOOK_URL";

    static Future<void> init() async {
      await dotenv.load(fileName: ".env");
    }

  static Future<String? > getdiscordWebhookUrl() async {
    await dotenv.load(fileName: ".env");
    var discordWebhookUrl = dotenv.env["DISCORD_WEBHOOK_URL"];
    return discordWebhookUrl;
  }
}
