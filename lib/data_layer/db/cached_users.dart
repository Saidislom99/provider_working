const String userTable = "cached_user";
class CachedUserFields {
  static const String id = "id";
  static const String name = "name";
  static const String age = "age";
  static const String count = "count";

}
class CachedUser {
  CachedUser({
    this.id,
    required this.name,
    required this.age,
    required this.count,

  });

  final String name;
  final int count;
  final int age;
  final int? id;

  CachedUser copyWith({
    String? name,
    int? age,
    int? count,
    int? id,

  }) =>
      CachedUser(
          id:  id ?? this.id,
          name: name ?? this.name,
          age: age ?? this.age,
          count: count ?? this.count,

      );
  static CachedUser fromJson(Map<String, Object?> json) =>
      CachedUser(
        id: json[CachedUserFields.id] as int,
        age: json[CachedUserFields.age] as int,
        count: json[CachedUserFields.count] as int,
        name: json[CachedUserFields.name] as String,

      );
  Map<String, Object?> toJson() =>
      {
        CachedUserFields.id:id,
        CachedUserFields.name: name,
        CachedUserFields.age:age,
        CachedUserFields.count: count,

      };
}