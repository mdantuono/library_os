part of 'api.dart';

class DioClient {
  static String get _accessToken =>
      supabase.auth.currentSession?.accessToken ?? '';

  static String get _refreshToken =>
      supabase.auth.currentSession?.refreshToken ?? '';

  static BaseOptions get _options {
    return BaseOptions(
      baseUrl: apiHost,
      contentType: 'application/json',
      headers: {
        'x-api-key': apiKey,
        'supabase-access-token': _accessToken,
        'supabase-refresh-token': _refreshToken,
      },
    );
  }

  static Dio get instance => Dio(_options);
}
