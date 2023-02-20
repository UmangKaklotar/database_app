class  Employee {
  String? name;
  String? age;

  Employee(
    {
      required this.name,
      required this.age,
    }
  );

  Employee.fromMap(Map map) {
    name = map[name];
    age = map[age];
  }

  Map<String, dynamic> toMap() => {
    'name': name,
    'age': age,
  };

}