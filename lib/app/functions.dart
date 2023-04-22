String generateCountryFlag() {
  String countryCode = 'eg';

  return countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
      (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
}

String? validatePhoneNumber(String? value) {
  if (value!.isEmpty) {
    return 'Please enter your phone number';
  } else if (value.length != 11) {
    return 'Phone Number must be of 11 digit';
  } else {
    return null;
  }
}
