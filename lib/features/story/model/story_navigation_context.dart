class StoryNavigationContext {
  final String? eraId;
  final String? eraTitle;

  const StoryNavigationContext({this.eraId, this.eraTitle});

  bool get isFiltered => eraId != null;
}
