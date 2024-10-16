class MyUser {
  String? id;
  String? name;
  String? emailAddress;
  String? profileImageUrl; // Added this line

  MyUser({this.id, this.name, this.emailAddress, this.profileImageUrl});

  MyUser.fromFireStore(Map<String, dynamic>? data)
      : this(
          id: data?['id'],
          name: data?['fullName'],
          emailAddress: data?['emailAddress'],
          profileImageUrl: data?['profileImageUrl'], // Added this line
        );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'fullName': name,
      'emailAddress': emailAddress,
      'profileImageUrl': profileImageUrl, // Added this line
    };
  }
}
