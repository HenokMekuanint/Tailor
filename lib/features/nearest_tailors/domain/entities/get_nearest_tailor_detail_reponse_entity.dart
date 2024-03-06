class NearestTailorDetailEntity {
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

  final List<ServicesEntity>? servicesEntity;
  final List<DropOffDatesEntity>? dropOffDatesEntity;
  final List<PickupDatesEntity>? pickupDatesEntity;

  NearestTailorDetailEntity(
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
      this.servicesEntity,
      this.dropOffDatesEntity,
      this.pickupDatesEntity});
}

class ServicesEntity {
  final int id;
  final String name;
  final String description;
  final double price;
  final String? imageUrl;
  final int tailorId;
  final int categoryId;

  final Category category;

  ServicesEntity(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      this.imageUrl,
      required this.tailorId,
      required this.categoryId,
      required this.category});
}

class Category {
  final int id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });
}

class DropOffDatesEntity {
  final int id;
  final String dropOffDateTime;
  final int tailorId;

  DropOffDatesEntity({
    required this.id,
    required this.dropOffDateTime,
    required this.tailorId,
  });
}

class PickupDatesEntity {
  final int id;
  final String pickUpDateTime;
  final int tailorId;

  PickupDatesEntity({
    required this.id,
    required this.pickUpDateTime,
    required this.tailorId,
  });
}
