import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expensesList;
  final void Function(Expense) onRemoveExpense;

  const ExpensesList({
    super.key,
    required this.expensesList,
    required this.onRemoveExpense,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expensesList.length,
      itemBuilder: (context, index) => Dismissible(
        background: Container(
          color: Theme.of(context).colorScheme.shadow.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
        ),
        key: ValueKey(expensesList[index]),
        onDismissed: (direction) {
          onRemoveExpense(expensesList[index]);
        },
        child: ExpenseItem(
          expense: expensesList[index],
        ),
      ),
    );
  }
}
