import 'package:flutter/material.dart';
import 'package:todo_app/theme/app_colors.dart';

class TodoItem extends StatefulWidget {
  const TodoItem({
    super.key,
    required this.title,
    required this.isDone,
    required this.onChanged,
    required this.onDelete,
    required this.onEdit,
  });

  final String title;
  final bool isDone;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        child: ListTile(
          leading: GestureDetector(
            onTap: () => widget.onChanged(!widget.isDone),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.isDone ? AppColors.primary : Colors.transparent,
                border: Border.all(
                  color: widget.isDone
                      ? AppColors.primary
                      : AppColors.textSecondary,
                  width: 1.5,
                ),
              ),
              child: widget.isDone
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
          ),
          title: Text(
            widget.title,
            style: TextStyle(
              color: widget.isDone
                  ? AppColors.textSecondary
                  : AppColors.textPrimary,
              decoration: widget.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          trailing: _isHovered
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.edit_outlined,
                        size: 18,
                        color: Colors.grey[400],
                      ),
                      onPressed: widget.onEdit,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete_outline,
                        size: 18,
                        color: Colors.grey[400],
                      ),
                      onPressed: widget.onDelete,
                    ),
                  ],
                )
              : null,
        ),
      ),
    );
  }
}
