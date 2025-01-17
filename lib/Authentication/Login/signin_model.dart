class SignInModel {
  String? token;
  String? type;
  String? id;
  String? username;
  String? refreshToken;
  String? refreshTokenExpiry;
  List<String>? roles;

  SignInModel(
      {this.token,
      this.type,
      this.id,
      this.username,
      this.refreshToken,
      this.refreshTokenExpiry,
      this.roles});

  SignInModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    type = json['type'];
    id = json['id'];
    username = json['username'];
    refreshToken = json['refreshToken'];
    refreshTokenExpiry = json['refreshTokenExpiry'];
    roles = json['roles'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = token;
    data['type'] = type;
    data['id'] = id;
    data['username'] = username;
    data['refreshToken'] = refreshToken;
    data['refreshTokenExpiry'] = refreshTokenExpiry;
    data['roles'] = roles;
    return data;
  }
}
