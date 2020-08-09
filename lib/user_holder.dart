import 'models/user.dart';

class UserHolder {
  Map<String, User> users = {};

  void registerUser(String name, String phone, String email) {
    User user = User(name: name, phone: phone, email: email);
    if (!users.containsKey(user.login)) {
      users[user.login] = user;
    } else {
      throw Exception("A user with this name alredy exists");
    }
  }

  User getUserByLogin(String login) {
    return users[login];
  }

  User registerUserByPhone(String fullName, String phone) {
    users.forEach((_, user) {
      if (user.phone == phone)
        throw Exception("A user with this phone already exists");
    });
    User user = User.byPhone(name: fullName, phone: phone);
    users[user.login] = user;
    return user;
  }

  User registerUserByEmail(String fullname, String email) {
    users.forEach((_, user) {
      if (user.email == email)
        throw Exception("A user with this email already exists");
    });

    User user = User.byEmail(name: fullname, email: email);
    users[user.login] = user;
    return user;
  }

  void setFriends(String login, List<User> friends) {
    User user = getUserByLogin(login);
    user.addFriends(friends);
  }

  User findUserInFriends(String login, User searchedFriend) {
    User user = getUserByLogin(login);
    int index = user.friends.indexWhere((friend) => friend == searchedFriend);
    print("INDEX: $index");
    if (index >= 0)
      return user.friends[index];
    else
      throw Exception("${user.login} is not a friend of the login");
  }

  void importUsers() {}
}
