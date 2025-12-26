import 'package:flutter/material.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../data/models/video_call_package_model.dart';

class VideoCallPackageCard extends StatelessWidget {
  final VideoCallPackageModel package;
  final bool isSelected;
  final VoidCallback onTap;

  const VideoCallPackageCard({
    super.key,
    required this.package,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            _buildPricing(),
            const SizedBox(height: 16),
            _buildFeatures(),
            if (isSelected) ...[
              const SizedBox(height: 16),
              _buildSelectedIndicator(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected 
                ? AppColors.primary 
                : AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.videocam,
            color: isSelected ? Colors.white : AppColors.primary,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    package.name,
                    style: getBoldStyle(
                      fontFamily: FontConstant.cairo,
                      fontSize: 18,
                      color: isSelected ? AppColors.primary : Colors.black87,
                    ),
                  ),
                  if (package.isPopular) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'الأكثر طلباً',
                        style: getBoldStyle(
                          fontFamily: FontConstant.cairo,
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 4),
              Text(
                package.description,
                style: getRegularStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPricing() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected 
            ? AppColors.primary.withValues(alpha: 0.1) 
            : Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'مدة المكالمة',
                style: getRegularStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                package.formattedDuration,
                style: getBoldStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (package.originalPrice != null) ...[
                Row(
                  children: [
                    Text(
                      package.formattedOriginalPrice!,
                      style: getRegularStyle(
                        fontFamily: FontConstant.cairo,
                        fontSize: 12,
                        color: Colors.grey[500],
                      ).copyWith(
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'خصم ${package.discountPercentage}',
                        style: getBoldStyle(
                          fontFamily: FontConstant.cairo,
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
              ],
              Text(
                package.formattedPrice,
                style: getBoldStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: 20,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatures() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ما تشمله الباقة:',
          style: getSemiBoldStyle(
            fontFamily: FontConstant.cairo,
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        ...package.features.map((feature) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  feature,
                  style: getRegularStyle(
                    fontFamily: FontConstant.cairo,
                    fontSize: 13,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildSelectedIndicator() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            'تم اختيار هذه الباقة',
            style: getBoldStyle(
              fontFamily: FontConstant.cairo,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
