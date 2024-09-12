class QuickSearch {

  QuickSearch([List<String>? userSettings])
      : _settings = userSettings ?? ['1003', '1004', '1005', '1008'];
  final List<String> _settings;

  List<String> get settings => _settings;
}
