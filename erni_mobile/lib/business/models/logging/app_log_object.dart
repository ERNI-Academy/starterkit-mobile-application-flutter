import 'package:objectbox/objectbox.dart';

@Entity()
class AppLogObject {
  AppLogObject({
    required this.uid,
    required this.sessionId,
    required this.level,
    required this.message,
    required this.createdAt,
    required this.owner,
    this.extras = const {},
  });

  @Index()
  final String uid;

  final String sessionId;
  final String level;
  final String message;

  @Property(type: PropertyType.date)
  final DateTime createdAt;

  final String owner;
  final Map<String, Object> extras;

  @Id()
  int id = 0;
}
