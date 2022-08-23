class PasswordCriteriaStatusModel {
  const PasswordCriteriaStatusModel({
    this.isEightCharactersOrMore = false,
    this.containsNumberAndLetter = false,
    this.containsUppercaseLetter = false,
    this.containsLowercaseLetter = false,
    this.containsSpecialCharacter = false,
  });

  final bool isEightCharactersOrMore;
  final bool containsNumberAndLetter;
  final bool containsUppercaseLetter;
  final bool containsLowercaseLetter;
  final bool containsSpecialCharacter;
}
