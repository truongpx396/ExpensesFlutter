class IdValueModel {
  var id = 0;
  var value = '';
  IdValueModel({this.id, this.value});

  void fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return;
    }
    this.id = json['Id'] as int ?? 0;
    this.value = json['Value'] as String ?? '';
  }
}
