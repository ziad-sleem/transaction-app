import 'package:expense_tracker_app/core/constants/constants.dart';
import 'package:flutter/material.dart';

class CategorySelectorWidget<T> extends StatelessWidget {
  final T? selectedValue;
  final List<CategoryItem<T>> categories;
  final ValueChanged<T?> onChanged;

  const CategorySelectorWidget({
    super.key,
    required this.selectedValue,
    required this.categories,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.start,
      children: categories.map((category) {
        final isSelected = selectedValue == category.value;

        return GestureDetector(
          onTap: () => onChanged(category.value),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: isSelected
                  ? category.color.withOpacity(0.2)
                  : Colors.grey.withOpacity(0.05),
              border: Border.all(
                color: isSelected ? category.color : Colors.grey.shade300,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: category.color.withOpacity(isSelected ? 0.3 : 0.15),
                  ),
                  child: Icon(category.icon, color: category.color, size: 22),
                ),
                const SizedBox(height: 6),
                Text(
                  category.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected
                        ? category.color
                        : ConstantsColors.black.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class CategoryItem<T> {
  final T value;
  final String label;
  final IconData icon;
  final Color color;

  CategoryItem({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });
}
