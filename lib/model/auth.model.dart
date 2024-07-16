import 'package:app_cosmetic/model/user.model.dart';

class SignInResponse {
  final int code;
  final Metadata metadata;

  SignInResponse({required this.code, required this.metadata});

  factory SignInResponse.fromJson(Map<String, dynamic> json) {
    return SignInResponse(
      code: json['code'],
      metadata: Metadata.fromJson(json['metadata']),
    );
  }
}

class Metadata {
  final User user;
  final Tokens tokens;

  Metadata({required this.user, required this.tokens});

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      user: User.fromJson(json['user']),
      tokens: Tokens.fromJson(json['tokens']),
    );
  }
}

class Tokens {
  final String accessToken;
  final String refreshToken;

  Tokens({required this.accessToken, required this.refreshToken});

  factory Tokens.fromJson(Map<String, dynamic> json) {
    return Tokens(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}