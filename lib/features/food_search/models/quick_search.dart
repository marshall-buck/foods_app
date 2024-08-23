class QuickSearch {
  final List<String> _settings;

  QuickSearch([List<String>? userSettings])
      : _settings = userSettings ?? ['1003', '1004', '1005', '1008'];

  List<String> get settings => _settings;
}
