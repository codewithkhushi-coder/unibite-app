import 'package:equatable/equatable.dart';

enum AIActionType {
  autoReorder,
  smartCombo,
  mealRoutine,
  vendorSubstitute
}

class AIActionModel extends Equatable {
  final String id;
  final String userId;
  final AIActionType type;
  final Map<String, dynamic> payload; // Holds the NLP parsed query or scheduled trigger rules
  final DateTime? scheduledFor;
  final bool isExecuted;

  const AIActionModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.payload,
    this.scheduledFor,
    this.isExecuted = false,
  });

  factory AIActionModel.fromJson(Map<String, dynamic> json) {
    return AIActionModel(
      id: json['id'],
      userId: json['user_id'],
      type: AIActionType.values.firstWhere((e) => e.toString().split('.').last == json['action_type']),
      payload: json['payload'],
      scheduledFor: json['scheduled_for'] != null ? DateTime.parse(json['scheduled_for']) : null,
      isExecuted: json['is_executed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'action_type': type.toString().split('.').last,
      'payload': payload,
      'scheduled_for': scheduledFor?.toIso8601String(),
      'is_executed': isExecuted,
    };
  }

  @override
  List<Object?> get props => [id, userId, type, payload, scheduledFor, isExecuted];
}
