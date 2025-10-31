import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../core/utils/animations/app_animations.dart';
import '../widgets/patient_detail_card.dart';
import '../widgets/medical_history_widget.dart';
import '../widgets/treatment_plan_widget.dart';

class AdvancedPatientsPage extends StatefulWidget {
  const AdvancedPatientsPage({super.key});

  @override
  State<AdvancedPatientsPage> createState() => _AdvancedPatientsPageState();
}

class _AdvancedPatientsPageState extends State<AdvancedPatientsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';
  String _selectedFilter = 'الكل';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'إدارة المرضى المتقدمة',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _showAddPatientDialog(),
            icon: const Icon(Icons.person_add, color: Colors.white),
          ),
          IconButton(
            onPressed: () => _showSearchDialog(),
            icon: const Icon(Icons.search, color: Colors.white),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          isScrollable: true,
          tabs: const [
            Tab(text: 'جميع المرضى'),
            Tab(text: 'حالات نشطة'),
            Tab(text: 'متابعة'),
            Tab(text: 'مكتملة'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search and Filter Bar
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) => setState(() => _searchQuery = value),
                    decoration: InputDecoration(
                      hintText: 'البحث عن مريض...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.primary),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                PopupMenuButton<String>(
                  initialValue: _selectedFilter,
                  onSelected: (value) => setState(() => _selectedFilter = value),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.filter_list,
                      color: AppColors.primary,
                    ),
                  ),
                  itemBuilder: (context) => [
                    'الكل',
                    'أكزيما',
                    'حب الشباب',
                    'صدفية',
                    'التهاب جلدي',
                  ].map((filter) => PopupMenuItem(
                    value: filter,
                    child: Text(filter),
                  )).toList(),
                ),
              ],
            ),
          ),
          
          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAllPatientsTab(),
                _buildActiveCasesTab(),
                _buildFollowUpTab(),
                _buildCompletedTab(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "patients_fab",
        onPressed: () => _showAddPatientDialog(),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.person_add, color: Colors.white),
        label: const Text(
          'مريض جديد',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildAllPatientsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _filteredPatients.length,
      itemBuilder: (context, index) {
        final patient = _filteredPatients[index];
        return PatientDetailCard(
          patient: patient,
          onTap: () => _showPatientDetails(patient),
          onEdit: () => _editPatient(patient),
          onViewHistory: () => _viewMedicalHistory(patient),
        );
      },
    );
  }

  Widget _buildActiveCasesTab() {
    final activeCases = _filteredPatients.where((p) => p['status'] == 'نشط').toList();
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: activeCases.length,
      itemBuilder: (context, index) {
        final patient = activeCases[index];
        return PatientDetailCard(
          patient: patient,
          onTap: () => _showPatientDetails(patient),
          onEdit: () => _editPatient(patient),
          onViewHistory: () => _viewMedicalHistory(patient),
          showUrgentBadge: patient['severity'] == 'عالية',
        );
      },
    );
  }

  Widget _buildFollowUpTab() {
    final followUpCases = _filteredPatients.where((p) => p['status'] == 'متابعة').toList();
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: followUpCases.length,
      itemBuilder: (context, index) {
        final patient = followUpCases[index];
        return PatientDetailCard(
          patient: patient,
          onTap: () => _showPatientDetails(patient),
          onEdit: () => _editPatient(patient),
          onViewHistory: () => _viewMedicalHistory(patient),
          showFollowUpDate: true,
        );
      },
    );
  }

  Widget _buildCompletedTab() {
    final completedCases = _filteredPatients.where((p) => p['status'] == 'مكتمل').toList();
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: completedCases.length,
      itemBuilder: (context, index) {
        final patient = completedCases[index];
        return PatientDetailCard(
          patient: patient,
          onTap: () => _showPatientDetails(patient),
          onEdit: () => _editPatient(patient),
          onViewHistory: () => _viewMedicalHistory(patient),
          isCompleted: true,
        );
      },
    );
  }

  List<Map<String, dynamic>> get _filteredPatients {
    var patients = _allPatients;
    
    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      patients = patients.where((p) => 
        p['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
        p['condition'].toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }
    
    // Filter by condition
    if (_selectedFilter != 'الكل') {
      patients = patients.where((p) => p['condition'] == _selectedFilter).toList();
    }
    
    return patients;
  }

  void _showPatientDetails(Map<String, dynamic> patient) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              
              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.primary.withOpacity(0.1),
                      child: Text(
                        patient['name'][0],
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            patient['name'],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${patient['age']} سنة • ${patient['condition']}',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              
              // Content
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      MedicalHistoryWidget(patient: patient),
                      const SizedBox(height: 20),
                      TreatmentPlanWidget(patient: patient),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddPatientDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إضافة مريض جديد'),
        content: const SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'اسم المريض',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'العمر',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'رقم الهاتف',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'الحالة المرضية',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Add patient logic
            },
            child: const Text('إضافة'),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('البحث المتقدم'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'اسم المريض',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'الحالة المرضية',
                border: OutlineInputBorder(),
              ),
              items: ['الكل', 'أكزيما', 'حب الشباب', 'صدفية', 'التهاب جلدي']
                  .map((condition) => DropdownMenuItem(
                        value: condition,
                        child: Text(condition),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => _selectedFilter = value ?? 'الكل'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('بحث'),
          ),
        ],
      ),
    );
  }

  void _editPatient(Map<String, dynamic> patient) {
    // Edit patient logic
  }

  void _viewMedicalHistory(Map<String, dynamic> patient) {
    // View medical history logic
  }

  final List<Map<String, dynamic>> _allPatients = [
    {
      'name': 'فاطمة أحمد محمد',
      'age': '32',
      'condition': 'أكزيما',
      'severity': 'عالية',
      'status': 'نشط',
      'phone': '01234567890',
      'lastVisit': '2024-01-15',
      'nextAppointment': '2024-01-22',
      'notes': 'مريضة تعاني من أكزيما حادة، تحتاج متابعة دورية',
    },
    {
      'name': 'محمد علي حسن',
      'age': '45',
      'condition': 'صدفية',
      'severity': 'متوسطة',
      'status': 'متابعة',
      'phone': '01234567891',
      'lastVisit': '2024-01-10',
      'nextAppointment': '2024-01-25',
      'notes': 'تحسن ملحوظ مع العلاج الحالي',
    },
    {
      'name': 'سارة محمود أحمد',
      'age': '28',
      'condition': 'حب الشباب',
      'severity': 'منخفضة',
      'status': 'مكتمل',
      'phone': '01234567892',
      'lastVisit': '2024-01-05',
      'nextAppointment': null,
      'notes': 'تم الشفاء التام، لا حاجة لمتابعة',
    },
    {
      'name': 'أحمد حسن علي',
      'age': '38',
      'condition': 'التهاب جلدي',
      'severity': 'متوسطة',
      'status': 'نشط',
      'phone': '01234567893',
      'lastVisit': '2024-01-12',
      'nextAppointment': '2024-01-20',
      'notes': 'يحتاج تغيير في نوع الكريم المستخدم',
    },
  ];
}
