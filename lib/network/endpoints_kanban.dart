class EndpointsKanban {
  EndpointsKanban._();

  static String get baseUrl => 'https://api.todoist.com/rest/v2';

  // Tasks
  static String get tasks => '/tasks';

  // Projects
  static String get projects => '/projects';

  // Comments
  static String get comments => '/comments';
}
