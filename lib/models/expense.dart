import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat('dd/MM/yyyy');

const uuid = Uuid();

const categoryIcons = {
  Category.food: Icons.food_bank,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie_creation_outlined,
  Category.work: Icons.work,
};

enum Category {
  food,
  travel,
  leisure,
  work,
}

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Expense({
    required this.title,
    required this.category,
    required this.amount,
    required this.date,
  }) : id = uuid.v4();

  String getFormattedDate() {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  final Category category;
  final List<Expense> expenses;

  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> expenses, this.category)
      : expenses =
            expenses.where((expense) => expense.category == category).toList();

  double getTotalExpenses() {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
