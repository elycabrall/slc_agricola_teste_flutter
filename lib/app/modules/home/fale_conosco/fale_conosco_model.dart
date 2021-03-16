class FaleConoscoModel {
  String name;
  String email;
  String phone;
  String message;

  toMap() {
    return {"name": name, "email": email, "phone": phone, "message": message};
  }
}
