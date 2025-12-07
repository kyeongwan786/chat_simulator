// lib/extensions/list_extensions.dart

extension FirstOrNull<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
