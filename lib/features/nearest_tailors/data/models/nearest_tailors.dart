class NearestTailors {
  bool? status;
  String? message;
  List<NearestTailorData>? nearestTailors;

  NearestTailors({this.status, this.message, this.nearestTailors});

  NearestTailors.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      nearestTailors = <NearestTailorData>[];
      json['data'].forEach((v) {
        nearestTailors?.add(NearestTailorData.fromJson(v));
      });
    }
  }
}

class NearestTailorData {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String servicesSummary;
  final double latitude;
  final double longitude;
  final double distance;
  final String address;
  final String profilePicture;

  NearestTailorData(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.servicesSummary,
      required this.latitude,
      required this.longitude,
      required this.distance,
      required this.address,
      required this.profilePicture});

  factory NearestTailorData.fromJson(Map<String, dynamic> json) {
    return NearestTailorData(
        id: json['id'] ?? -1,
        name: json['name'] ?? 'No Tailor name',
        email: json['email'] ?? 'No Tailor email',
        phone: json['phone'] ?? '',
        servicesSummary: json['services_summary'] ?? 'No services summary',
        latitude: (json['latitude'] as num?)?.toDouble() ?? 10.0,
        longitude: (json['longitude'] as num?)?.toDouble() ?? 10.0,
        address: json['address'] ?? 'No address',
        distance: (json['distance'] as num?)?.toDouble() ?? 100.0,
        profilePicture: json['profile_picture'] ?? '');
  }
}
