import 'package:intl/intl.dart';

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Пожалуйста, введите свой email';
  }
  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    return 'Пожалуйста, введите действительный email';
  }
  return null;
}

String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Пожалуйста, введите имя';
  }

// Удаляем лишние пробелы в начале и конце
  value = value.trim();

// Проверка на минимальную длину
  if (value.length < 2) {
    return 'Имя должно содержать минимум 2 символа';
  }

// Проверка на максимальную длину
  if (value.length > 50) {
    return 'Имя не должно превышать 50 символов';
  }

// Проверка на правильный формат имени (только буквы и пробелы)
  if (!RegExp(r'^[a-zA-Zа-яА-Я\s]+$').hasMatch(value)) {
    return 'Имя может содержать только буквы';
  }

// Проверка на множественные пробелы
  if (value.contains(RegExp(r'\s{2,}'))) {
    return 'Уберите лишние пробелы между словами';
  }

  return null;
}

String? validateController(String? value) {
  if (value == null || value.isEmpty) {
    return 'Пожалуйста, заполните поле';
  }

// Удаляем лишние пробелы в начале и конце
  value = value.trim();

// Проверка на минимальную длину
  if (value.length < 2) {
    return 'Поле должно содержать минимум 2 символа';
  }

// Проверка на максимальную длину
  if (value.length > 50) {
    return 'Поле не должно превышать 50 символов';
  }

// Проверка на правильный формат имени (только буквы и пробелы)
  if (!RegExp(r'^[a-zA-Zа-яА-Я\s]+$').hasMatch(value)) {
    return 'Поле может содержать только буквы';
  }

// Проверка на множественные пробелы
  if (value.contains(RegExp(r'\s{2,}'))) {
    return 'Уберите лишние пробелы между словами';
  }

  return null;
}

String? validateSurname(String? value) {
  if (value == null || value.isEmpty) {
    return 'Пожалуйста, введите фамилию';
  }

// Удаляем лишние пробелы в начале и конце
  value = value.trim();

// Проверка на минимальную длину
  if (value.length < 2) {
    return 'Фамилия должно содержать минимум 2 символа';
  }

// Проверка на максимальную длину
  if (value.length > 50) {
    return 'Фамилия не должно превышать 50 символов';
  }

// Проверка на правильный формат имени (только буквы и пробелы)
  if (!RegExp(r'^[a-zA-Zа-яА-Я\s]+$').hasMatch(value)) {
    return 'Фамилия может содержать только буквы';
  }

// Проверка на множественные пробелы
  if (value.contains(RegExp(r'\s{2,}'))) {
    return 'Уберите лишние пробелы между словами';
  }

  return null;
}

String formatDate(String isoString) {
  final date = DateTime.parse(isoString);

  final months = [
    'января', 'февраля', 'марта', 'апреля', 'мая', 'июня',
    'июля', 'августа', 'сентября', 'октября', 'ноября', 'декабря'
  ];

  return '${date.day} ${months[date.month - 1]} ${date.year}';
}
