mixin UserUtils {
  String capitalize(String str) =>
      str[0].toUpperCase() + str.substring(1).toLowerCase();
}

// extension MyString on String {
//   String capitalize() =>
//       this[0].toUpperCase() + this.substring(1).toLowerCase();
// }
