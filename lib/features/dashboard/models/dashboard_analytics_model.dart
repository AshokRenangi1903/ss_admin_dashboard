class DashboardAnalyticsModel {
  final int totalUsers;
  final int totalEras;
  final int totalStories;
  final int totalQuizzes;
  final int publishedStories;
  final int popularStories;

  DashboardAnalyticsModel({
    required this.totalUsers,
    required this.totalEras,
    required this.totalStories,
    required this.totalQuizzes,
    required this.publishedStories,
    required this.popularStories,
  });

  factory DashboardAnalyticsModel.fromJson(Map<String, dynamic> json) {
    return DashboardAnalyticsModel(
      totalUsers: json['totalUsers'] ?? 0,
      totalEras: json['totalEras'] ?? 0,
      totalStories: json['totalStories'] ?? 0,
      totalQuizzes: json['totalQuizzes'] ?? 0,
      publishedStories: json['publishedStories'] ?? 0,
      popularStories: json['popularStories'] ?? 0,
    );
  }
}
