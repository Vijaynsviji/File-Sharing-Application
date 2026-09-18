class PeerDevice {
  final String id;
  final String deviceUniqueId;
  final String name;
  final String deviceName;
  final String deviceType;
  final String profileImage;
  final String bio;
  final DateTime createdAt; // Added property

  PeerDevice({
    required this.id,
    required this.deviceUniqueId,
    required this.name,
    required this.deviceName,
    required this.deviceType,
    required this.profileImage,
    required this.bio,
    required this.createdAt,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'deviceUniqueId': deviceUniqueId,
      'name': name,
      'deviceName': deviceName,
      'deviceType': deviceType,
      'profileImage': profileImage,
      'bio': bio,
      'createdAt': createdAt,
    };
  }

  factory PeerDevice.fromMap(Map<String, Object?> map) {
    return PeerDevice(
      id: map['id'] as String,
      deviceUniqueId: map['deviceUniqueId'] as String,
      name: map['name'] as String,
      deviceName: map['deviceName'] as String,
      deviceType: map['deviceType'] as String,
      profileImage: map['profileImage'] as String,
      bio: map['bio'] as String,
      createdAt: map['createdAt'] is String
          ? DateTime.parse(map['createdAt'] as String)
          : map['createdAt'] as DateTime,
    );
  }

  static PeerDevice fromList(List<Map<String, Object?>> list) {
    if (list.isEmpty) {
      throw Exception('No peer device found in the database list');
    }
    return PeerDevice.fromMap(list.first);
  }

  // Implement toString to make it easier to see information about
  // each peer device when using the print statement.
  @override
  String toString() {
    return 'PeerDevice{id: $id, deviceUniqueId: $deviceUniqueId, name: $name, '
        'deviceName: $deviceName, deviceType: $deviceType, '
        'profileImage: $profileImage, bio: $bio}, createdAt: $createdAt}';
  }
}
