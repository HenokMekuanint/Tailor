class NearestTailorDetail {
  final int id;
  final String name;
  final String email;
  final String phone;
  final double rating;
  final String address;
  final String servicesSummary;
  final String userType;
  final double latitude;
  final double longitude;
  final String profilePicture;

  final List<Services>? services;
  final List<DropOffDates>? dropOffDates;
  final List<PickupDates>? pickupDates;

  NearestTailorDetail(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.rating,
      required this.address,
      required this.servicesSummary,
      required this.userType,
      required this.latitude,
      required this.longitude,
      this.services,
      this.dropOffDates,
      this.pickupDates,
      required this.profilePicture});

  factory NearestTailorDetail.fromJson(Map<String, dynamic> json) {
    return NearestTailorDetail(
        id: json['id'] ?? -1,
        name: json['name'] ?? 'No Tailor name',
        email: json['email'] ?? 'No Tailor email',
        phone: json['phone'] ?? '',
        rating: (json['rating'] as num).toDouble() ?? 0.0,
        address: json['address'] ?? 'No address',
        servicesSummary: json['services_summary'] ?? 'No services summary',
        userType: json['user_type'] ?? 'No user type',
        profilePicture: json['profile_picture'] ?? '',
        latitude: (json['latitude'] as num).toDouble() ?? 10.0,
        longitude: (json['longitude'] as num).toDouble() ?? 10.0,
        services: json['services'] != null
            ? (json['services'] as List)
                .map((i) => Services.fromJson(i))
                .toList()
            : null,
        dropOffDates: json['drop_off_dates'] != null
            ? (json['drop_off_dates'] as List)
                .map((i) => DropOffDates.fromJson(i))
                .toList()
            : null,
        pickupDates: json['pickup_dates'] != null
            ? (json['pickup_dates'] as List)
                .map((i) => PickupDates.fromJson(i))
                .toList()
            : null);
  }
}

class Services {
  final int id;
  final String name;
  final String description;
  final double price;
  final String? imageUrl;
  final int tailorId;
  final int categoryId;

  final Category category;

  Services(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      this.imageUrl,
      required this.tailorId,
      required this.categoryId,
      required this.category});

  factory Services.fromJson(Map<String, dynamic> json) {
    return Services(
        id: json['id'] ?? -1,
        name: json['name'] ?? 'No service name',
        description: json['description'] ?? 'No service description',
        price: (json['price'] as num).toDouble() ?? 0.0,
        imageUrl: json['image_url'],
        tailorId: json['tailor_id'] ?? -1,
        categoryId: json['category_id'] ?? -1,
        category: json['category'] != null
            ? Category.fromJson(json['category'])
            : Category(id: -1, name: 'No category name'));
  }
}

class Category {
  final int id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? -1,
      name: json['name'] ?? 'No category name',
    );
  }
}

class DropOffDates {
  final int id;
  final String dropOffDateTime;
  final int tailorId;

  DropOffDates({
    required this.id,
    required this.dropOffDateTime,
    required this.tailorId,
  });

  factory DropOffDates.fromJson(Map<String, dynamic> json) {
    return DropOffDates(
      id: json['id'] ?? -1,
      dropOffDateTime: json['dropOffDateTime'] ?? 'No drop off date time',
      tailorId: json['tailor_id'] ?? -1,
    );
  }
}

class PickupDates {
  final int id;
  final String pickUpDateTime;
  final int tailorId;

  PickupDates({
    required this.id,
    required this.pickUpDateTime,
    required this.tailorId,
  });

  factory PickupDates.fromJson(Map<String, dynamic> json) {
    return PickupDates(
      id: json['id'] ?? -1,
      pickUpDateTime: json['pickUpDateTime'] ?? 'No pick up date time',
      tailorId: json['tailor_id'] ?? -1,
    );
  }
}
