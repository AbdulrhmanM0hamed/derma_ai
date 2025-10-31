import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';

class SymptomsDescriptionForm extends StatefulWidget {
  final String symptoms;
  final String additionalNotes;
  final Function(String) onSymptomsChanged;
  final Function(String) onNotesChanged;

  const SymptomsDescriptionForm({
    super.key,
    required this.symptoms,
    required this.additionalNotes,
    required this.onSymptomsChanged,
    required this.onNotesChanged,
  });

  @override
  State<SymptomsDescriptionForm> createState() => _SymptomsDescriptionFormState();
}

class _SymptomsDescriptionFormState extends State<SymptomsDescriptionForm> {
  final List<String> _commonSymptoms = [
    'طفح جلدي',
    'حكة',
    'احمرار',
    'تورم',
    'جفاف الجلد',
    'تقشر',
    'ألم',
    'حرقة',
    'تغير لون الجلد',
    'ظهور بقع',
    'تساقط الشعر',
    'تشقق الجلد',
  ];

  List<String> _selectedSymptoms = [];

  @override
  void initState() {
    super.initState();
    // Parse existing symptoms if any
    if (widget.symptoms.isNotEmpty) {
      _selectedSymptoms = widget.symptoms.split('، ').where((s) => s.isNotEmpty).toList();
    }
  }

  void _toggleSymptom(String symptom) {
    setState(() {
      if (_selectedSymptoms.contains(symptom)) {
        _selectedSymptoms.remove(symptom);
      } else {
        _selectedSymptoms.add(symptom);
      }
      widget.onSymptomsChanged(_selectedSymptoms.join('، '));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSymptomsSection(),
          const SizedBox(height: 24),
          _buildCustomSymptomsField(),
          const SizedBox(height: 24),
          _buildAdditionalNotesField(),
          const SizedBox(height: 20),
          _buildTipsSection(),
        ],
      ),
    );
  }

  Widget _buildSymptomsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.medical_information_outlined,
              color: AppColors.primary,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              'الأعراض الشائعة',
              style: getSemiBoldStyle(
                fontFamily: FontConstant.cairo,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'اختر الأعراض التي تعاني منها',
          style: getRegularStyle(
            fontFamily: FontConstant.cairo,
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _commonSymptoms.map((symptom) {
            final isSelected = _selectedSymptoms.contains(symptom);
            return _SymptomChip(
              symptom: symptom,
              isSelected: isSelected,
              onTap: () => _toggleSymptom(symptom),
            );
          }).toList(),
        ),
      ],
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3);
  }

  Widget _buildCustomSymptomsField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.edit_note_outlined,
              color: AppColors.primary,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              'وصف تفصيلي للأعراض',
              style: getSemiBoldStyle(
                fontFamily: FontConstant.cairo,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            Text(
              ' *',
              style: getSemiBoldStyle(
                fontFamily: FontConstant.cairo,
                fontSize: 16,
                color: Colors.red,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'اشرح الأعراض بالتفصيل، متى بدأت، وكيف تطورت',
          style: getRegularStyle(
            fontFamily: FontConstant.cairo,
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          initialValue: widget.symptoms,
          onChanged: widget.onSymptomsChanged,
          maxLines: 4,
          textAlign: TextAlign.right,
          style: getRegularStyle(
            fontFamily: FontConstant.cairo,
            fontSize: 16,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            hintText: 'مثال: بدأت الحكة منذ أسبوعين في منطقة اليدين، وظهر طفح جلدي أحمر مع تقشر...',
            hintStyle: getRegularStyle(
              fontFamily: FontConstant.cairo,
              fontSize: 14,
              color: Colors.grey[500],
            ),
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'يرجى وصف الأعراض';
            }
            if (value.trim().length < 10) {
              return 'يرجى إضافة وصف أكثر تفصيلاً';
            }
            return null;
          },
        ),
      ],
    ).animate().fadeIn(duration: 600.ms, delay: 100.ms).slideY(begin: 0.3);
  }

  Widget _buildAdditionalNotesField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.note_add_outlined,
              color: AppColors.primary,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              'ملاحظات إضافية',
              style: getSemiBoldStyle(
                fontFamily: FontConstant.cairo,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'أي معلومات إضافية قد تساعد الطبيب (اختيارية)',
          style: getRegularStyle(
            fontFamily: FontConstant.cairo,
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          initialValue: widget.additionalNotes,
          onChanged: widget.onNotesChanged,
          maxLines: 3,
          textAlign: TextAlign.right,
          style: getRegularStyle(
            fontFamily: FontConstant.cairo,
            fontSize: 16,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            hintText: 'مثال: لدي حساسية من بعض الأدوية، أو استخدمت كريمات معينة مؤخراً...',
            hintStyle: getRegularStyle(
              fontFamily: FontConstant.cairo,
              fontSize: 14,
              color: Colors.grey[500],
            ),
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideY(begin: 0.3);
  }

  Widget _buildTipsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb_outline,
                color: Colors.blue[700],
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                'نصائح لوصف أفضل',
                style: getSemiBoldStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: 14,
                  color: Colors.blue[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...const [
            '• اذكر متى بدأت الأعراض',
            '• وصف شدة الأعراض (خفيفة، متوسطة، شديدة)',
            '• اذكر أي عوامل تزيد أو تقلل من الأعراض',
            '• اذكر أي أدوية أو كريمات استخدمتها',
          ].map((tip) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              tip,
              style: getRegularStyle(
                fontFamily: FontConstant.cairo,
                fontSize: 12,
                color: Colors.blue[700],
              ),
            ),
          )),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 300.ms);
  }
}

class _SymptomChip extends StatelessWidget {
  final String symptom;
  final bool isSelected;
  final VoidCallback onTap;

  const _SymptomChip({
    required this.symptom,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected 
              ? AppColors.primary 
              : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected 
                ? AppColors.primary 
                : Colors.grey[300]!,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected)
              Icon(
                Icons.check,
                color: Colors.white,
                size: 16,
              ),
            if (isSelected) const SizedBox(width: 4),
            Text(
              symptom,
              style: getRegularStyle(
                fontFamily: FontConstant.cairo,
                fontSize: 14,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }
}
