typedef LaunchCallback = Function(String url);

class ItemData<T> {
  final String name;
  final T icon;
  final String url;
  const ItemData({
    required this.name,
    required this.icon,
    required this.url,
  });
}
