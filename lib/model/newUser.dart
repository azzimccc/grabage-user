class NewUser {
  int _id;
  String username;
  String password;

  NewUser(this.username, this.password);

  Map<String, dynamic> toMap() {
    return {
      'ID': this._id,
      'Username': this.username,
      'Password': this.password,
    };
  }
}
