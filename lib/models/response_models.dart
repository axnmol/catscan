import 'package:freezed_annotation/freezed_annotation.dart';
part 'response_models.freezed.dart';
part 'response_models.g.dart';

@freezed
class UploadApiResponse with _$UploadApiResponse {
  const factory UploadApiResponse({
    required String userId,
    required String projectName,
    required String imageUrl,
  }) = _UploadApiResponse;

  factory UploadApiResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadApiResponseFromJson(json);
}

@freezed
class UploadUrlsResponse with _$UploadUrlsResponse {
  const factory UploadUrlsResponse({
    required String userId,
    required String projectName,
    required List<String> urls,
  }) = _UploadUrlsResponse;
  factory UploadUrlsResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadUrlsResponseFromJson(json);
}
