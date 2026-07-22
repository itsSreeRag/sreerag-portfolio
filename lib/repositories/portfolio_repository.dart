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
        title: 'LabTrack - Windows Laboratory System',
        shortDescription:
            'A comprehensive Windows Desktop Laboratory Management System for clinical workflows, test tracking, and instant invoicing.',
        detailedDescription:
            'LabTrack is a desktop application built with Flutter Desktop for Windows. '
            'It provides seamless patient registration, laboratory test categorization, automated bill generation, report generation, and fast local database querying using SQLite.',
        imageUrl: 'https://images.unsplash.com/photo-1579154204601-01588f351e67?auto=format&fit=crop&w=1200&q=80',
        platformTag: 'Windows Desktop',
        technologies: ['Flutter Desktop', 'Dart', 'SQLite', 'MVVM', 'PDF Generator'],
        features: [
          'Patient Management & Medical History',
          'Lab Test Categorization & Pricing',
          'Automated Invoicing & Billing',
          'PDF Diagnostic Report Generation',
          'High-Performance SQLite Local Storage',
          'Instant Real-Time Search & Data Filter',
          'Responsive Windows Desktop UI',
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
        imageUrl: 'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=1200&q=80',
        platformTag: 'Android / iOS',
        technologies: ['Flutter', 'Firebase Auth', 'Firestore', 'Google Maps API', 'Provider'],
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
        imageUrl: 'https://images.unsplash.com/photo-1472851294608-062f824d29cc?auto=format&fit=crop&w=1200&q=80',
        platformTag: 'Cross-Platform',
        technologies: ['Flutter', 'REST APIs', 'Dio', 'Hive', 'Clean Architecture'],
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
        description: 'Strong object-oriented Dart programming, async streams, and null safety.',
      ),
      const SkillModel(
        name: 'SQL',
        category: SkillCategory.languages,
        icon: Icons.storage_rounded,
        level: 0.85,
        description: 'Relational database query optimization, migrations, and joins.',
      ),
      const SkillModel(
        name: 'Flutter',
        category: SkillCategory.framework,
        icon: Icons.flutter_dash_rounded,
        level: 0.95,
        description: 'Custom painting, responsive layouts, web & desktop compilation, performance tuning.',
      ),
      const SkillModel(
        name: 'Provider',
        category: SkillCategory.stateManagement,
        icon: Icons.layers_rounded,
        level: 0.92,
        description: 'Predictable UI state management, ChangeNotifier, and dependency injection.',
      ),
      const SkillModel(
        name: 'GetX',
        category: SkillCategory.stateManagement,
        icon: Icons.flash_on_rounded,
        level: 0.88,
        description: 'Lightweight reactive state management, routing, and dependency management.',
      ),
      const SkillModel(
        name: 'Bloc',
        category: SkillCategory.stateManagement,
        icon: Icons.account_tree_rounded,
        level: 0.85,
        description: 'Event-driven state management with clean separation of concerns.',
      ),
      const SkillModel(
        name: 'Firebase',
        category: SkillCategory.backend,
        icon: FontAwesomeIcons.fire,
        level: 0.90,
        description: 'Authentication, Firestore database, Cloud Functions, and Analytics.',
      ),
      const SkillModel(
        name: 'REST APIs',
        category: SkillCategory.backend,
        icon: Icons.api_rounded,
        level: 0.92,
        description: 'HTTP client integration, JSON serialization, interceptors, and error handling.',
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
        description: 'Ultra-fast key-value NoSQL database written in pure Dart.',
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
        description: 'Version control, feature branching, pull requests, and CI/CD pipelines.',
      ),
      const SkillModel(
        name: 'VS Code & Android Studio',
        category: SkillCategory.tools,
        icon: Icons.terminal_rounded,
        level: 0.92,
        description: 'IDE shortcuts, Dart dev tools, memory profiling, and debugging.',
      ),
      const SkillModel(
        name: 'Postman',
        category: SkillCategory.tools,
        icon: Icons.send_rounded,
        level: 0.88,
        description: 'API testing, mock servers, and environment configuration.',
      ),
      const SkillModel(
        name: 'Figma',
        category: SkillCategory.tools,
        icon: FontAwesomeIcons.figma,
        level: 0.85,
        description: 'UI/UX layout translation into pixel-perfect Flutter widgets.',
      ),
    ];
  }

  Future<List<ExperienceModel>> fetchExperience() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return [
      const ExperienceModel(
        role: 'Flutter Developer Trainee',
        company: 'Tech Solutions Ltd.',
        duration: '2023 - Present',
        location: 'Kerala, India',
        responsibilities: [
          'Developed production-grade cross-platform mobile and desktop interfaces using Flutter & Dart.',
          'Integrated RESTful APIs and Firebase backend services including Auth and Firestore.',
          'Built responsive layouts supporting mobile, tablet, and desktop web screen viewports.',
          'Utilized Git & GitHub for collaborative code reviews, branching, and version tracking.',
          'Diagnosed performance bottlenecks, resolved memory leaks, and refined UI animations.',
        ],
        technologies: ['Flutter', 'Dart', 'Firebase', 'REST APIs', 'Provider', 'Git', 'SQLite'],
      ),
    ];
  }

  Future<bool> sendContactMessage(ContactFormModel formModel) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return true;
  }
}
