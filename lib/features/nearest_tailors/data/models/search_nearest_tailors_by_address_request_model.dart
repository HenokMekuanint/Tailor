class SearchNearestTailorsByAddressRequestModel {
  final double latitude;
  final double longitude;
  final String queryString;

  SearchNearestTailorsByAddressRequestModel(
      {required this.latitude,
      required this.longitude,
      required this.queryString});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['query_string'] = queryString;
    return data;
  }
}
