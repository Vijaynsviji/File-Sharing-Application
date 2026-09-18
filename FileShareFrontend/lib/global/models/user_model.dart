class User {
  final String id; // Changed from userId to id
  final String name;
  final String deviceName;
  final String deviceType;
  final String profileImage;
  final String bio;
  final String deviceUniqueId;
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.deviceName,
    required this.deviceType,
    required this.profileImage,
    required this.bio,
    required this.deviceUniqueId,
    required this.createdAt,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'deviceName': deviceName,
      'deviceType': deviceType,
      'profileImage': profileImage,
      'bio': bio,
      'deviceUniqueId': deviceUniqueId,
      'createdAt': createdAt,
    };
  }

  factory User.fromMap(Map<String, Object?> map) {

    return User(

      id: map['id'] as String,

      name: map['name'] as String,

      deviceName: map['deviceName'] as String,

      deviceType: map['deviceType'] as String,

      profileImage: map['profileImage'] as String,

      bio: map['bio'] as String,

      deviceUniqueId: map['deviceUniqueId'] as String,

      createdAt: map['createdAt'] is String

          ? DateTime.parse(map['createdAt'] as String)

          : map['createdAt'] as DateTime,

    );

  }



// 2. Static function to convert the List<Map> to a single User object

// (Assuming you want the first user from the database query result)

  static User fromList(List<Map<String, Object?>> list) {

    if (list.isEmpty) {

      throw Exception('No user found in the database list');

    }

    return User.fromMap(list.first);

  }

  // Implement toString to make it easier to see information about
  // each user when using the print statement.
  @override
  String toString() {
    return 'User{id: $id, name: $name, deviceName: $deviceName, bio: $bio, '
        'deviceType: $deviceType, deviceUniqueId: $deviceUniqueId, '
        'profileImage: $profileImage, createdAt: $createdAt}';
  }
}
