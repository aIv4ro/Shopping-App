abstract class Entity {
  const Entity({required this.id});
  Map<String, dynamic> toJson();
  final String id;
}
