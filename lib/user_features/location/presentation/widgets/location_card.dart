import 'package:flutter/material.dart';
import '../../data/models/location_model.dart';

enum CardStyle { square, rectangular }

class LocationCard extends StatelessWidget {
  final LocationModel location;
  final bool isSelected;
  final VoidCallback onTap;
  final CardStyle style;

  const LocationCard({
    super.key,
    required this.location,
    required this.isSelected,
    required this.onTap,
    this.style = CardStyle.square,
  });

  @override
  Widget build(BuildContext context) {
    return style == CardStyle.square
        ? _buildSquareCard(context)
        : _buildRectangularCard(context);
  }

  Widget _buildSquareCard(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
              spreadRadius: 0,
            ),
            if (isSelected)
              BoxShadow(
                color: const Color(0xFF2366C4).withValues(alpha: 0.25),
                blurRadius: 12,
                offset: const Offset(0, 4),
                spreadRadius: 1,
              ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Stack(
            children: [
              // Background Image
              if (location.image != null && location.image!.isNotEmpty)
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(location.image!),
                      fit: BoxFit.cover,
                      onError: (exception, stackTrace) {},
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.15),
                          Colors.black.withValues(alpha: 0.45),
                        ],
                      ),
                    ),
                  ),
                )
              else
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF2366C4).withValues(alpha: 0.85),
                        const Color(0xFF025396).withValues(alpha: 0.95),
                      ],
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.25),
                        ],
                      ),
                    ),
                  ),
                ),

              // Content
              Positioned.fill(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Section - Location Name
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            location.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),

                      // Bottom Section - Selection Indicator
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            color: isSelected
                                ? Colors.white
                                : Colors.transparent,
                            boxShadow: [
                              if (isSelected)
                                BoxShadow(
                                  color: Colors.white.withValues(alpha: 0.4),
                                  blurRadius: 6,
                                  spreadRadius: 0.5,
                                ),
                            ],
                          ),
                          child: isSelected
                              ? const Icon(
                                  Icons.check,
                                  size: 13,
                                  color: Color(0xFF2366C4),
                                  weight: 800,
                                )
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Border for selected state
              if (isSelected)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.9),
                        width: 2,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRectangularCard(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 6,
              offset: const Offset(0, 2),
              spreadRadius: 0,
            ),
            if (isSelected)
              BoxShadow(
                color: const Color(0xFF2366C4).withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, 3),
                spreadRadius: 0,
              ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              // Background Image
              if (location.image != null && location.image!.isNotEmpty)
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(location.image!),
                      fit: BoxFit.cover,
                      onError: (exception, stackTrace) {},
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.1),
                          Colors.black.withValues(alpha: 0.35),
                        ],
                      ),
                    ),
                  ),
                )
              else
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF2366C4).withValues(alpha: 0.8),
                        const Color(0xFF025396).withValues(alpha: 0.9),
                      ],
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.2),
                        ],
                      ),
                    ),
                  ),
                ),

              // Content
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Location Name
                      Expanded(
                        child: Text(
                          location.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      const SizedBox(width: 10),

                      // Selection Indicator
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 1.5,
                          ),
                          color: isSelected
                              ? Colors.white
                              : Colors.transparent,
                          boxShadow: [
                            if (isSelected)
                              BoxShadow(
                                color: Colors.white.withValues(alpha: 0.3),
                                blurRadius: 4,
                                spreadRadius: 0,
                              ),
                          ],
                        ),
                        child: isSelected
                            ? const Icon(
                                Icons.check,
                                size: 12,
                                color: Color(0xFF2366C4),
                                weight: 800,
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
              ),

              // Border for selected state
              if (isSelected)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.8),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
