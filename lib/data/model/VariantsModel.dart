class VariantsModel{
  int id;
  String displayName;
  String variant_display_name;
  bool isSelected = false;

  VariantsModel({this.id, this.displayName, this.variant_display_name});

  VariantsModel.fromJson(Map<String, dynamic> json) {
    id = json['variant_id'];
    displayName = json['variant_name'];
    variant_display_name = json['variant_display_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variant_id'] = this.id;
    data['variant_name'] = this.displayName;
    return data;
  }
}