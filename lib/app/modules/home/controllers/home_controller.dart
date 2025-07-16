import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/data/models.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  final count = 0.obs;

  // Scroll controller for main page
  final ScrollController scrollController = ScrollController();

  // Animation controllers
  late AnimationController heroAnimationController;
  late AnimationController skillsAnimationController;
  late AnimationController projectsAnimationController;

  // Reactive variables
  final RxBool showScrollToTop = false.obs;
  final RxInt currentNavIndex = 0.obs;
  final RxString selectedProjectCategory = 'All'.obs;
  final RxBool isMenuOpen = false.obs;
  final RxBool isDarkMode = true.obs;

  // Contact form controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();
  final RxBool isSubmittingForm = false.obs;

  // Global keys for navigation
  final GlobalKey heroKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  // Data lists
  final RxList<ProjectModel> projects = <ProjectModel>[].obs;
  final RxList<SkillModel> skills = <SkillModel>[].obs;
  final RxList<ExperienceModel> experiences = <ExperienceModel>[].obs;
  final RxList<String> projectCategories = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeAnimations();
    _setupScrollListener();
    _loadData();
  }

  void _initializeAnimations() {
    heroAnimationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    skillsAnimationController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );

    projectsAnimationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    // Start hero animation immediately
    heroAnimationController.forward();
  }

  void _setupScrollListener() {
    scrollController.addListener(() {
      // Show/hide scroll to top button
      if (scrollController.offset > 300) {
        showScrollToTop.value = true;
      } else {
        showScrollToTop.value = false;
      }

      // Update current section based on scroll position
      _updateCurrentSection();
    });
  }

  void _updateCurrentSection() {
    final offset = scrollController.offset;
    if (offset < 600) {
      currentNavIndex.value = 0; // Hero/Home
    } else if (offset < 1200) {
      currentNavIndex.value = 1; // About
    } else if (offset < 1800) {
      currentNavIndex.value = 2; // Skills
    } else if (offset < 2400) {
      currentNavIndex.value = 3; // Experience
    } else if (offset < 3000) {
      currentNavIndex.value = 4; // Projects
    } else {
      currentNavIndex.value = 5; // Contact
    }
  }

  void _loadData() {
    _loadProjects();
    _loadSkills();
    _loadExperiences();
    _loadProjectCategories();
  }

  void _loadProjects() {
    projects.addAll([
      ProjectModel(
        title: 'E-Commerce Flutter App',
        description:
            'Complete e-commerce solution with payment gateway integration, user authentication, and admin panel. Built with Flutter, Firebase, and Stripe.',
        technologies: ['Flutter', 'Firebase', 'Stripe', 'GetX', 'REST API'],
        category: 'Mobile App',
        imageUrl: 'assets/images/ecommerce.png',
        githubUrl: 'https://github.com/johndoe/ecommerce-app',
        liveUrl: 'https://ecommerce-demo.web.app',
        features: [
          'Payment Integration',
          'Push Notifications',
          'Admin Dashboard',
          'Real-time Chat',
        ],
      ),
      ProjectModel(
        title: 'Social Media Platform',
        description:
            'Instagram-like social platform with real-time messaging, story features, and advanced photo editing capabilities.',
        technologies: [
          'Flutter',
          'Node.js',
          'MongoDB',
          'Socket.io',
          'Cloudinary',
        ],
        category: 'Web App',
        imageUrl: 'assets/images/social.png',
        githubUrl: 'https://github.com/johndoe/social-app',
        liveUrl: 'https://social-demo.web.app',
        features: [
          'Real-time Messaging',
          'Story Feature',
          'Photo Editor',
          'Video Calls',
        ],
      ),
      ProjectModel(
        title: 'Task Management System',
        description:
            'Comprehensive project management tool with team collaboration, time tracking, and advanced analytics.',
        technologies: [
          'Flutter Web',
          'Django',
          'PostgreSQL',
          'Redis',
          'Docker',
        ],
        category: 'Web App',
        imageUrl: 'assets/images/task.png',
        githubUrl: 'https://github.com/johndoe/task-manager',
        liveUrl: 'https://taskman-demo.web.app',
        features: [
          'Team Collaboration',
          'Time Tracking',
          'Analytics',
          'File Sharing',
        ],
      ),
      ProjectModel(
        title: 'Healthcare Mobile App',
        description:
            'Telemedicine app connecting patients with doctors, featuring appointment booking and health monitoring.',
        technologies: ['Flutter', 'Laravel', 'MySQL', 'Agora SDK', 'HL7 FHIR'],
        category: 'Mobile App',
        imageUrl: 'assets/images/healthcare.png',
        githubUrl: 'https://github.com/johndoe/healthcare-app',
        liveUrl: null,
        features: [
          'Video Consultation',
          'Health Records',
          'Appointment Booking',
          'Medicine Reminders',
        ],
      ),
    ]);
  }

  void _loadSkills() {
    skills.addAll([
      SkillModel(name: 'Flutter & Dart', level: 95, category: 'Frontend'),
      SkillModel(name: 'React & JavaScript', level: 88, category: 'Frontend'),
      SkillModel(name: 'Node.js & Express', level: 85, category: 'Backend'),
      SkillModel(name: 'Python & Django', level: 82, category: 'Backend'),
      SkillModel(name: 'Firebase & AWS', level: 90, category: 'Cloud'),
      SkillModel(name: 'MongoDB & PostgreSQL', level: 87, category: 'Database'),
      SkillModel(name: 'Docker & Kubernetes', level: 80, category: 'DevOps'),
      SkillModel(name: 'Git & CI/CD', level: 92, category: 'DevOps'),
      SkillModel(name: 'UI/UX Design', level: 85, category: 'Design'),
      SkillModel(name: 'Figma & Adobe XD', level: 83, category: 'Design'),
    ]);
  }

  void _loadExperiences() {
    experiences.addAll([
      ExperienceModel(
        title: 'Senior Flutter Developer',
        company: 'TechCorp Solutions',
        location: 'San Francisco, CA',
        duration: 'Jan 2022 - Present',
        description:
            'Leading a team of 5 developers in building cross-platform mobile applications. Architected and developed 8+ successful apps with 500K+ downloads.',
        responsibilities: [
          'Led development of 8 mobile applications with 500K+ total downloads',
          'Architected scalable Flutter applications using clean architecture',
          'Mentored junior developers and conducted technical interviews',
          'Implemented CI/CD pipelines reducing deployment time by 60%',
          'Collaborated with product managers and designers for optimal UX',
        ],
        technologies: ['Flutter', 'Dart', 'Firebase', 'AWS', 'GetX', 'Bloc'],
        type: 'Full-time',
      ),
      ExperienceModel(
        title: 'Mobile App Developer',
        company: 'InnovateLab',
        location: 'New York, NY',
        duration: 'Jun 2020 - Dec 2021',
        description:
            'Developed and maintained multiple client projects including e-commerce, social media, and productivity apps.',
        responsibilities: [
          'Developed 12+ mobile applications for various industries',
          'Integrated third-party APIs and payment gateways',
          'Optimized app performance achieving 40% faster load times',
          'Collaborated with cross-functional teams in agile environment',
          'Maintained 98% crash-free rate across all applications',
        ],
        technologies: [
          'Flutter',
          'React Native',
          'Node.js',
          'MongoDB',
          'REST APIs',
        ],
        type: 'Full-time',
      ),
    ]);
  }

  void _loadProjectCategories() {
    projectCategories.addAll(['All', 'Mobile App', 'Web App', 'UI/UX Design']);
  }

  // Navigation methods
  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  // Project filtering
  void filterProjects(String category) {
    selectedProjectCategory.value = category;
  }

  List<ProjectModel> get filteredProjects {
    if (selectedProjectCategory.value == 'All') {
      return projects;
    }
    return projects
        .where((project) => project.category == selectedProjectCategory.value)
        .toList();
  }

  // Menu toggle for mobile
  void toggleMenu() {
    isMenuOpen.value = !isMenuOpen.value;
  }

  // Theme toggle
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  // Contact form methods
  Future<void> submitContactForm() async {
    if (!_validateContactForm()) return;

    isSubmittingForm.value = true;

    try {
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));

      Get.snackbar(
        'Success!',
        'Thank you for your message. I\'ll get back to you soon!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
        snackPosition: SnackPosition.TOP,
      );

      _clearContactForm();
    } catch (e) {
      Get.snackbar(
        'Error!',
        'Failed to send message. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isSubmittingForm.value = false;
    }
  }

  bool _validateContactForm() {
    if (nameController.text.trim().isEmpty) {
      _showValidationError('Please enter your name');
      return false;
    }

    if (emailController.text.trim().isEmpty ||
        !GetUtils.isEmail(emailController.text.trim())) {
      _showValidationError('Please enter a valid email address');
      return false;
    }

    if (messageController.text.trim().isEmpty) {
      _showValidationError('Please enter your message');
      return false;
    }

    return true;
  }

  void _showValidationError(String message) {
    Get.snackbar(
      'Validation Error',
      message,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
      duration: Duration(seconds: 2),
      snackPosition: SnackPosition.TOP,
    );
  }

  void _clearContactForm() {
    nameController.clear();
    emailController.clear();
    messageController.clear();
  }

  // External URL launches
  Future<void> launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar(
        'Error',
        'Could not launch URL: $url',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> downloadResume() async {
    Get.snackbar(
      'Download Started',
      'Resume is being downloaded...',
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      duration: Duration(seconds: 2),
      snackPosition: SnackPosition.TOP,
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    scrollController.dispose();
    heroAnimationController.dispose();
    skillsAnimationController.dispose();
    projectsAnimationController.dispose();
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
