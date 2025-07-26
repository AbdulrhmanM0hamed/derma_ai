
import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/utils/theme/app_colors.dart';

class ImagePreviewWidget extends StatefulWidget {
  final String imagePath;
  final VoidCallback onConfirm;
  final VoidCallback onRetake;

  const ImagePreviewWidget({
    Key? key,
    required this.imagePath,
    required this.onConfirm,
    required this.onRetake,
  }) : super(key: key);

  @override
  State<ImagePreviewWidget> createState() => _ImagePreviewWidgetState();
}

class _ImagePreviewWidgetState extends State<ImagePreviewWidget> {
  double _rotation = 0.0;
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        children: [
          // Preview Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.04, vertical: MediaQuery.of(context).size.height * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'معاينة الصورة',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                GestureDetector(
                  onTap: widget.onRetake,
                  child: Icon(
                    Icons.close,
                    color: AppColors.textPrimary,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),

          // Image Preview
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.04),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Transform.rotate(
                  angle: _rotation,
                  child: Transform.scale(
                    scale: _scale,
                    child: Image.file(
                      File(widget.imagePath),
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Edit Controls
          Container(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.04, vertical: MediaQuery.of(context).size.height * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildEditButton(
                  icon: 'rotate_right',
                  label: 'تدوير',
                  onTap: () {
                    setState(() {
                      _rotation += 1.5708; // 90 degrees in radians
                    });
                  },
                ),
                _buildEditButton(
                  icon: 'zoom_in',
                  label: 'تكبير',
                  onTap: () {
                    setState(() {
                      _scale = (_scale + 0.1).clamp(0.5, 3.0);
                    });
                  },
                ),
                _buildEditButton(
                  icon: 'zoom_out',
                  label: 'تصغير',
                  onTap: () {
                    setState(() {
                      _scale = (_scale - 0.1).clamp(0.5, 3.0);
                    });
                  },
                ),
                _buildEditButton(
                  icon: 'refresh',
                  label: 'إعادة تعيين',
                  onTap: () {
                    setState(() {
                      _rotation = 0.0;
                      _scale = 1.0;
                    });
                  },
                ),
              ],
            ),
          ),

          // Action Buttons
          Container(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.04, vertical: MediaQuery.of(context).size.height * 0.02),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: widget.onRetake,
                    child: Text(
                      'إعادة التقاط',
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                Expanded(
                  child: ElevatedButton(
                    onPressed: widget.onConfirm,
                    child: Text(
                      'تأكيد وتحليل',
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditButton({
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.border,
                width: 1,
              ),
            ),
            child: Icon(
              Icons.rotate_right,
              color: AppColors.textPrimary,
              size: 20,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.005),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: MediaQuery.of(context).size.width * 0.025,
            ),
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }
}
