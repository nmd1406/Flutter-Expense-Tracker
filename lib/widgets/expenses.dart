import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  // Sample Data
  final List<Expense> _expensesList = [
    Expense(
      title: 'Flutter Course',
      category: Category.work,
      amount: 20.0,
      date: DateTime.now(),
    ),
    Expense(
      title: 'Cinema',
      category: Category.leisure,
      amount: 10.5,
      date: DateTime.now(),
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onAddNewExpense: _addNewExpense,
      ),
    );
  }

  void _addNewExpense(Expense expense) {
    setState(() {
      _expensesList.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _expensesList.indexOf(expense);

    setState(() {
      _expensesList.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(
          seconds: 3,
        ),
        content: const Text(
          'Expense deleted.',
        ),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _expensesList.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  void _clearExpenses() {
    final expensesListCopy = List.of(_expensesList);

    setState(() {
      _expensesList.clear();
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(
          seconds: 3,
        ),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _expensesList.addAll(expensesListCopy);
              });
            }),
        content: const Text(
          'All expenses deleted.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (_expensesList.isNotEmpty) {
      mainContent = ExpensesList(
        expensesList: _expensesList,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Flutter ExpenseTracker'),
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _expensesList),
                SizedBox(
                  height: 394,
                  child: mainContent,
                ),
                if (_expensesList.isNotEmpty)
                  TextButton(
                    onPressed: _clearExpenses,
                    child: const Text(
                      'Clear expenses',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 14,
                      ),
                    ),
                  ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(expenses: _expensesList),
                ),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 12,
        onPressed: _openAddExpenseOverlay,
        label: const Text(
          'Add',
        ),
        icon: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
