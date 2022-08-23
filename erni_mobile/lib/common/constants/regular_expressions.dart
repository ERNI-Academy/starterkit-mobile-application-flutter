abstract class RegularExpressions {
  static final RegExp email = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  );

  static final RegExp nameRegex = RegExp(r'^[a-z A-Z,.\-]+$');

  static final RegExp password = RegExp(
    r'^(?=(.*[a-z]){1,})(?=(.*[A-Z]){1,})(?=(.*[0-9]){1,})(?=(.*[!@#$%^&*()\-__+.]){1,}).{8,}$',
  );

  static final RegExp numberAndLetter = RegExp(r'\S*\d+\S*');

  static final RegExp uppercase = RegExp('[A-Z]');

  static final RegExp lowercase = RegExp('[a-z]');

  static final RegExp specialChar = RegExp(
    r'[\^$*.\[\]{}()?\-"!@#%&/\,><:;_~`+='
    "'"
    ']',
  );
}
