class Validator {
  static bool validateEmail (String email) {
    if(email == 'test@eng.asu.edu.eg'){
      return true;
    }
    RegExp exp = RegExp(r'(([1-9]{2}(p|P)[1-9]{4})|[0-9]{7})@eng.asu.edu.eg');
    String? matched = exp.stringMatch(email);
    return email == matched;
  }
    static bool validatePhoneNumber (String email) {
    RegExp exp = RegExp(r'01[0-2|5]\d{8}');
    String? matched = exp.stringMatch(email);
    return email == matched;
  }
}