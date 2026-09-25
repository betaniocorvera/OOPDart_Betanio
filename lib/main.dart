import 'dart:io';

class Person {
  String _name;
  int _age;

  Person(this._name, int age) : _age = 0 {
    this.age = age;
  }

  String get name => _name;
  int get age => _age;

  set age(int value) {
    if (value < 0) {
      throw ArgumentError('Age cannot be negative.');
    }
    _age = value;
  }

  String introduce() {
    return '$_name is $_age years old.';
  }
}

class Student extends Person {
  String _course;

  Student(String name, int age, this._course) : super(name, age);

  String get course => _course;

  @override
  String introduce() {
    return '${super.introduce()} They are a student taking $_course.';
  }
}

class Teacher extends Person {
  String _subject;

  Teacher(String name, int age, this._subject) : super(name, age);

  String get subject => _subject;

  @override
  String introduce() {
    return '${super.introduce()} They teach $_subject.';
  }
}

class Staff extends Person {
  String _subject;

  Staff(String name, int age, this._subject) : super(name, age);

  String get subject => _subject;

  @override
  String introduce() {
    return '${super.introduce()} They work in the $_subject department.';
  }
}

class School {
  final List<Person> _people = [];

  void addPerson(Person p) {
    _people.add(p);
  }

  void introduceAll() {
    for (final person in _people) {
      print(person.introduce());
    }
  }
}

String readNonEmptyString(String prompt) {
  while (true) {
    stdout.write(prompt);
    final input = stdin.readLineSync();
    if (input != null && input.trim().isNotEmpty) {
      return input.trim();
    }
    print('This field cannot be empty. Please try again.');
  }
}

int readInt(String prompt) {
  while (true) {
    stdout.write(prompt);
    final input = stdin.readLineSync();
    final parsed = input == null ? null : int.tryParse(input.trim());
    if (parsed != null) {
      return parsed;
    }
    print('Please enter a valid whole number.');
  }
}

int readNonNegativeInt(String prompt) {
  while (true) {
    final value = readInt(prompt);
    if (value >= 0) {
      return value;
    }
    print('Age cannot be negative. Please try again.');
  }
}

void main() {
  print('=== School Roster Builder ===\n');

  final numStudents = readNonNegativeInt('How many students would you like to add? ');
  final numTeachers = readNonNegativeInt('How many teachers would you like to add? ');
  final numStaff = readNonNegativeInt('How many staff members would you like to add? ');

  final school = School();

  for (var i = 1; i <= numStudents; i++) {
    print('\n--- Student $i of $numStudents ---');
    final name = readNonEmptyString('Name: ');
    final age = readNonNegativeInt('Age: ');
    final course = readNonEmptyString('Course: ');
    school.addPerson(Student(name, age, course));
  }

  for (var i = 1; i <= numTeachers; i++) {
    print('\n--- Teacher $i of $numTeachers ---');
    final name = readNonEmptyString('Name: ');
    final age = readNonNegativeInt('Age: ');
    final subject = readNonEmptyString('Subject: ');
    school.addPerson(Teacher(name, age, subject));
  }

  for (var i = 1; i <= numStaff; i++) {
    print('\n--- Staff Member $i of $numStaff ---');
    final name = readNonEmptyString('Name: ');
    final age = readNonNegativeInt('Age: ');
    final department = readNonEmptyString('Department: ');
    school.addPerson(Staff(name, age, department));
  }

  print('\n=== Introductions ===');
  school.introduceAll();


}

