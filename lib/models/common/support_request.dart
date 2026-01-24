import 'package:equatable/equatable.dart';
import 'package:bdoneapp/models/common/project.dart';

enum RequestPriorityEnum {
  low('low'),
  medium('medium'),
  high('high'),
  critical('critical');

  final String value;
  const RequestPriorityEnum(this.value);

  static RequestPriorityEnum fromString(String value) {
    return RequestPriorityEnum.values.firstWhere(
      (e) => e.value == value,
      orElse: () => RequestPriorityEnum.low,
    );
  }
}

class SupportRequest extends Equatable {
  final String id;
  final String ticketNumber;
  final String subject;
  final String description;
  final RequestPriorityEnum priority;
  final String status;
  final String? projectId;
  final String? clientId;
  final Project? project;
  final DateTime createdAt;
  final String createdBy;

  const SupportRequest({
    required this.id,
    required this.ticketNumber,
    required this.subject,
    required this.description,
    required this.priority,
    required this.status,
    this.projectId,
    this.clientId,
    this.project,
    required this.createdAt,
    required this.createdBy,
  });

  factory SupportRequest.fromJson(Map<String, dynamic> json) {
    return SupportRequest(
      id: json['_id'] ?? '',
      ticketNumber: json['ticketNumber'] ?? '',
      subject: json['subject'] ?? '',
      description: json['description'] ?? '',
      priority: RequestPriorityEnum.fromString(json['priority'] ?? 'low'),
      status: json['status'] ?? 'OPEN',
      projectId: json['projectId'],
      clientId: json['clientId'],
      project: json['project'] != null && json['project'] is Map
          ? Project.fromJson(json['project'])
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      createdBy: json['createdBy'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'ticketNumber': ticketNumber,
      'subject': subject,
      'description': description,
      'priority': priority.value,
      'status': status,
      'projectId': projectId,
      'clientId': clientId,
      'project': project?.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'createdBy': createdBy,
    };
  }

  @override
  List<Object?> get props => [
        id,
        ticketNumber,
        subject,
        description,
        priority,
        status,
        projectId,
        clientId,
        project,
        createdAt,
        createdBy,
      ];
}
