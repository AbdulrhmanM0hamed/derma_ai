import 'package:flutter/material.dart';

class DoctorSearchLogic {
  static List<Map<String, dynamic>> filterDoctors(
    List<Map<String, dynamic>> doctors,
    String searchQuery,
  ) {
    if (searchQuery.isEmpty) {
      return List.from(doctors);
    }

    return doctors.where((doctor) {
      return (doctor["nameArabic"] as String).toLowerCase().contains(
            searchQuery.toLowerCase(),
          ) ||
          (doctor["nameEnglish"] as String).toLowerCase().contains(
            searchQuery.toLowerCase(),
          ) ||
          (doctor["specialtyArabic"] as String).toLowerCase().contains(
            searchQuery.toLowerCase(),
          );
    }).toList();
  }

  static List<Map<String, dynamic>> sortDoctors(
    List<Map<String, dynamic>> doctors,
    String sortOption,
  ) {
    List<Map<String, dynamic>> sortedDoctors = List.from(doctors);

    switch (sortOption) {
      case "nearest":
        sortedDoctors.sort(
          (a, b) =>
              (a["distance"] as double).compareTo(b["distance"] as double),
        );
        break;
      case "rating":
        sortedDoctors.sort(
          (a, b) => (b["rating"] as double).compareTo(a["rating"] as double),
        );
        break;
      case "price":
        sortedDoctors.sort((a, b) {
          final priceA = int.parse(
            (a["consultationFee"] as String).replaceAll(RegExp(r'[^\d]'), ''),
          );
          final priceB = int.parse(
            (b["consultationFee"] as String).replaceAll(RegExp(r'[^\d]'), ''),
          );
          return priceA.compareTo(priceB);
        });
        break;
      case "availability":
        // Sort by availability logic can be implemented here
        break;
    }

    return sortedDoctors;
  }

  static List<Map<String, dynamic>> applyFilters(
    List<Map<String, dynamic>> doctors,
    List<Map<String, dynamic>> activeFilters,
  ) {
    List<Map<String, dynamic>> filteredDoctors = List.from(doctors);
    
    // Apply actual filtering logic here based on activeFilters
    // This is a simplified implementation for design phase
    
    return filteredDoctors;
  }

  static List<Map<String, dynamic>> createFiltersList(
    Map<String, dynamic> filters,
  ) {
    List<Map<String, dynamic>> activeFilters = [];

    if (filters["specialty"] != null &&
        (filters["specialty"] as String).isNotEmpty &&
        filters["specialty"] != "جميع التخصصات") {
      activeFilters.add({"label": filters["specialty"], "type": "specialty"});
    }

    if (filters["locationRadius"] != null &&
        (filters["locationRadius"] as double) < 50.0) {
      activeFilters.add({
        "label": "${(filters["locationRadius"] as double).round()} كم",
        "type": "location",
      });
    }

    if (filters["availability"] != null &&
        (filters["availability"] as String).isNotEmpty &&
        filters["availability"] != "جميع الأوقات") {
      activeFilters.add({
        "label": filters["availability"],
        "type": "availability",
      });
    }

    if (filters["minRating"] != null &&
        (filters["minRating"] as double) > 0) {
      activeFilters.add({
        "label": "${(filters["minRating"] as double).round()} نجوم+",
        "type": "rating",
      });
    }

    final priceRange = filters["priceRange"] as RangeValues;
    if (priceRange.start > 50 || priceRange.end < 1000) {
      activeFilters.add({
        "label": "${priceRange.start.round()}-${priceRange.end.round()} ريال",
        "type": "price",
      });
    }

    return activeFilters;
  }
}
