class Transfer {
  final String id; // Changed from transferId to id
  final String peerId;
  final String direction;
  final String status;
  final DateTime createdAt;
  final DateTime? startedAt;
  final DateTime? completedAt;

  Transfer({
    required this.id,
    required this.peerId,
    required this.direction,
    required this.status,
    required this.createdAt,
    this.startedAt,
    this.completedAt,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'peerId': peerId,
      'direction': direction,
      'status': status,
      'createdAt': createdAt,
      'startedAt': startedAt,
      'completedAt': completedAt,
    };
  }

  // 1. Factory to convert a Map into a Transfer object
  factory Transfer.fromMap(Map<String, Object?> map) {
    return Transfer(
      id: map['id'] as String,
      peerId: map['peerId'] as String,
      direction: map['direction'] as String,
      status: map['status'] as String,
      // Handle SQLite DateTime parsing safely
      createdAt: map['createdAt'] is String
          ? DateTime.parse(map['createdAt'] as String)
          : map['createdAt'] as DateTime,
      startedAt: map['startedAt'] != null
          ? (map['startedAt'] is String
          ? DateTime.parse(map['startedAt'] as String)
          : map['startedAt'] as DateTime)
          : null,
      completedAt: map['completedAt'] != null
          ? (map['completedAt'] is String
          ? DateTime.parse(map['completedAt'] as String)
          : map['completedAt'] as DateTime)
          : null,
    );
  }

  // 2. Static function to convert a List<Map> to a single Transfer object
  static Transfer fromList(List<Map<String, Object?>> list) {
    if (list.isEmpty) {
      throw Exception('No transfer found in the database list');
    }
    return Transfer.fromMap(list.first);
  }

  // Implement toString to make it easier to see information about
  // each transfer when using the print statement.
  @override
  String toString() {
    return 'Transfer{id: $id, peerId: $peerId, direction: $direction, '
        'status: $status, createdAt: $createdAt, startedAt: $startedAt, '
        'completedAt: $completedAt}';
  }
}
