class SignInModel {
  String? token;
  String? type;
  int? userId;
  String? username;
  String? refreshToken;
  String? refreshTokenExpiry;
  List<String>? roles;

  SignInModel(
      {this.token,
      this.type,
      this.userId,
      this.username,
      this.refreshToken,
      this.refreshTokenExpiry,
      this.roles});

  SignInModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    type = json['type'];
    userId = json['userId'];
    username = json['username'];
    refreshToken = json['refreshToken'];
    refreshTokenExpiry = json['refreshTokenExpiry'];
    roles = json['roles'].cast<String>();
  }

  get firstName => null;

  get lastName => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = token;
    data['type'] = type;
    data['userId'] = userId;
    data['username'] = username;
    data['refreshToken'] = refreshToken;
    data['refreshTokenExpiry'] = refreshTokenExpiry;
    data['roles'] = roles;
    return data;
  }
}
