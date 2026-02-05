import 'dart:convert';
import 'package:event_sense_ai/core/constant/app_const.dart';
import 'package:event_sense_ai/utils/app_url/base_url.dart';
import 'package:http/http.dart' as http;

class AiBlueprintService {
  static Future<Map<String, dynamic>> generateBlueprint({
    required String eventType,
    required double  budget,
    required String date,
    required String city,
  }) async {
    final response = await http.post(
      Uri.parse(AppConst.endpoint),
      headers: {
        "Authorization": "Bearer ${BaseUrl.apiKey}",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "model": "gpt-4o-mini",
        "messages": [
          {
            "role": "system",
            "content": """
                You are an event planning AI.
                
                CRITICAL RULES:
                - You MUST return ONLY valid JSON.
                - DO NOT include markdown, comments, or explanations.
                - The SUM of all category "estimated_budget" values MUST be LESS THAN OR EQUAL TO the provided total budget.
                - Prefer the total to be VERY CLOSE to the provided budget, but NEVER exceed it.
                """,
          },
          {
            "role": "user",
            "content":
                """
            Generate an event blueprint as a JSON object.

            Event Details:
            - Event Type: $eventType
            - Total Budget: $budget
            - Date: $date
            - City: $city
            
            BUDGET CONSTRAINTS:
            - The total of all category budgets MUST be <= $budget
            - Distribute budget realistically across categories.
            - Do NOT exceed the total budget.
            
            The JSON object MUST contain EXACTLY these keys:
            1. "categories": array of objects with:
               - "name": string
               - "estimated_budget": number
            2. "vendor_categories": array of strings
            3. "timeline": array of objects with:
               - "title": string
               - "days_before": number
            """,
                      },
                    ],
                    "response_format": {"type": "json_object"},
                    "temperature": 0.2,
                  }),
                );

    final decoded = jsonDecode(response.body);

    if (decoded["error"] != null) {
      throw Exception("AI API Error: ${decoded["error"]["message"]}");
    }

    if (decoded["choices"] == null || decoded["choices"].isEmpty) {
      throw Exception("Invalid AI response: 'choices' field is missing or empty.");
    }

    String content = decoded["choices"][0]["message"]["content"] ?? "";

    if (content.isEmpty) {
      throw Exception("Invalid AI response: 'message content' is empty.");
    }

    // Clean Markdown code blocks if present
    if (content.contains("```json")) {
      content = content.split("```json")[1].split("```")[0];
    } else if (content.contains("```")) {
      content = content.split("```")[1].split("```")[0];
    }

    return jsonDecode(content.trim());
  }
}
