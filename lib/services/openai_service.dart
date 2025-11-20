import 'dart:convert';
import 'package:http/http.dart' as http;

/// A minimal OpenAI service wrapper. Replace `OPENAI_API_KEY` with your key or
/// set it in environment / secret manager for production.
///
/// NOTE: This makes a direct HTTP call to OpenAI's Chat Completions endpoint.
/// Be careful not to embed your key in a production mobile app; route requests
/// through a server in real deployments.
class OpenAIService {
  final String apiKey;

  OpenAIService({String? apiKey}) : apiKey = apiKey ?? 'YOUR_OPENAI_API_KEY_HERE';

  Future<String> explainConcept(String prompt) async {
    if (apiKey == 'YOUR_OPENAI_API_KEY_HERE') {
      // fallback local explanation for demo
      return 'Demo mode: pretend this is an AI explanation for "\$prompt". To enable real AI, set your OpenAI API key in OpenAIService.';
    }

    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    final body = jsonEncode({
      "model": "gpt-4o-mini",
      "messages": [
        {"role":"system","content":"You are a helpful concise tutor for Kenyan students preparing for KCSE/KCPE."},
        {"role":"user","content": prompt}
      ],
      "max_tokens": 400,
      "temperature": 0.6
    });

    final resp = await http.post(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer \$apiKey'
    }, body: body);

    if (resp.statusCode >= 200 && resp.statusCode < 300) {
      final j = jsonDecode(resp.body);
      final text = j['choices']?[0]?['message']?['content'] ?? '';
      return text;
    } else {
      throw Exception('OpenAI error: \${resp.statusCode} - \${resp.body}');
    }
  }
}
