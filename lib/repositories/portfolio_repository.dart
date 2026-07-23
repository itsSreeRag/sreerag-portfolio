import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/contact_form_model.dart';
import '../models/experience_model.dart';
import '../models/project_model.dart';
import '../models/skill_model.dart';

class PortfolioRepository {
  Future<List<ProjectModel>> fetchProjects() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return [
      const ProjectModel(
        id: 'labtrack',
        title: 'LabTrack - Laboratory Management System',
        shortDescription:
            'A Flutter-based Windows desktop application for managing laboratory operations, patient records, billing, and diagnostic reports using a fast local SQLite database.',

        detailedDescription:
            'LabTrack is a Windows desktop laboratory management application developed with Flutter. '
            'It helps medical laboratories efficiently manage patient records, laboratory tests, billing, and diagnostic reports from a single system. '
            'The application simplifies daily laboratory workflows by reducing manual paperwork, improving data organization, and enabling fast report generation. '
            'It also supports customizable laboratory tests, PDF report generation, report printing, report sharing, and secure local data backup using SQLite.',

        images: [
          'assets/projects/lab_track/lab_track-1.png',
          'assets/projects/lab_track/lab_track-2.png',
          'assets/projects/lab_track/lab_track-3.png',
          'assets/projects/lab_track/lab_track-4.png',
          'assets/projects/lab_track/lab_track-5.png',
        ],

        platformTag: 'Windows Desktop',

        technologies: [
          'Flutter',
          'Dart',
          'SQLite',
          'Riverpod',
          'GoRouter',
          'MVVM',
          'PDF',
          'Printing',
          'Share Plus',
          'SQLite FFI',
        ],

        features: [
          'Interactive Dashboard with Laboratory Statistics',
          'Patient Registration & Management',
          'Patient Search & Filtering',
          'Laboratory Test Management',
          'Custom Laboratory Test Creation',
          'Billing & Invoice Generation',
          'Diagnostic Report Generation',
          'PDF Report Export',
          'Print Laboratory Reports',
          'Share Reports',
          'SQLite Local Database',
          'Local Backup & Restore',
          'Responsive Windows Desktop Interface',
        ],
        githubUrl: 'https://github.com/sreerag-dev/labtrack',
        liveDemoUrl: 'https://sreerag.dev/labtrack',
        caseStudyUrl: 'https://sreerag.dev/case-study/labtrack',
      ),
      const ProjectModel(
        id: 'hotel-booking',
        title: 'Hotel Booking & Reservation App',
        shortDescription:
            'A modern mobile travel app featuring Firebase authentication, interactive Google Maps integration, room bookings, and user reviews.',
        detailedDescription:
            'Built with Flutter and Firebase, this application delivers a smooth booking experience for travelers. '
            'Users can explore luxury stay options on interactive maps, view detailed room specs, manage active bookings, and save favorite destinations.',
        images: [
          'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=1200&q=80',
          'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=1200&q=80',
          'https://images.unsplash.com/photo-1540555700478-4be289fbecef?auto=format&fit=crop&w=1200&q=80',
          'https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=1200&q=80',
          'https://images.unsplash.com/photo-1571896349842-33c89424de2d?auto=format&fit=crop&w=1200&q=80',
        ],
        platformTag: 'Android / iOS',
        technologies: [
          'Flutter',
          'Firebase Auth',
          'Firestore',
          'Google Maps API',
          'Provider',
        ],
        features: [
          'Firebase Authentication (Email & Google Sign-In)',
          'Interactive Google Maps Location Finder',
          'Real-time Hotel Room Booking Engine',
          'User Reviews, Ratings & Recommendations',
          'Favorites List & Saved Stays',
          'Push Notifications & Instant Confirmation',
        ],
        githubUrl: 'https://github.com/sreerag-dev/hotel-booking-app',
        liveDemoUrl: 'https://sreerag.dev/hotel-booking',
        caseStudyUrl: 'https://sreerag.dev/case-study/hotel-booking',
      ),
      const ProjectModel(
        id: 'ecommerce',
        title: 'Modern E-Commerce Store App',
        shortDescription:
            'Scalable cross-platform E-Commerce platform integrated with REST APIs, secure user auth, product search, and order checkout.',
        detailedDescription:
            'A production-ready retail shopping application built on clean architectural principles. '
            'Features dynamic product listing, paginated catalog search, wishlist state persistence, REST API integration, and user profile management.',
        images: [
          'https://images.unsplash.com/photo-1472851294608-062f824d29cc?auto=format&fit=crop&w=1200&q=80',
          'https://images.unsplash.com/photo-1441986300917-64674bd600d8?auto=format&fit=crop&w=1200&q=80',
          'https://images.unsplash.com/photo-1526178613552-2b45c6c302f0?auto=format&fit=crop&w=1200&q=80',
          'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?auto=format&fit=crop&w=1200&q=80',
          'https://images.unsplash.com/photo-1483985988355-763728e1935b?auto=format&fit=crop&w=1200&q=80',
        ],
        platformTag: 'Cross-Platform',
        technologies: [
          'Flutter',
          'REST APIs',
          'Dio',
          'Hive',
          'Clean Architecture',
        ],
        features: [
          'RESTful API Data Integration with Caching',
          'JWT Token Authentication & Auto-Renewal',
          'Categorized Product Showcase & Filtering',
          'Offline Persistent Wishlist using Hive',
          'Interactive Shopping Cart & Price Calculation',
          'User Profile & Order History Tracking',
        ],
        githubUrl: 'https://github.com/sreerag-dev/ecommerce-flutter',
        liveDemoUrl: 'https://sreerag.dev/ecommerce',
        caseStudyUrl: 'https://sreerag.dev/case-study/ecommerce',
      ),
    ];
  }

  Future<List<SkillModel>> fetchSkills() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      const SkillModel(
        name: 'Dart',
        category: SkillCategory.languages,
        icon: Icons.code_rounded,
        level: 0.95,
        description:
            'Strong object-oriented Dart programming, async streams, and null safety.',
      ),
      const SkillModel(
        name: 'SQL',
        category: SkillCategory.languages,
        icon: Icons.storage_rounded,
        level: 0.85,
        description:
            'Relational database query optimization, migrations, and joins.',
      ),
      const SkillModel(
        name: 'Flutter',
        category: SkillCategory.framework,
        icon: Icons.flutter_dash_rounded,
        level: 0.95,
        description:
            'Custom painting, responsive layouts, web & desktop compilation, performance tuning.',
      ),
      const SkillModel(
        name: 'Provider',
        category: SkillCategory.stateManagement,
        icon: Icons.layers_rounded,
        level: 0.92,
        description:
            'Predictable UI state management, ChangeNotifier, and dependency injection.',
      ),
      const SkillModel(
        name: 'GetX',
        category: SkillCategory.stateManagement,
        icon: Icons.flash_on_rounded,
        level: 0.88,
        description:
            'Lightweight reactive state management, routing, and dependency management.',
      ),
      const SkillModel(
        name: 'Bloc',
        category: SkillCategory.stateManagement,
        icon: Icons.account_tree_rounded,
        level: 0.85,
        description:
            'Event-driven state management with clean separation of concerns.',
      ),
      const SkillModel(
        name: 'Firebase',
        category: SkillCategory.backend,
        icon: FontAwesomeIcons.fire,
        level: 0.90,
        description:
            'Authentication, Firestore database, Cloud Functions, and Analytics.',
      ),
      const SkillModel(
        name: 'REST APIs',
        category: SkillCategory.backend,
        icon: Icons.api_rounded,
        level: 0.92,
        description:
            'HTTP client integration, JSON serialization, interceptors, and error handling.',
      ),
      const SkillModel(
        name: 'SQLite',
        category: SkillCategory.database,
        icon: Icons.dataset_rounded,
        level: 0.88,
        description: 'High-performance local embedded relational storage.',
      ),
      const SkillModel(
        name: 'Hive',
        category: SkillCategory.database,
        icon: Icons.inventory_2_rounded,
        level: 0.90,
        description:
            'Ultra-fast key-value NoSQL database written in pure Dart.',
      ),
      const SkillModel(
        name: 'Firestore',
        category: SkillCategory.database,
        icon: Icons.cloud_done_rounded,
        level: 0.88,
        description: 'Real-time scalable cloud database synchronization.',
      ),
      const SkillModel(
        name: 'Git & GitHub',
        category: SkillCategory.tools,
        icon: FontAwesomeIcons.github,
        level: 0.90,
        description:
            'Version control, feature branching, pull requests, and CI/CD pipelines.',
      ),
      const SkillModel(
        name: 'VS Code & Android Studio',
        category: SkillCategory.tools,
        icon: Icons.terminal_rounded,
        level: 0.92,
        description:
            'IDE shortcuts, Dart dev tools, memory profiling, and debugging.',
      ),
      const SkillModel(
        name: 'Postman',
        category: SkillCategory.tools,
        icon: Icons.send_rounded,
        level: 0.88,
        description:
            'API testing, mock servers, and environment configuration.',
      ),
      const SkillModel(
        name: 'Figma',
        category: SkillCategory.tools,
        icon: FontAwesomeIcons.figma,
        level: 0.85,
        description:
            'UI/UX layout translation into pixel-perfect Flutter widgets.',
      ),
    ];
  }

  Future<List<ExperienceModel>> fetchExperience() async {
    await Future.delayed(const Duration(milliseconds: 400));

    return [
      const ExperienceModel(
        role: 'Junior Flutter Developer',
        company: 'Appzia Tec Solutions',
        duration:
            'Jan 2026 - Present', // Replace with your actual joining month
        location: 'Wayanad, Kerala, India',

        responsibilities: [
          'Developed Flutter applications for Android and iOS using REST APIs.',
          'Built features for E-Commerce and Parish Management applications.',
          'Implemented new features and resolved production bugs.',
          'Managed application state using Provider and Bloc.',
          'Collaborated with backend and web teams using Git.',
        ],

        technologies: [
          'Flutter',
          'Dart',
          'REST APIs',
          'Provider',
          'Bloc',
          'Firebase',
          'Git',
          'GitHub',
        ],
      ),

      const ExperienceModel(
        role: 'Flutter Developer Trainee',
        company: 'Brototype',
        duration: '2024 - 2025',
        location: 'Calicut, Kerala, India',

        responsibilities: [
          'Completed intensive hands-on training in Flutter and Dart development.',
          'Built real-world mobile, web, and desktop applications using Flutter.',
          'Worked with Firebase, REST APIs, SQLite, Provider, Bloc and GetX in practical projects.',
          'Practiced Git, GitHub, clean architecture, and collaborative development workflows.',
          'Strengthened problem-solving skills through project-based learning and code reviews.',
        ],

        technologies: [
          'Flutter',
          'Dart',
          'Firebase',
          'REST APIs',
          'SQLite',
          'Provider',
          'GetX',
          'Bloc',
          'Git',
          'GitHub',
        ],
      ),
    ];
  }

  Future<bool> sendContactMessage(ContactFormModel formModel) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return true;
  }
}
