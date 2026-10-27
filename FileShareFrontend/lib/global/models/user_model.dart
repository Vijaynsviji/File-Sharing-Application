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
      // Omit 'id' so SQLite's AUTOINCREMENT can do its job
      'name': name,
      'device_name': deviceName, // 👈 Match SQLite column
      'device_type': deviceType, // 👈 Match SQLite column
      'profile_image': profileImage, // 👈 Match SQLite column
      'bio': bio,
      'device_unique_id': deviceUniqueId, // 👈 Match SQLite column
      'created_at': createdAt
          .millisecondsSinceEpoch, // 👈 Convert DateTime to SQLite INTEGER
    };
  }

  Map<String, dynamic> toJson() {
    return {
      // Omit 'id' so SQLite's AUTOINCREMENT can do its job
      'id': id,
      'name': name,
      'device_name': deviceName, // 👈 Match SQLite column
      'device_type': deviceType, // 👈 Match SQLite column
      'profile_image': profileImage, // 👈 Match SQLite column
      'bio': bio,
      'device_unique_id': deviceUniqueId, // 👈 Match SQLite column
      'created_at': createdAt
          .millisecondsSinceEpoch, // 👈 Convert DateTime to SQLite INTEGER
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? deviceName,
    String? deviceType,
    String? profileImage,
    String? bio,
    String? deviceUniqueId,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      deviceName: deviceName ?? this.deviceName,
      deviceType: deviceType ?? this.deviceType,
      profileImage: profileImage ?? this.profileImage,
      bio: bio ?? this.bio,
      deviceUniqueId: deviceUniqueId ?? this.deviceUniqueId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  static User get dummy => User(
    id: "usr_94820a8f",
    name: "Alex Mercer",
    deviceName: "Alex's Pixel 8",
    deviceType: "Android",
    // Standard placeholder image or pass an empty string / base64 payload here
    profileImage: "lib/assets/images/img_1.jpeg",
    bio: "Sharing files at the speed of thought 🚀",
    deviceUniqueId: "3df9a8b1-7c2e-4b0f-ba14-5d9c8e7f12a3",
    createdAt: DateTime.now(),
  );

  factory User.fromMap(Map<String, Object?> map) {
    return User(
      // SQLite returns an int, convert it safely to your model's String type
      id: map['id'].toString(),

      name: map['name'] as String,

      deviceName: map['device_name'] as String, // 👈 Match SQLite column

      deviceType: map['device_type'] as String, // 👈 Match SQLite column

      profileImage: map['profile_image'] as String, // 👈 Match SQLite column

      bio: map['bio'] as String,

      deviceUniqueId:
          map['device_unique_id'] as String, // 👈 Match SQLite column
      // SQLite returns milliseconds (INTEGER), convert back to Dart DateTime
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
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
