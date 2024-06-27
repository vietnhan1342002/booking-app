// hotel model
import 'dart:math';

class Hotel {
  final String id;
  final String name;
  final String address;
  final List<Map<String, dynamic>> reviews;
  final String desc;
  final int nearby;
  final String contact;
  final List<String> amenities;
  final List<Map<String, dynamic>> rooms;
  final List<String> images;
  final List<String> imageUrls;

  Hotel({
    required this.id,
    required this.name,
    required this.address,
    required this.reviews,
    required this.desc,
    required this.nearby,
    required this.contact,
    required this.amenities,
    required this.rooms,
    required this.images,
    required this.imageUrls,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['_id'],
      name: json['name'],
      address: json['address'],
      reviews: List<Map<String, dynamic>>.from(json['reviews']),
      desc: json['desc'],
      nearby: json['nearby'],
      contact: json['contact'],
      amenities: List<String>.from(json['amenities']),
      rooms: List<Map<String, dynamic>>.from(json['rooms']),
      images: List<String>.from(
        json['images'].map((image) => image['url'] as String),
      ),
      imageUrls: List<String>.from(
        json['images'].map((image) => 'assets/uploads/${image['public_id']}'),
      ),
    );
  }

  double calculateAverageRating() {
    if (reviews.isEmpty) {
      return 0.0; // hoặc giá trị mặc định khác nếu bạn muốn
    }

    double totalRating = 0.0;

    for (var review in reviews) {
      totalRating += review['rating'];
    }

    return totalRating / reviews.length;
  }

  List<int> calculateRatingStats() {
    // Khởi tạo mảng thống kê với giá trị ban đầu là 0
    List<int> ratingStats = [0, 0, 0, 0, 0];

    // Lặp qua mỗi đánh giá và tăng giá trị tương ứng trong mảng thống kê
    for (var review in reviews) {
      if (review['rating'] is int) {
        int rating = review['rating'];

        // Giả sử rating nằm trong khoảng từ 1 đến 5
        if (rating >= 1 && rating <= 5) {
          ratingStats[rating - 1]++;
        }
      }
    }

    return ratingStats;
  }

  double getMinRoomPrice() {
    if (rooms.isEmpty) {
      return 0.0; // Hoặc giá trị mặc định khác nếu bạn muốn
    }

    double minPrice = double.infinity;

    for (var room in rooms) {
      if (room['priceRoom'] != null) {
        minPrice = min(minPrice, room['priceRoom'].toDouble());
      }
    }

    return minPrice;
  }
}
