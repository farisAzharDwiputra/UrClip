bool isAssetPath(String? path) {
  if (path == null) return false;
  return path.startsWith('assets/');
}
