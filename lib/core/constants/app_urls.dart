class AppUrls {
  static const String baseUrl = 'http://localhost:5001';

  // Dashboard Analytics
  static const String getDashboardAnalytics =
      '$baseUrl/api/dashboardAnalytics/getDashboardAnalytics';
  // Era Urls
  static const String getAllEras = '$baseUrl/api/eras/getEras';
  static const String createEra = '$baseUrl/api/eras/createEra';
  static String updateEra(String eraId) => '$baseUrl/api/eras/updateEra/$eraId';
  static String deleteEra(String eraId) => '$baseUrl/api/eras/deleteEra/$eraId';

  // Story
  static const String getAllStories = '$baseUrl/api/stories/getAllStories';
  static String getEraStories(String eraId) =>
      '$baseUrl/api/stories/$eraId/getEraStories';
  static String createStory(String eraId) =>
      '$baseUrl/api/stories/$eraId/createStory';
  static String updateStory(String storyId) =>
      '$baseUrl/api/stories/$storyId/updateStory';
  static String deleteStory(String storyId) =>
      '$baseUrl/api/stories/$storyId/deleteStory';
  static String reorderStories(String eraId) =>
      '$baseUrl/api/stories/$eraId/reorderStories';

  // Story Blocks
  static String getStoryBlocks(String storyId) =>
      '$baseUrl/api/storyBlocks/$storyId/getStoryBlocks';
  static String createStoryBlock(String storyId) =>
      '$baseUrl/api/storyBlocks/$storyId/createStoryBlock';

  static String updateStoryBlock(String storyId) =>
      '$baseUrl/api/storyBlocks/$storyId/updateStoryBlock';

  static String deleteStoryBlock(String storyId) =>
      '$baseUrl/api/storyBlocks/$storyId/deleteStoryBlock';

  static String reorderStoryBlocks(String storyId) =>
      '$baseUrl/api/storyBlocks/$storyId/reorderStoryBlocks';

  // Quizzes
  static String getQuizzes = '$baseUrl/api/quiz/getQuizzes';
  static String getQuiz(String quizId) => '$baseUrl/api/quiz/$quizId/getQuiz';

  static String createQuiz(String storyId) =>
      '$baseUrl/api/quiz/$storyId/createQuiz';

  static String updateQuiz(String quizId) =>
      '$baseUrl/api/quiz/$quizId/updateQuiz';

  static String deleteQuiz(String quizId) =>
      '$baseUrl/api/quiz/$quizId/deleteQuiz';

  // Questions and Options
  static String createQuestion(String quizId) =>
      '$baseUrl/api/questions/$quizId/createQuestion';

  static String updateQuestion(String questionId) =>
      '$baseUrl/api/questions/$questionId/updateQuestion';

  static String deleteQuestion(String questionId) =>
      '$baseUrl/api/questions/$questionId/deleteQuestion';

  // Admin Login
  static String adminLogin = '$baseUrl/api/auth/adminLogin';
  static String adminLogout = '$baseUrl/api/auth/adminLogout';
  static String adminMe = '$baseUrl/api/auth/me';
}

