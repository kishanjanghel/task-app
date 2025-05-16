import 'package:flutter/material.dart';
import 'package:task_app/local_db/teacher_db.dart';

class CustomTile extends StatelessWidget {
  final TeacherHiveModel? teacher;

  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const CustomTile({
    super.key,
    required this.teacher,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final firstLetter = (teacher?.name?.isNotEmpty ?? false)
        ? teacher?.name![0].toUpperCase()
        : '?';

    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.grey[100]!),
          borderRadius: BorderRadius.circular(11.0),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            child: Text(
              firstLetter ?? "",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(teacher?.name ?? 'No Name'),
          subtitle: Text(teacher?.subject ?? 'No Subject'),
          onTap: onTap,
          trailing: IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => _showOptionsSheet(context),
          ),
        ),
      ),
    );
  }

  void _showOptionsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit'),
                onTap: () {
                  Navigator.pop(context);
                  if (onEdit != null) onEdit!();
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete'),
                onTap: () {
                  Navigator.pop(context);
                  if (onDelete != null) onDelete!();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
