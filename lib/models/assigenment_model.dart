class AssigenmentModel {
  int? brightness10;
  int? brightness20;
  int? brightness30;
  int? lightOFF;
  int? lightON;

  AssigenmentModel(
      {this.brightness10,
      this.brightness20,
      this.brightness30,
      this.lightOFF,
      this.lightON});

  AssigenmentModel.fromJson(Map<String, dynamic> json) {
    brightness10 = json['Brightness_10'];
    brightness20 = json['Brightness_20'];
    brightness30 = json['Brightness_30'];
    lightOFF = json['Light_OFF'];
    lightON = json['Light_ON'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Brightness_10'] = this.brightness10;
    data['Brightness_20'] = this.brightness20;
    data['Brightness_30'] = this.brightness30;
    data['Light_OFF'] = this.lightOFF;
    data['Light_ON'] = this.lightON;
    return data;
  }
}
