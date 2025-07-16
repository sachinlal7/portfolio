// lib/app/data/models/project_model.dart
class ProjectModel {
  final String title;
  final String description;
  final List<String> technologies;
  final String category;
  final String imageUrl;
  final String? githubUrl;
  final String? liveUrl;
  final List<String> features;
  final DateTime? completedDate;
  final bool isFeatured;

  ProjectModel({
    required this.title,
    required this.description,
    required this.technologies,
    required this.category,
    required this.imageUrl,
    this.githubUrl,
    this.liveUrl,
    this.features = const [],
    this.completedDate,
    this.isFeatured = false,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      technologies: List<String>.from(json['technologies'] ?? []),
      category: json['category'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      githubUrl: json['githubUrl'],
      liveUrl: json['liveUrl'],
      features: List<String>.from(json['features'] ?? []),
      completedDate: json['completedDate'] != null
          ? DateTime.parse(json['completedDate'])
          : null,
      isFeatured: json['isFeatured'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'technologies': technologies,
      'category': category,
      'imageUrl': imageUrl,
      'githubUrl': githubUrl,
      'liveUrl': liveUrl,
      'features': features,
      'completedDate': completedDate?.toIso8601String(),
      'isFeatured': isFeatured,
    };
  }
}

// =====================================
// lib/app/data/models/skill_model.dart
// =====================================

class SkillModel {
  final String name;
  final int level; // 0-100
  final String category;
  final String? description;
  final List<String> subSkills;
  final int yearsOfExperience;

  SkillModel({
    required this.name,
    required this.level,
    required this.category,
    this.description,
    this.subSkills = const [],
    this.yearsOfExperience = 0,
  });

  factory SkillModel.fromJson(Map<String, dynamic> json) {
    return SkillModel(
      name: json['name'] ?? '',
      level: json['level'] ?? 0,
      category: json['category'] ?? '',
      description: json['description'],
      subSkills: List<String>.from(json['subSkills'] ?? []),
      yearsOfExperience: json['yearsOfExperience'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'level': level,
      'category': category,
      'description': description,
      'subSkills': subSkills,
      'yearsOfExperience': yearsOfExperience,
    };
  }

  String get levelDescription {
    if (level >= 90) return 'Expert';
    if (level >= 80) return 'Advanced';
    if (level >= 70) return 'Intermediate';
    if (level >= 50) return 'Beginner';
    return 'Learning';
  }
}

// =====================================
// lib/app/data/models/experience_model.dart
// =====================================

class ExperienceModel {
  final String title;
  final String company;
  final String location;
  final String duration;
  final String description;
  final List<String> responsibilities;
  final List<String> technologies;
  final String type; // Full-time, Part-time, Contract, Freelance
  final bool isCurrentJob;

  ExperienceModel({
    required this.title,
    required this.company,
    required this.location,
    required this.duration,
    required this.description,
    required this.responsibilities,
    required this.technologies,
    required this.type,
    this.isCurrentJob = false,
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      title: json['title'] ?? '',
      company: json['company'] ?? '',
      location: json['location'] ?? '',
      duration: json['duration'] ?? '',
      description: json['description'] ?? '',
      responsibilities: List<String>.from(json['responsibilities'] ?? []),
      technologies: List<String>.from(json['technologies'] ?? []),
      type: json['type'] ?? '',
      isCurrentJob: json['isCurrentJob'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'company': company,
      'location': location,
      'duration': duration,
      'description': description,
      'responsibilities': responsibilities,
      'technologies': technologies,
      'type': type,
      'isCurrentJob': isCurrentJob,
    };
  }
}

// =====================================
// lib/app/data/models/contact_model.dart
// =====================================

class ContactModel {
  final String name;
  final String email;
  final String subject;
  final String message;
  final DateTime timestamp;
  final String? phone;
  final String? company;
  final ContactStatus status;
  final String id;

  ContactModel({
    required this.name,
    required this.email,
    required this.subject,
    required this.message,
    required this.timestamp,
    this.phone,
    this.company,
    this.status = ContactStatus.pending,
    required this.id,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      subject: json['subject'] ?? '',
      message: json['message'] ?? '',
      timestamp: DateTime.parse(json['timestamp']),
      phone: json['phone'],
      company: json['company'],
      status: ContactStatus.values.firstWhere(
        (status) => status.toString() == json['status'],
        orElse: () => ContactStatus.pending,
      ),
      id: json['id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'subject': subject,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'phone': phone,
      'company': company,
      'status': status.toString(),
      'id': id,
    };
  }
}

enum ContactStatus { pending, read, replied, archived }
