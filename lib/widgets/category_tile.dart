import 'package:flutter/material.dart';
import '../data/catalog.dart';

/// Tinggi total tile (padding + ikon + label 2 baris). Pakai untuk grid/list.
const double kCategoryTileHeight = 104;

class CategoryTile extends StatelessWidget {
  final CategoryItem item;
  final bool selected;
  final VoidCallback onTap;

  const CategoryTile({
    super.key,
    required this.item,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    item.color.withValues(alpha: 0.20),
                    item.color.withValues(alpha: 0.07),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: selected
                      ? const Color(0xFF2E7D32)
                      : item.color.withValues(alpha: 0.18),
                  width: selected ? 2 : 1,
                ),
              ),
              child: Icon(item.icon, color: item.color, size: 30),
            ),
            const SizedBox(height: 6),
            SizedBox(
              height: 28,
              child: Text(
                item.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  height: 1.2,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
