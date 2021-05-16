
abstract class AuthCredentials {
  final String nickname;
  final String username;
  final String password;

  AuthCredentials({this.nickname, this.username, this.password});
}

class LoginCredentials extends AuthCredentials {
  LoginCredentials({String nickname, String username, String password})
      : super(nickname: nickname, username: username, password: password);
}

class SignUpCredentials extends AuthCredentials {
  final String email;

  SignUpCredentials({String nickname, String username, String password, this.email})
      : super(nickname: nickname, username: username, password: password);
}