class StringValueModel {
  var id = '';
  var value = '';

  StringValueModel({this.id, this.value});

  void fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return;
    }
    this.id = json['Id'] as String ?? '';
    this.value = json['Value'] as String ?? '';
  }
}
