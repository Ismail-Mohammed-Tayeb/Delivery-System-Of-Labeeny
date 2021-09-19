final RegExp regexStrongPassword =
    RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,20}$");
final RegExp regexPhoneNumber =
    RegExp(r"^([0])([9])([3]|[4]|[5]|[6]|[9])\d{7}$");
