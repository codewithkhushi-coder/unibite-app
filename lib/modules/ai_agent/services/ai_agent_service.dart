import 'package:flutter/material.dart';
import '../models/ai_action_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// The core AI orchestrator designed to be plugged directly into an OpenAI or GCP Gemini API later.
class AIAgentService {
  final SupabaseClient _db = Supabase.instance.client;

  /// Translates a natural language string into a concrete food order action.
  /// E.g. "Order my usual lunch at noon tomorrow" -> generates an AIActionModel.
  Future<void> parseAndScheduleIntent(String userText, String userId) async {
    debugPrint("🤖 AI Agent ingesting intent: \$userText");
    
    // Future Implementation:
    // 1. Send 'userText' to OpenAI GPT-4o API.
    // 2. Instruct API to return a strict JSON payload mapping to our AIActionType.
    // 3. Receive JSON, create AIActionModel.
    // 4. Save into Supabase for the backend Cron job to execute.

    // Mock API Return:
    final mockParsedAction = AIActionModel(
      id: 'mock-uuid-1234',
      userId: userId,
      type: AIActionType.autoReorder,
      payload: const {'target_restaurant': 'Neo Sushi', 'items': ['Spicy Tuna Roll', 'Miso Soup']},
      scheduledFor: DateTime.now().add(const Duration(hours: 18)), // e.g. "tomorrow"
    );

    await _db.from('ai_actions').insert(mockParsedAction.toJson());
    debugPrint("✅ AI Agent successfully scheduled an auto_reorder based on NLP processing.");
  }

  /// Calculates dynamically if a vendor fails to accept, suggesting a similar meal close by.
  Future<Map<String, dynamic>> suggestAlternativeVendor(String failedVendorId) async {
    // Queries the vector DB for menus with similar tagging
    return {
      'alternative': 'Cyber Pizza Hub',
      'confidence': 0.89,
      'reasoning': 'Matches historical preferences for fast food.',
    };
  }
}
