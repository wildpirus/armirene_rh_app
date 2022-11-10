generateEmail(
    int countEmail, String country, String firstName, String lastName) {
  String domain = country == "Colombia" ? "armirene.com.co" : "armirene.com.us";
  String email;
  if (countEmail > 0) {
    email = "$firstName.$lastName.$countEmail@$domain";
  } else {
    email = "$firstName.$lastName@$domain";
  }

  return email;
}
