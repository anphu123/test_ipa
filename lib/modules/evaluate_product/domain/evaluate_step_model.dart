class EvaluateStepData {
  String? capacity;
  String? version;
  String? warranty;
  String? lockStatus;
  String? cloudStatus;
  String? batteryStatus;
  String? appearance;
  String? display;
  String? repair;
  String? screenRepair;
  List<Map<String, dynamic>> functionality = [];

  int capacityOffset = 0;
  int versionOffset = 0;
  int warrantyOffset = 0;
  int lockOffset = 0;
  int cloudOffset = 0;
  int batteryOffset = 0;
  int appearanceOffset = 0;
  int displayOffset = 0;
  int repairOffset = 0;
  int screenRepairOffset = 0;

  int get functionalityOffset =>
      functionality.fold(0, (sum, item) => sum + ((item['offset'] ?? 0) as int));

  int get totalOffset =>
      capacityOffset +
          versionOffset +
          warrantyOffset +
          lockOffset +
          cloudOffset +
          batteryOffset +
          appearanceOffset +
          displayOffset +
          repairOffset +
          screenRepairOffset +
          functionalityOffset;
}
