import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/task_model.dart';
import 'package:todo_sqflite/utils/theme.dart';

class TaskTile extends StatelessWidget {
  final Task? task;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const TaskTile(this.task, {super.key, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBGClr(task?.priority ?? ""),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task?.title ?? "",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.access_time_rounded,
                          color: Colors.grey[200], size: 18),
                      const SizedBox(width: 4),
                      Text(
                        task?.dueDate ?? "",
                        style: TextStyle(
                            fontSize: 13, color: Colors.grey[100]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    task?.description ?? "",
                    style: TextStyle(
                        fontSize: 15, color: Colors.grey[100]),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: onEdit,
                  icon:
                  const Icon(Icons.edit, color: Colors.white, size: 20),
                ),
                IconButton(
                  onPressed: onDelete,
                  icon:
                  const Icon(Icons.delete, color: Colors.white, size: 20),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              width: 0.5,
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                task!.isCompleted == 1
                    ? 'completed'.tr
                    : 'todo'.tr,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getBGClr(String priority) {
    switch (priority) {
      case 'Low':
        return bluishClr;
      case 'Medium':
        return pinkClr;
      case 'High':
        return yellowClr;
      default:
        return bluishClr;
    }
  }
}
