String employeeTable = 'employees.db';

class Employee {
  final int? id;
  final String fName;

  final String role;
  final int powerNap;

  const Employee({
    this.id,
    required this.fName,
    required this.role,
    required this.powerNap,
  });

  static Employee fromJson(Map<String, Object?> json) => Employee(
        id: json['employee_id'] as int?,
        fName: json['name'] as String,
        role: json['role'] as String,
        powerNap: json['power_nap'] as int,
      );

  Map<String, Object?> toJson() {
    return {
      'employee_id': id,
      'name': fName,
      'role': role,
      'power_nap': powerNap
    };
  }
}
