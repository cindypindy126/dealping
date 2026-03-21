import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'user_provider.freezed.dart';
part 'user_provider.g.dart';

@freezed
class UserProvider with _$UserProvider {
  const factory UserProvider({
    required String providerId,
    @Default('') String nickname,
  }) = _UserProvider;

  factory UserProvider.fromJson(Map<String, dynamic> json) =>
      _$UserProviderFromJson(json);

  factory UserProvider.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserProvider.fromJson(data);
  }
}
