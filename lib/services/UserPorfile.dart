class UserProfile {
  UserProfile();

  String _name;
  String _email;
  String _username;
  String _phoneNo;
  String _loginType;

  String get name => _name;
  String get email => _email;
  String get username => _username;
  String get loginType => _loginType;
  String get phoneNo => _phoneNo;

  setData({
    String name,
    String email,
    String username,
    String loginType,
    String phoneNo,
  }) {
    _name = name ?? _name;
    _email = email ?? _email;
    _username = username ?? _username;
    _phoneNo = phoneNo ?? _phoneNo;
    _username = username ?? _username;
  }
}
