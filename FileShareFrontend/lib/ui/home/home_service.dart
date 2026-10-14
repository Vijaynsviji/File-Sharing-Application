import 'package:storage_space/storage_space.dart';

Future<
  ({
    String totalSpace,
    String freeSpace,
    String usedSpace,
    double usedPercentage,
    bool isLowOnSpace,
  })
>
getStorageDetails() async {
  // Fetch space metrics (Optional threshold sets a flag if device space drops too low)
  StorageSpace space = await getStorageSpace(
    lowOnSpaceThreshold: 2 * 1024 * 1024 * 1024, // 2 GB Threshold
    fractionDigits: 2, // Round human-readable values to 2 decimal points
  );

  // Calculations
  int totalBytes = space.total;
  int freeBytes = space.free;
  int usedBytes = totalBytes - freeBytes;

  // Calculate usage percentage
  double usedPercentage = (usedBytes / totalBytes) * 100;

  return (
    totalSpace: space.totalSize, // E.g., "119.20 GB"
    freeSpace: space.freeSize, // E.g., "45.10 GB"
    usedSpace: "${(usedBytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB",
    usedPercentage: usedPercentage, // E.g., 62.16
    isLowOnSpace: space.lowOnSpace, // true / false
  );
}
