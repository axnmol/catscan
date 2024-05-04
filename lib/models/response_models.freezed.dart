// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'response_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UploadApiResponse _$UploadApiResponseFromJson(Map<String, dynamic> json) {
  return _UploadApiResponse.fromJson(json);
}

/// @nodoc
mixin _$UploadApiResponse {
  String get userId => throw _privateConstructorUsedError;
  String get projectName => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UploadApiResponseCopyWith<UploadApiResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UploadApiResponseCopyWith<$Res> {
  factory $UploadApiResponseCopyWith(
          UploadApiResponse value, $Res Function(UploadApiResponse) then) =
      _$UploadApiResponseCopyWithImpl<$Res, UploadApiResponse>;
  @useResult
  $Res call({String userId, String projectName, String imageUrl});
}

/// @nodoc
class _$UploadApiResponseCopyWithImpl<$Res, $Val extends UploadApiResponse>
    implements $UploadApiResponseCopyWith<$Res> {
  _$UploadApiResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? projectName = null,
    Object? imageUrl = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      projectName: null == projectName
          ? _value.projectName
          : projectName // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UploadApiResponseCopyWith<$Res>
    implements $UploadApiResponseCopyWith<$Res> {
  factory _$$_UploadApiResponseCopyWith(_$_UploadApiResponse value,
          $Res Function(_$_UploadApiResponse) then) =
      __$$_UploadApiResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId, String projectName, String imageUrl});
}

/// @nodoc
class __$$_UploadApiResponseCopyWithImpl<$Res>
    extends _$UploadApiResponseCopyWithImpl<$Res, _$_UploadApiResponse>
    implements _$$_UploadApiResponseCopyWith<$Res> {
  __$$_UploadApiResponseCopyWithImpl(
      _$_UploadApiResponse _value, $Res Function(_$_UploadApiResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? projectName = null,
    Object? imageUrl = null,
  }) {
    return _then(_$_UploadApiResponse(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      projectName: null == projectName
          ? _value.projectName
          : projectName // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UploadApiResponse implements _UploadApiResponse {
  const _$_UploadApiResponse(
      {required this.userId,
      required this.projectName,
      required this.imageUrl});

  factory _$_UploadApiResponse.fromJson(Map<String, dynamic> json) =>
      _$$_UploadApiResponseFromJson(json);

  @override
  final String userId;
  @override
  final String projectName;
  @override
  final String imageUrl;

  @override
  String toString() {
    return 'UploadApiResponse(userId: $userId, projectName: $projectName, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UploadApiResponse &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.projectName, projectName) ||
                other.projectName == projectName) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, projectName, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UploadApiResponseCopyWith<_$_UploadApiResponse> get copyWith =>
      __$$_UploadApiResponseCopyWithImpl<_$_UploadApiResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UploadApiResponseToJson(
      this,
    );
  }
}

abstract class _UploadApiResponse implements UploadApiResponse {
  const factory _UploadApiResponse(
      {required final String userId,
      required final String projectName,
      required final String imageUrl}) = _$_UploadApiResponse;

  factory _UploadApiResponse.fromJson(Map<String, dynamic> json) =
      _$_UploadApiResponse.fromJson;

  @override
  String get userId;
  @override
  String get projectName;
  @override
  String get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$_UploadApiResponseCopyWith<_$_UploadApiResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

UploadUrlsResponse _$UploadUrlsResponseFromJson(Map<String, dynamic> json) {
  return _UploadUrlsResponse.fromJson(json);
}

/// @nodoc
mixin _$UploadUrlsResponse {
  String get userId => throw _privateConstructorUsedError;
  String get projectName => throw _privateConstructorUsedError;
  List<String> get urls => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UploadUrlsResponseCopyWith<UploadUrlsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UploadUrlsResponseCopyWith<$Res> {
  factory $UploadUrlsResponseCopyWith(
          UploadUrlsResponse value, $Res Function(UploadUrlsResponse) then) =
      _$UploadUrlsResponseCopyWithImpl<$Res, UploadUrlsResponse>;
  @useResult
  $Res call({String userId, String projectName, List<String> urls});
}

/// @nodoc
class _$UploadUrlsResponseCopyWithImpl<$Res, $Val extends UploadUrlsResponse>
    implements $UploadUrlsResponseCopyWith<$Res> {
  _$UploadUrlsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? projectName = null,
    Object? urls = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      projectName: null == projectName
          ? _value.projectName
          : projectName // ignore: cast_nullable_to_non_nullable
              as String,
      urls: null == urls
          ? _value.urls
          : urls // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UploadUrlsResponseCopyWith<$Res>
    implements $UploadUrlsResponseCopyWith<$Res> {
  factory _$$_UploadUrlsResponseCopyWith(_$_UploadUrlsResponse value,
          $Res Function(_$_UploadUrlsResponse) then) =
      __$$_UploadUrlsResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId, String projectName, List<String> urls});
}

/// @nodoc
class __$$_UploadUrlsResponseCopyWithImpl<$Res>
    extends _$UploadUrlsResponseCopyWithImpl<$Res, _$_UploadUrlsResponse>
    implements _$$_UploadUrlsResponseCopyWith<$Res> {
  __$$_UploadUrlsResponseCopyWithImpl(
      _$_UploadUrlsResponse _value, $Res Function(_$_UploadUrlsResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? projectName = null,
    Object? urls = null,
  }) {
    return _then(_$_UploadUrlsResponse(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      projectName: null == projectName
          ? _value.projectName
          : projectName // ignore: cast_nullable_to_non_nullable
              as String,
      urls: null == urls
          ? _value._urls
          : urls // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UploadUrlsResponse implements _UploadUrlsResponse {
  const _$_UploadUrlsResponse(
      {required this.userId,
      required this.projectName,
      required final List<String> urls})
      : _urls = urls;

  factory _$_UploadUrlsResponse.fromJson(Map<String, dynamic> json) =>
      _$$_UploadUrlsResponseFromJson(json);

  @override
  final String userId;
  @override
  final String projectName;
  final List<String> _urls;
  @override
  List<String> get urls {
    if (_urls is EqualUnmodifiableListView) return _urls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_urls);
  }

  @override
  String toString() {
    return 'UploadUrlsResponse(userId: $userId, projectName: $projectName, urls: $urls)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UploadUrlsResponse &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.projectName, projectName) ||
                other.projectName == projectName) &&
            const DeepCollectionEquality().equals(other._urls, _urls));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, projectName,
      const DeepCollectionEquality().hash(_urls));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UploadUrlsResponseCopyWith<_$_UploadUrlsResponse> get copyWith =>
      __$$_UploadUrlsResponseCopyWithImpl<_$_UploadUrlsResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UploadUrlsResponseToJson(
      this,
    );
  }
}

abstract class _UploadUrlsResponse implements UploadUrlsResponse {
  const factory _UploadUrlsResponse(
      {required final String userId,
      required final String projectName,
      required final List<String> urls}) = _$_UploadUrlsResponse;

  factory _UploadUrlsResponse.fromJson(Map<String, dynamic> json) =
      _$_UploadUrlsResponse.fromJson;

  @override
  String get userId;
  @override
  String get projectName;
  @override
  List<String> get urls;
  @override
  @JsonKey(ignore: true)
  _$$_UploadUrlsResponseCopyWith<_$_UploadUrlsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
