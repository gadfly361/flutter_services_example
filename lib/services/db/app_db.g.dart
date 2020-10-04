// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppDb _$AppDbFromJson(Map<String, dynamic> json) {
  return AppDb(
    navigationState: json['navigationState'] == null
        ? null
        : NavigationState.fromJson(
            json['navigationState'] as Map<String, dynamic>),
    postsState: json['postsState'] == null
        ? null
        : PostsState.fromJson(json['postsState'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AppDbToJson(AppDb instance) => <String, dynamic>{
      'navigationState': instance.navigationState,
      'postsState': instance.postsState,
    };
