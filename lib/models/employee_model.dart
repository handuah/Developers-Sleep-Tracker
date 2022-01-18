String employeeTable = 'employees.db';

class Employee {
  final int? id;
  final String fName;
  final String lName;
  final String role;
  final int age;
  final String gender;
  final int powerNap;

  const Employee({
    this.id,
    required this.fName,
    required this.lName,
    required this.role,
    required this.age,
    required this.gender,
    required this.powerNap,
  });

  static Employee fromJson(Map<String, Object?> json) => Employee(
        id: json['employee_id'] as int?,
        fName: json['first_name'] as String,
        lName: json['last_name'] as String,
        role: json['role'] as String,
        age: json['age'] as int,
        gender: json['gender'] as String,
        powerNap: json['sleep_count'] as int,
      );

  Map<String, Object?> toJson() {
    return {
      'employee_id': id,
      'first_name': fName,
      'last_name': lName,
      'role': role,
      'age': age,
      'gender': gender,
      'sleep_count': powerNap
    };
  }
}
