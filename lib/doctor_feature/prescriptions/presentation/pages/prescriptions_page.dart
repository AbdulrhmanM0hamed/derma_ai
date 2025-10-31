import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../core/utils/animations/app_animations.dart';
import '../widgets/prescription_card.dart';
import '../widgets/medication_search_widget.dart';
import '../widgets/prescription_template_card.dart';

class PrescriptionsPage extends StatefulWidget {
  const PrescriptionsPage({super.key});

  @override
  State<PrescriptionsPage> createState() => _PrescriptionsPageState();
}

class _PrescriptionsPageState extends State<PrescriptionsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
          'إدارة الوصفات الطبية',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _showNewPrescriptionDialog(),
            icon: const Icon(Icons.add, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.white),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'الوصفات النشطة'),
            Tab(text: 'القوالب'),
            Tab(text: 'الأدوية'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildActivePrescriptionsTab(),
          _buildTemplatesTab(),
          _buildMedicationsTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "prescriptions_fab",
        onPressed: () => _showNewPrescriptionDialog(),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'وصفة جديدة',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildActivePrescriptionsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          PrescriptionCard(
            patientName: 'فاطمة أحمد محمد',
            patientAge: '32',
            condition: 'أكزيما تأتبية',
            prescriptionDate: '2024-01-15',
            medications: [
              {
                'name': 'هيدروكورتيزون كريم 1%',
                'dosage': 'مرتين يومياً',
                'duration': '14 يوم',
                'instructions': 'يطبق على المنطقة المصابة'
              },
              {
                'name': 'سيتريزين 10 مجم',
                'dosage': 'قرص واحد مساءً',
                'duration': '7 أيام',
                'instructions': 'يؤخذ مع الطعام'
              },
            ],
            onEdit: () {},
            onPrint: () {},
            onSend: () {},
          ),
          const SizedBox(height: 16),
          PrescriptionCard(
            patientName: 'محمد علي حسن',
            patientAge: '45',
            condition: 'صدفية',
            prescriptionDate: '2024-01-14',
            medications: [
              {
                'name': 'كالسيبوتريول مرهم',
                'dosage': 'مرة واحدة يومياً',
                'duration': '21 يوم',
                'instructions': 'يطبق طبقة رقيقة'
              },
              {
                'name': 'ميثوتريكسات 2.5 مجم',
                'dosage': '3 أقراص أسبوعياً',
                'duration': '12 أسبوع',
                'instructions': 'يؤخذ مع حمض الفوليك'
              },
            ],
            onEdit: () {},
            onPrint: () {},
            onSend: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildTemplatesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          PrescriptionTemplateCard(
            title: 'علاج الأكزيما الأساسي',
            description: 'قالب شامل لعلاج الأكزيما التأتبية',
            medicationsCount: 3,
            usageCount: 45,
            onUse: () {},
            onEdit: () {},
          ),
          const SizedBox(height: 12),
          PrescriptionTemplateCard(
            title: 'علاج حب الشباب',
            description: 'بروتوكول علاج حب الشباب المتوسط',
            medicationsCount: 4,
            usageCount: 32,
            onUse: () {},
            onEdit: () {},
          ),
          const SizedBox(height: 12),
          PrescriptionTemplateCard(
            title: 'علاج الصدفية',
            description: 'خطة علاج شاملة للصدفية',
            medicationsCount: 5,
            usageCount: 28,
            onUse: () {},
            onEdit: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationsTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: MedicationSearchWidget(
            onSearch: (query) {},
            onFilter: () {},
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _medications.length,
            itemBuilder: (context, index) {
              final medication = _medications[index];
              return _buildMedicationItem(medication);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMedicationItem(Map<String, dynamic> medication) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _getCategoryColor(medication['category']).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getCategoryIcon(medication['category']),
                  color: _getCategoryColor(medication['category']),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medication['name'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      medication['genericName'],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getCategoryColor(medication['category']).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  medication['category'],
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getCategoryColor(medication['category']),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'الجرعات المتاحة: ${medication['availableDoses'].join(', ')}',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'الاستخدامات: ${medication['indications']}',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          if (medication['warnings'] != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.warning_amber,
                    color: Colors.orange,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      medication['warnings'],
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    ).animate(effects: fadeInSlide());
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'مضاد حيوي':
        return Colors.red;
      case 'كورتيكوستيرويد':
        return Colors.orange;
      case 'مضاد هيستامين':
        return Colors.blue;
      case 'مرطب':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'مضاد حيوي':
        return Icons.medication;
      case 'كورتيكوستيرويد':
        return Icons.healing;
      case 'مضاد هيستامين':
        return Icons.vaccines;
      case 'مرطب':
        return Icons.water_drop;
      default:
        return Icons.medical_services;
    }
  }

  void _showNewPrescriptionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('وصفة طبية جديدة'),
        content: const Text('هل تريد إنشاء وصفة جديدة أم استخدام قالب موجود؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to template selection
            },
            child: const Text('استخدام قالب'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to new prescription
            },
            child: const Text('إنشاء جديدة'),
          ),
        ],
      ),
    );
  }

  final List<Map<String, dynamic>> _medications = [
    {
      'name': 'هيدروكورتيزون كريم 1%',
      'genericName': 'Hydrocortisone',
      'category': 'كورتيكوستيرويد',
      'availableDoses': ['0.5%', '1%', '2.5%'],
      'indications': 'الأكزيما، التهاب الجلد التماسي',
      'warnings': 'لا يستخدم لأكثر من أسبوعين متتاليين',
    },
    {
      'name': 'سيتريزين 10 مجم',
      'genericName': 'Cetirizine',
      'category': 'مضاد هيستامين',
      'availableDoses': ['5 مجم', '10 مجم'],
      'indications': 'الحساسية، الشرى، الأكزيما',
    },
    {
      'name': 'كلوتريمازول كريم',
      'genericName': 'Clotrimazole',
      'category': 'مضاد فطري',
      'availableDoses': ['1%'],
      'indications': 'الالتهابات الفطرية الجلدية',
    },
    {
      'name': 'مرطب سيتافيل',
      'genericName': 'Cetaphil Moisturizer',
      'category': 'مرطب',
      'availableDoses': ['100 مل', '250 مل', '500 مل'],
      'indications': 'ترطيب البشرة الجافة والحساسة',
    },
  ];
}
