String pegaSaudacao() {
  var hour = DateTime.now().hour;
  var _msg = "";
  if (hour < 12) {
    _msg = "Bom dia,";
  } else {
    if (hour < 18) {
      _msg = "Boa tarde,";
    } else {
      _msg = "Boa noite,";
    }
  }

  return _msg;
}

String validateRequired(String text, String msg) {
  return text.isEmpty ? msg : null;
}
