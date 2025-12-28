import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/task_controller.dart';
import '../models/task_model.dart';
import '../models/category_model.dart';
import 'package:todo_sqflite/utils/theme.dart';
import '../widgets/input_field.dart';
import '../db/db_helper.dart';

class AddTaskScreen extends StatefulWidget {
  final Task? task;
  const AddTaskScreen({super.key, this.task});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TaskController _taskController = Get.find<TaskController>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _selectedPriority = "Low";
  List<String> priorityList = ["Low", "Medium", "High"];

  String _selectedCategory = "Work";
  List<String> categoryList = [];

  @override
  void initState() {
    super.initState();
    _loadCategoriesFromDb();

    if (widget.task != null) {
      _titleController.text = widget.task!.title ?? "";
      _noteController.text = widget.task!.description ?? "";
      _selectedDate = DateFormat.yMd().parse(widget.task!.dueDate!);
      _selectedPriority = widget.task!.priority ?? "Low";
      _selectedCategory = widget.task!.category ?? "Work";
    }
  }

  Future<void> _loadCategoriesFromDb() async {
    final categories = await DBHelper.instance.getAllCategories();
    if (!mounted) return;
    setState(() {
      categoryList = categories.isEmpty
          ? ["Work", "Personal", "Shopping", "Health"]
          : categories.map((c) => c.name).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: _appBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.task == null
                    ? 'add_task'.tr
                    : 'edit_task'.tr,
                style: headingStyle,
              ),

              MyInputField(
                title: 'title'.tr,
                hint: 'enter_title'.tr,
                controller: _titleController,
              ),

              MyInputField(
                title: 'description'.tr,
                hint: 'enter_description'.tr,
                controller: _noteController,
              ),

              MyInputField(
                title: 'date'.tr,
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: const Icon(Icons.calendar_today_outlined,
                      color: Colors.grey),
                  onPressed: _getDateFromUser,
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      title: 'priority'.tr,
                      hint: _selectedPriority,
                      widget: DropdownButton<String>(
                        underline: Container(),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        value: _selectedPriority,
                        onChanged: (value) {
                          setState(() => _selectedPriority = value!);
                        },
                        items: priorityList
                            .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                            .toList(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: MyInputField(
                      title: 'category'.tr,
                      hint: _selectedCategory,
                      widget: DropdownButton<String>(
                        underline: Container(),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        value: _selectedCategory,
                        onChanged: (value) {
                          setState(() => _selectedCategory = value!);
                        },
                        items: categoryList
                            .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: _validateData,
                  child: Container(
                    width: 140,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: primaryClr,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      widget.task == null
                          ? 'create_task'.tr
                          : 'update_task'.tr,
                      style: const TextStyle(color: Colors.white),
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

  void _validateData() {
    if (_titleController.text.isNotEmpty &&
        _noteController.text.isNotEmpty) {
      widget.task == null ? _addTaskToDb() : _updateTaskInDb();
      Get.back();
    }
  }

  Future<void> _addTaskToDb() async {
    await _taskController.addTask(
      task: Task(
        title: _titleController.text,
        description: _noteController.text,
        isCompleted: 0,
        category: _selectedCategory,
        priority: _selectedPriority,
        dueDate: DateFormat.yMd().format(_selectedDate),
        createdAt: DateTime.now().toString(),
      ),
    );
  }

  Future<void> _updateTaskInDb() async {
    await _taskController.updateTaskInfo(
      Task(
        id: widget.task!.id,
        title: _titleController.text,
        description: _noteController.text,
        isCompleted: widget.task!.isCompleted,
        category: _selectedCategory,
        priority: _selectedPriority,
        dueDate: DateFormat.yMd().format(_selectedDate),
        createdAt: widget.task!.createdAt,
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.scaffoldBackgroundColor,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios,
            color: Get.isDarkMode ? Colors.white : Colors.black),
        onPressed: () => Get.back(),
      ),
    );
  }

  Future<void> _getDateFromUser() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2121),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }
}
