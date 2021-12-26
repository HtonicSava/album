import 'package:hive/hive.dart';
part 'hive_user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject{
  @HiveField(0)
  late String login;
  @HiveField(1)
  late String password;
}