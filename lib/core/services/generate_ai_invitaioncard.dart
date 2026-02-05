import 'dart:convert';

import 'package:event_sense_ai/utils/app_url/base_url.dart';
import 'package:http/http.dart' as http;

class InvitationCardDesign {
  String buildInvitationPrompt({
    required String eventName,
    required String hostName,
    required String location,
    required String date,
    required String time,
    required String style,
    required String rsvpLink,
  }) {
    return '''
              Create a high-resolution, realistic event invitation card.
              
              Style: $style
              Orientation: Vertical
              Paper texture: Premium invitation paper
              Lighting: Soft natural shadows
              Design quality: Ultra HD, professional print
              
              IMPORTANT TEXT (do not modify text):
              "$eventName
              
              Hosted by $hostName
              
              $date at $time
              Location: $location
              
              RSVP:
              $rsvpLink"
              
              Rules:
              - All text must be readable
              - Elegant typography
              - Center aligned text
              - No spelling changes
              - No extra text
              ''';
                }

  Future<String> generateInvitationImage({
    required String eventName,
    required String hostName,
    required String location,
    required String date,
    required String time,
    required String style,
    required String rsvpLink,
  }) async {
    try {
      final prompt = buildInvitationPrompt(
        eventName: eventName,
        hostName: hostName,
        location: location,
        date: date,
        time: time,
        style: style,
        rsvpLink: rsvpLink,
      );

      final response = await http.post(
        Uri.parse("${BaseUrl.baseUrl}images/generations"),
        headers: {
          "Authorization": "Bearer ${BaseUrl.apiKey}",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "prompt": prompt,
          "n": 1,
          "size": "1024x1024",
          "model": "dall-e-3",
        }),
      ).timeout(const Duration(seconds: 90));

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode != 200) {
        final errorData = jsonDecode(response.body);
        final errorMessage = errorData["error"]?["message"] ?? "AI generation failed";
        throw Exception(errorMessage);
      }

      final data = jsonDecode(response.body);

      // OpenAI DALL-E 3 response format: data[0].url
      if (data["data"] == null || data["data"].isEmpty || data["data"][0]["url"] == null) {
        throw Exception("Invalid AI response: Image URL not found");
      }

      return data["data"][0]["url"];
    } catch (e) {
      print("Error generating invitation: $e");
      rethrow;
    }
  }
}
