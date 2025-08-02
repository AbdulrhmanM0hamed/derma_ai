import 'package:derma_ai/core/utils/common/custom_app_bar.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'data/mock_data.dart';
import 'logic/doctor_search_logic.dart';
import 'widgets/appointments_list_view.dart';
import 'widgets/doctors_list_view.dart';
import 'widgets/empty_state_widget.dart';
import 'widgets/favorites_list_view.dart';
import 'widgets/filter_bottom_sheet_widget.dart';
import 'widgets/filter_chips_widget.dart';
import 'widgets/location_permission_widget.dart';
import 'widgets/map_view.dart';
import 'widgets/search_bar_widget.dart';
import 'widgets/sort_options_widget.dart';

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
    doctors = MockDoctorData.getDoctors();
    filteredDoctors = List.from(doctors);
  }

  void _onSearchChanged(String query) {
    setState(() {
      filteredDoctors = DoctorSearchLogic.filterDoctors(doctors, query);
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
      activeFilters = DoctorSearchLogic.createFiltersList(filters);
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
      filteredDoctors = DoctorSearchLogic.sortDoctors(filteredDoctors, sortKey);
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
        appBar: CustomAppBar(
          elevation: 0,
          title: "البحث عن الأطباء",
          actions: [
            IconButton(
              onPressed: _toggleMapView,
              icon: Icon(isMapView ? Icons.list : Icons.map, size: 24),
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
              SizedBox(height: screenHeight * 0.01),
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
        ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2, end: 0),
        floatingActionButton: FloatingActionButton(
          onPressed: _showSortOptions,
          child: const Icon(Icons.sort, color: Colors.white, size: 24),
        ).animate().scale(duration: 400.ms, delay: 200.ms),
      ),
    );
  }

  Widget _buildDoctorsList() {
    if (isMapView) {
      return MapView(onToggleView: _toggleMapView);
    }

    if (filteredDoctors.isEmpty) {
      return EmptyStateWidget(onAdjustFilters: _showFilterBottomSheet);
    }

    return DoctorsListView(
      doctors: filteredDoctors,
      scrollController: _scrollController,
      onRefresh: _onRefresh,
      onDoctorTap: _onDoctorTap,
      onFavoriteToggle: _onFavoriteToggle,
      onShareDoctor: _onShareDoctor,
      onMessageDoctor: _onMessageDoctor,
    );
  }

  Widget _buildFavoritesList() {
    return FavoritesListView(
      doctors: doctors,
      onDoctorTap: _onDoctorTap,
      onFavoriteToggle: _onFavoriteToggle,
      onShareDoctor: _onShareDoctor,
      onMessageDoctor: _onMessageDoctor,
    );
  }

  Widget _buildAppointmentsList() {
    return AppointmentsListView(tabController: _tabController);
  }
}
