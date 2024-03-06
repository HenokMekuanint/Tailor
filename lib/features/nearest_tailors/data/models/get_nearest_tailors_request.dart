class GetNearestTailorsRequestModel {
  final double latitude;
  final double longitude;

  GetNearestTailorsRequestModel(
      {required this.latitude, required this.longitude});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
