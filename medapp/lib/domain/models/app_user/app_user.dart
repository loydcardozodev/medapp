import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medapp/ui/core/user_roles.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    required String id,
    required String name,
    required String email,
    required String password,
    @JsonKey(fromJson: _roleFromJson, toJson: _roleToJson)
    required UserRole role,
    @Default('') String avatarUrl,
    @Default(true) bool isActive,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}

UserRole _roleFromJson(String value) =>
    UserRole.values.firstWhere((e) => e.value == value);

String _roleToJson(UserRole role) => role.value;
