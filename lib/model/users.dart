class Users {

  int _id;
  String _name;
  String _password;
  String _phone_number;
  String _email;

  Users(this._name, this._phone_number,this._email, [this._password] );

  Users.withId(this._id, this._name, this._phone_number,this._email, [this._password]);

  int get id => _id;

  String get name => _name;

  String get password => _password;

  String get phone => _phone_number;

  String get email => _email;


  set name(String newTitle) {
    if (newTitle.length <= 255) {
      this._name = newTitle;
    }
  }
  set password(String newDescription) {
    if (newDescription.length <= 255) {
      this._password = newDescription;
    }
  }

  set phone(String newDate) {
    this._phone_number = newDate;
  }

  set email(String newDate) {
    this._email = newDate;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['password'] = _password;
    map['phone_number'] = _phone_number;
    map['email'] = _email;

    return map;
  }

  // Extract a Note object from a Map object
  Users.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._password = map['password'];
    this._phone_number = map['phone_number'];
    this._email = map['email'];
  }
}





