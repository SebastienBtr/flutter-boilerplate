class Name {
  Name({String firstName, String lastName}) {
    this.firstName = firstName ?? '';
    this.lastName = lastName ?? '';
    fullName = this.firstName + ' ' + this.lastName;
    fullNameReverse = this.lastName + ' ' + this.firstName;
  }
  
  String firstName;
  String lastName;
  // FirstName + LastName
  String fullName;
  // LastName + FirstName
  String fullNameReverse;
}
