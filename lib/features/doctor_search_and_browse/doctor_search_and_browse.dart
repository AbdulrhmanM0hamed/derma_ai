import 'package:derma_ai/core/utils/common/custom_button.dart';
import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './widgets/doctor_card_widget.dart';
import './widgets/empty_state_widget.dart';
import './widgets/filter_bottom_sheet_widget.dart';
import './widgets/filter_chips_widget.dart';
import './widgets/location_permission_widget.dart';
import './widgets/search_bar_widget.dart';
import './widgets/sort_options_widget.dart';

class DoctorSearchAndBrowse extends StatefulWidget {
  const DoctorSearchAndBrowse({super.key});

  @override
  State<DoctorSearchAndBrowse> createState() => DoctorSearchAndBrowseState();
}

class DoctorSearchAndBrowseState extends State<DoctorSearchAndBrowse>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Map<String, dynamic>> doctors = [];
  List<Map<String, dynamic>> filteredDoctors = [];
  List<Map<String, dynamic>> activeFilters = [];
  bool isLoading = false;
  bool showLocationPermission = true;
  bool isMapView = false;
  String currentSort = "nearest";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadMockData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMockData() {
    doctors = [
      {
        "id": 1,
        "nameArabic": "د. أحمد محمد الشريف",
        "nameEnglish": "Dr. Ahmed Mohammed Al-Sharif",
        "specialtyArabic": "أمراض جلدية وتناسلية",
        "profileImage":
            "https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=400&h=400&fit=crop&crop=face",
        "rating": 4.8,
        "reviewCount": 127,
        "distance": 2.3,
        "nextAvailable": "اليوم 3:30 م",
        "consultationFee": "250 ريال",
        "isFavorite": false,
      },

      {
        "id": 2,
        "nameArabic": "د. فاطمة علي الزهراني",
        "nameEnglish": "Dr. Fatima Ali Al-Zahrani",
        "specialtyArabic": "جراحة تجميلية وترميمية",
        "profileImage":
            "https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=400&h=400&fit=crop&crop=face",
        "rating": 4.9,
        "reviewCount": 203,
        "distance": 1.8,
        "nextAvailable": "غداً 10:00 ص",
        "consultationFee": "400 ريال",
        "isFavorite": true,
      },

      {
        "id": 3,
        "nameArabic": "د. محمد عبدالله القحطاني",
        "nameEnglish": "Dr. Mohammed Abdullah Al-Qahtani",
        "specialtyArabic": "أمراض الشعر والصلع",
        "profileImage":
            "https://images.unsplash.com/photo-1582750433449-648ed127bb54?w=400&h=400&fit=crop&crop=face",
        "rating": 4.7,
        "reviewCount": 89,
        "distance": 4.1,
        "nextAvailable": "الأحد 2:00 م",
        "consultationFee": "300 ريال",
        "isFavorite": false,
      },
      {
        "id": 4,
        "nameArabic": "د. سارة خالد المطيري",
        "nameEnglish": "Dr. Sarah Khalid Al-Mutairi",
        "specialtyArabic": "الأمراض الجلدية للأطفال",
        "profileImage":
            "https://images.unsplash.com/photo-1594824475317-1ad8b1b9c9e1?w=400&h=400&fit=crop&crop=face",
        "rating": 4.6,
        "reviewCount": 156,
        "distance": 3.7,
        "nextAvailable": "الثلاثاء 11:30 ص",
        "consultationFee": "200 ريال",
        "isFavorite": false,
      },
      {
        "id": 5,
        "nameArabic": "د. عبدالرحمن سعد العتيبي",
        "nameEnglish": "Dr. Abdulrahman Saad Al-Otaibi",
        "specialtyArabic": "علاج بالليزر والتقشير",
        "profileImage":
            "https://images.unsplash.com/photo-1607990281513-2c110a25bd8c?w=400&h=400&fit=crop&crop=face",
        "rating": 4.5,
        "reviewCount": 94,
        "distance": 5.2,
        "nextAvailable": "الخميس 4:00 م",
        "consultationFee": "350 ريال",
        "isFavorite": false,
      },
    ];
    filteredDoctors = List.from(doctors);
  }

  void _onSearchChanged(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredDoctors = List.from(doctors);
      } else {
        filteredDoctors =
            doctors.where((doctor) {
              return (doctor["nameArabic"] as String).toLowerCase().contains(
                    query.toLowerCase(),
                  ) ||
                  (doctor["nameEnglish"] as String).toLowerCase().contains(
                    query.toLowerCase(),
                  ) ||
                  (doctor["specialtyArabic"] as String).toLowerCase().contains(
                    query.toLowerCase(),
                  );
            }).toList();
      }
    });
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => FilterBottomSheetWidget(onApplyFilters: _applyFilters),
    );
  }

  void _applyFilters(Map<String, dynamic> filters) {
    setState(() {
      activeFilters.clear();

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
    });

    _filterDoctors();
  }

  void _filterDoctors() {
    setState(() {
      filteredDoctors = List.from(doctors);
      // Apply actual filtering logic here based on activeFilters
    });
  }

  void _removeFilter(int index) {
    setState(() {
      activeFilters.removeAt(index);
    });
    _filterDoctors();
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => SortOptionsWidget(onSortSelected: _applySorting),
    );
  }

  void _applySorting(String sortKey) {
    setState(() {
      currentSort = sortKey;
      switch (sortKey) {
        case "nearest":
          filteredDoctors.sort(
            (a, b) =>
                (a["distance"] as double).compareTo(b["distance"] as double),
          );
          break;
        case "rating":
          filteredDoctors.sort(
            (a, b) => (b["rating"] as double).compareTo(a["rating"] as double),
          );
          break;
        case "price":
          filteredDoctors.sort((a, b) {
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
          // Sort by availability logic
          break;
      }
    });
  }

  void _onDoctorTap(Map<String, dynamic> doctor) {
    Navigator.pushNamed(context, '/doctor-profile', arguments: doctor);
  }

  void _onFavoriteToggle(Map<String, dynamic> doctor) {
    setState(() {
      doctor["isFavorite"] = !(doctor["isFavorite"] as bool);
    });
    HapticFeedback.lightImpact();
  }

  void _onShareDoctor(Map<String, dynamic> doctor) {
    // Implement share functionality
    HapticFeedback.lightImpact();
  }

  void _onMessageDoctor(Map<String, dynamic> doctor) {
    // Implement direct message functionality
    HapticFeedback.lightImpact();
  }

  void _onAllowLocation() {
    setState(() {
      showLocationPermission = false;
    });
    HapticFeedback.lightImpact();
  }

  void _onSkipLocation() {
    setState(() {
      showLocationPermission = false;
    });
  }

  void _toggleMapView() {
    setState(() {
      isMapView = !isMapView;
    });
    HapticFeedback.lightImpact();
  }

  Future<void> _onRefresh() async {
    HapticFeedback.lightImpact();
    setState(() {
      isLoading = true;
    });

    // Simulate network call
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        appBar: AppBar(
          backgroundColor: AppColors.cardBackground,
          elevation: 0,
          title: Text(
            "البحث عن الأطباء",
            style: getBoldStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontFamily: FontConstant.cairo,
            ),
          ),
          actions: [
            IconButton(
              onPressed: _toggleMapView,
              icon: Icon(
                isMapView ? Icons.list : Icons.map,
                color: AppColors.textPrimary,
                size: 24,
              ),
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.primary,
            labelStyle: getSemiBoldStyle(
              color: AppColors.primary,
              fontSize: 14,
              fontFamily: FontConstant.cairo,
            ),
            unselectedLabelStyle: getRegularStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              fontFamily: FontConstant.cairo,
            ),
            tabs: [
              Tab(text: "الأطباء"),
              Tab(text: "المفضلة"),
              Tab(text: "مواعيدي"),
            ],
          ),
        ),
        body: Column(
          children: [
            SearchBarWidget(
              controller: _searchController,
              onFilterTap: _showFilterBottomSheet,
              onSearchChanged: _onSearchChanged,
            ),
            if (activeFilters.isNotEmpty) ...[
              SizedBox(height: screenHeight * 0.02),
              FilterChipsWidget(
                activeFilters: activeFilters,
                onRemoveFilter: _removeFilter,
              ),
            ],
            if (showLocationPermission) ...[
              SizedBox(height: screenHeight * 0.02),
              LocationPermissionWidget(
                onAllowLocation: _onAllowLocation,
                onSkip: _onSkipLocation,
              ),
            ],
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildDoctorsList(),
                  _buildFavoritesList(),
                  _buildAppointmentsList(),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showSortOptions,
          child: Icon(Icons.sort, color: Colors.white, size: 24),
        ),
      ),
    );
  }

  Widget _buildDoctorsList() {
    final screenHeight = MediaQuery.of(context).size.height;
    if (isMapView) {
      return _buildMapView();
    }

    if (filteredDoctors.isEmpty) {
      return EmptyStateWidget(onAdjustFilters: _showFilterBottomSheet);
    }
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.only(bottom: screenHeight * 0.2),
        itemCount: filteredDoctors.length,
        itemBuilder: (context, index) {
          final doctor = filteredDoctors[index];
          return DoctorCardWidget(
            doctor: doctor,
            onTap: () => _onDoctorTap(doctor),
            onFavorite: () => _onFavoriteToggle(doctor),
            onShare: () => _onShareDoctor(doctor),
            onMessage: () => _onMessageDoctor(doctor),
          );
        },
      ),
    );
  }

  Widget _buildFavoritesList() {
    final screenHeight = MediaQuery.of(context).size.height;
    final favoriteDoctors =
        doctors.where((doctor) => doctor["isFavorite"] as bool).toList();

    if (favoriteDoctors.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              color: AppColors.textSecondary,
              size: MediaQuery.of(context).size.width * 0.2,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Text(
              "لا توجد أطباء مفضلين",
              style: getBoldStyle(
                color: AppColors.textPrimary,
                fontSize: 24,
                fontFamily: FontConstant.cairo,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Text(
              "أضف الأطباء إلى المفضلة لسهولة الوصول إليهم",
              style: getRegularStyle(
                color: AppColors.textSecondary,
                fontSize: 16,
                fontFamily: FontConstant.cairo,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.only(bottom: screenHeight * 0.2),
      itemCount: favoriteDoctors.length,
      itemBuilder: (context, index) {
        final doctor = favoriteDoctors[index];
        return DoctorCardWidget(
          doctor: doctor,
          onTap: () => _onDoctorTap(doctor),
          onFavorite: () => _onFavoriteToggle(doctor),
          onShare: () => _onShareDoctor(doctor),
          onMessage: () => _onMessageDoctor(doctor),
        );
      },
    );
  }

  Widget _buildAppointmentsList() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_today,
            color: AppColors.textSecondary,
            size: MediaQuery.of(context).size.width * 0.2,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          Text(
            "لا توجد حجوزات",
            style: getBoldStyle(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontFamily: FontConstant.cairo,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Text(
            "احجز موعدك الأول مع أحد الأطباء المتخصصين",
            style: getRegularStyle(
              color: AppColors.textSecondary,
              fontSize: 16,
              fontFamily: FontConstant.cairo,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          ElevatedButton(
            onPressed: () => _tabController.animateTo(0),
            child: Text("تصفح الأطباء"),
          ),
        ],
      ),
    );
  }

  Widget _buildMapView() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.cardBackground,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.map,
              color: AppColors.primary,
              size: MediaQuery.of(context).size.width * 0.2,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Text(
              "عرض الخريطة",
              style: getBoldStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontFamily: FontConstant.cairo,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Text(
              "سيتم عرض مواقع الأطباء على الخريطة هنا",
              style: getRegularStyle(
                color: AppColors.textSecondary,
                fontSize: 16,
                fontFamily: FontConstant.cairo,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            CustomButton(onPressed: _toggleMapView, text: "العودة للقائمة"),
          ],
        ),
      ),
    );
  }
}
