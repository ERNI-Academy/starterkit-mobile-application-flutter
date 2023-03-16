abstract class RegularExpressions {
  static final RegExp email = RegExp(
    r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\])|(([a-zA-Z\-\d]+\.)+[a-zA-Z]{2,}))$',
  );

  static final RegExp nameRegex = RegExp(r'^[a-z A-Z,.\-]+$');

  static final RegExp password = RegExp(
    r'^(?=(.*[a-z])+)(?=(.*[A-Z])+)(?=(.*\d)+)(?=(.*[!@#$%^&*()\-__+.])+).{8,}$',
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
