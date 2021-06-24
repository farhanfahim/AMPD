class DeliveryInstructionsModel{
  int store_id;
  String description;

  DeliveryInstructionsModel(this.store_id, this.description);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['store_id'] = this.store_id;
    data['description'] = this.description;
    return data;
  }
}