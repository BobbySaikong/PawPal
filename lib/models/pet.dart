class MyPets {
  String? petId;
  String? userId;
  String? petName;
  String? petType;
  String? petCategory;
  String? petDescription;
  // String? serviceType;
  // String? serviceRate;
  // String? serviceDate;

  // Added user info
  String? userName;
  String? userEmail;
  String? userPhone;
  String? userRegdate;

  MyPets({
    this.petId,
    this.userId,
    this.petName,
    this.petType,
    this.petDescription,
    this.petCategory,

    // this.serviceType,
    // this.serviceRate,
    // this.serviceDate,
    this.userName,
    this.userEmail,
    this.userPhone,
    this.userRegdate,
  });

  MyPets.fromJson(Map<String, dynamic> json) {
    petId = json['pet_id'];
    userId = json['user_id'];
    petName = json['pet_name'];
    petType = json['pet_type'];
    petDescription = json['pet_description'];
    petCategory = json['pet_category'];
    // serviceType = json['service_type'];
    // serviceRate = json['service_rate'];
    // serviceDate = json['service_date'];

    // Mapping user fields
    userName = json['user_name'];
    userEmail = json['user_email'];
    userPhone = json['user_phone'];
    userRegdate = json['user_regdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pet_id'] = petId;
    data['user_id'] = userId;
    data['pet_name'] = petName;
    data['pet_type'] = petType;
    data['pet_description'] = petDescription;
    data['pet_category'] = petCategory;
    // data['service_type'] = serviceType;
    // data['service_rate'] = serviceRate;
    // data['service_date'] = serviceDate;

    data['user_name'] = userName;
    data['user_email'] = userEmail;
    data['user_phone'] = userPhone;
    data['user_regdate'] = userRegdate;

    return data;
  }
}
