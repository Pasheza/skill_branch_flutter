import 'package:FlutterGalleryApp/string_utils.dart';

enum LoginType { email, phone }

class User {
  String email;
  String phone;
  String _lastName;
  String _firstName;

  LoginType _type;

  List<User> friends = <User>[];

  User._({String firstName, String lastName, String phone, String email})
      : _firstName = firstName,
        _lastName = lastName,
        this.phone = phone,
        this.email = email {
    print("User is created");
    _type = email != null ? LoginType.email : LoginType.phone;
  }

  User.byPhone({String name, String phone})
      : this._(
            firstName: _getFirstName(name),
            lastName: _getLastName(name),
            phone: checkPhone(phone),
            email: null);

  User.byEmail({String name, String email})
      : this._(
            firstName: _getFirstName(name),
            lastName: _getLastName(name),
            phone: null,
            email: checkEmail(email));

  factory User({String name, String phone, String email}) {
    if (name.isEmpty) throw Exception("User name is empty");
    if (phone == null && email == null)
      throw Exception("User phone and email are empty");
    if (phone == null && email != null)
      return User.byEmail(name: name, email: email);
    if (phone != null && email == null)
      return User.byPhone(name: name, phone: phone);

    return User._(
        firstName: _getFirstName(name),
        lastName: _getLastName(name),
        phone: checkPhone(phone),
        email: checkEmail(email));
  }

  static String _getLastName(String userName) => userName.split(" ")[1];
  static String _getFirstName(String userName) => userName.split(" ")[0];

  static String checkPhone(String phone) {
    String phonePattern = r"^(?:[+0])?[0-9]{11}";
    phone = phone.replaceAll(RegExp(r"[^+\d]"), "");
    if (phone == null || phone.isEmpty) {
      throw Exception("Enter don't empty phone number");
    } else if (!RegExp(phonePattern).hasMatch(phone)) {
      throw Exception(
          "Enter a valid phone number starting with a + and containing 11 digits");
    }
    return phone;
  }

  static String checkEmail(String email) {
    String emailPattern = r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)";
    if (email == null || email.isEmpty) {
      throw Exception("Enter not empty email");
    } else if (!RegExp(emailPattern).hasMatch(email)) {
      throw Exception("Enter valid email");
    }
    return email;
  }

  String get login {
    if (_type == LoginType.phone)
      return phone;
    else
      return email;
  }

  String get name => _firstName.capitalize() + " " + _lastName.capitalize();

  @override
  bool operator ==(Object object) {
    if (object == null) return false;
    if (object is User) {
      return _firstName == object._firstName &&
          _lastName == object._lastName &&
          (phone == object.phone || email == object.email);
    }
  }

  void addFriends(Iterable<User> newFriends) {
    friends.addAll(newFriends);
  }

  void removeFriend(User user) {
    friends.remove(user);
  }

  String get userInfo => '''
    name: $name
    email: $email
    firstName: $_firstName
    lastname: $_lastName
    friends: ${friends.toList()}
  ''';

  @override
  String toString() {
    return '''
    name: $name
    email: $email
    friends: ${friends.toList()}
  ''';
  }
}
