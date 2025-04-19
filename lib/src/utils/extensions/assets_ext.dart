extension AssetsExt on String {
  String get fileName => replaceAll('assets/images/', '');
}
