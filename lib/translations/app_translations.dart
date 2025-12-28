import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    // 🇺🇸 English
    'en': {
      'app_name': 'Hive Todo App',
      'login': 'Login',
      'username': 'Username',
      'password': 'Password',
      'welcome': 'Welcome back!',
      'today': 'Today',
      'tasks': 'Tasks',
      'add_task': 'Add Task',
      'edit_task': 'Edit Task',
      'create_task': 'Create Task',
      'update_task': 'Update Task',

      'title': 'Title',
      'enter_title': 'Enter your title',
      'description': 'Description',
      'enter_description': 'Enter your description',

      'date': 'Date',
      'priority': 'Priority',
      'category': 'Category',

      'completed': 'COMPLETED',
      'todo': 'TODO',

      'add_category': 'Add Category',
      'category_name': 'Category name',
      'cancel': 'Cancel',
      'save': 'Save',
    },

    // 🇸🇦 Arabic
    'ar': {
      'app_name': 'تطبيق المهام',
      'login': 'تسجيل الدخول',
      'username': 'اسم المستخدم',
      'password': 'كلمة المرور',
      'welcome': 'أهلاً بك مجدداً!',
      'today': 'اليوم',
      'tasks': 'المهام',
      'add_task': 'إضافة مهمة',
      'edit_task': 'تعديل المهمة',
      'create_task': 'إنشاء مهمة',
      'update_task': 'تحديث المهمة',

      'title': 'العنوان',
      'enter_title': 'أدخل العنوان',
      'description': 'الوصف',
      'enter_description': 'أدخل الوصف',

      'date': 'التاريخ',
      'priority': 'الأولوية',
      'category': 'التصنيف',

      'completed': 'مكتملة',
      'todo': 'قيد التنفيذ',

      'add_category': 'إضافة تصنيف',
      'category_name': 'اسم التصنيف',
      'cancel': 'إلغاء',
      'save': 'حفظ',
    },
  };
}
