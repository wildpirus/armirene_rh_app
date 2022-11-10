class Employee {
  Employee({
    this.id,
    required this.email,
    required this.firstName,
    required this.secondName,
    required this.lastName,
    required this.secondLastName,
    required this.idType,
    required this.country,
    required this.idNumber,
    required this.firstDay,
    required this.area,
    required this.status,
    required this.registerDate,
  });

  int? id;
  final String email;
  final String firstName;
  final String secondName;
  final String lastName;
  final String secondLastName;
  final String idType;
  final String country;
  final String idNumber;
  final String firstDay;
  final String area;
  final String status;
  final String registerDate;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'lastName': lastName,
      'secondLastName': secondLastName,
      'idType': idType,
      'country': country,
      'idNumber': idNumber,
      'firstDay': firstDay,
      'area': area,
      'status': status,
      'registerDate': registerDate,
    };
  }

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
        id: json["id"] is int || json["id"] == null
            ? json["id"]
            : int.parse(json["id"]),
        email: json["email"],
        firstName: json["firstName"],
        secondName: json["secondName"],
        lastName: json["lastName"],
        secondLastName: json["secondLastName"],
        idType: json["idType"],
        country: json["country"],
        idNumber: json["idNumber"],
        firstDay: json["firstDay"],
        area: json["area"],
        status: json["status"],
        registerDate: json["registerDate"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['firstName'] = firstName;
    data['secondName'] = secondName;
    data['lastName'] = lastName;
    data['secondLastName'] = secondLastName;
    data['idType'] = idType;
    data['country'] = country;
    data['idNumber'] = idNumber;
    data['firstDay'] = firstDay;
    data['area'] = area;
    data['status'] = status;
    data['registerDate'] = registerDate;
    return data;
  }
}
