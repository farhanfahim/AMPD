class ReportModel {
  int instanceId;
  int instanceType;
  int type;
  String description;
  int userId;
  int status;
  String updatedAt;
  String createdAt;
  int id;

  ReportModel(
      {this.instanceId,
        this.instanceType,
        this.type,
        this.description,
        this.userId,
        this.status,
        this.updatedAt,
        this.createdAt,
        this.id});

  ReportModel.fromJson(Map<String, dynamic> json) {
    instanceId = json['instance_id'];
    instanceType = json['instance_type'];
    type = json['type'];
    description = json['description'];
    userId = json['user_id'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['instance_id'] = this.instanceId;
    data['instance_type'] = this.instanceType;
    data['type'] = this.type;
    data['description'] = this.description;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}