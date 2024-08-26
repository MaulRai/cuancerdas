import 'package:cuancerdas/UI_UX/widget.dart';
import 'package:cuancerdas/services/firestore_service.dart';
import 'package:cuancerdas/services/datas.dart';
import 'package:cuancerdas/services/text_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InExPage extends StatefulWidget {
  const InExPage({super.key});

  @override
  State<InExPage> createState() => _InExPageState();
}

class _InExPageState extends State<InExPage> {
  bool inTransPage = true;
  bool showInvoice = false;
  final db = FirestoreService();
  List<TextEditingController> itemControllers = [TextEditingController()];
  List<TextEditingController> amountControllers = [TextEditingController()];
  List<Widget> tableRows = []; // Maintain table rows at the state level
  int tableLength = 1;
  List<Income> newestIncome = [];
  List<Product> _products = [];
  List<Income> _incomes = [];
  List<Category> _categories = [];

  @override
  void initState() {
    super.initState();
    _addRowWidget(); // Initialize with the first row
    loadProduct();
  }

  @override
  void dispose() {
    // Dispose all controllers when the widget is disposed
    for (var controller in itemControllers) {
      controller.dispose();
    }
    for (var controller in amountControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void addRow() {
    setState(() {
      itemControllers.add(TextEditingController());
      amountControllers.add(TextEditingController());
      _addRowWidget();
    });
  }

  Future<void> loadProduct() async {
    List<Product> products = await db.getProducts();
    List<Income> incomes = await db.getIncomes();
    List<Category> categories = await db.getCategories();
    setState(() {
      _products = products;
      _incomes = incomes;
      _categories =categories;
    });
  }

  void _addRowWidget() {
    final items = _products.map((product) {
      return DropdownMenuEntry<String>(
        value: product.item,
        label: product.item,
      );
    }).toList();
    tableRows.add(SizedBox(
      width: 300,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            simpleText("$tableLength"),
            simpleDropDown(itemControllers[tableLength - 1], items),
            SizedBox(
                width: 60,
                child: simpleTextField(
                    amountControllers[tableLength - 1], "Total "))
          ],
        ),
      ),
    ));
    tableLength++;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: double.infinity,
        color: Color.fromARGB(255, 17, 24, 37),
        child: SingleChildScrollView(
          child: Expanded(
            child: Column(
              children: [
                _headerOption(),
                inTransPage ? _transPage() : _expensePage(),
                SizedBox(
                  height: 50,
                ),
                if (showInvoice) _invoice(),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _invoice() {
    final lastestIncome = _incomes.last;
    final subtotal = calculateTotalPrice(newestIncome);
    final totalDiscount = calculateTotalDiscount(newestIncome);
    final grandTotal = ((subtotal - totalDiscount) * 1.025).toStringAsFixed(2);
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 47, 59, 76),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: simpleText("Invoice", 20)),
          Align(
              alignment: Alignment.centerRight,
              child: simpleText(lastestIncome.no.toString(), 14)),
          Align(
              alignment: Alignment.centerRight,
              child: simpleText(lastestIncome.name, 14)),
          Divider(
            thickness: 2,
          ),
          Row(
            children: [
              Expanded(child: simpleText("Item", 16)),
              Expanded(child: simpleText("Price", 16)),
              Expanded(child: simpleText("Amount", 16)),
              Expanded(child: simpleText("Subtotal", 16)),
              Expanded(child: simpleText("Discount", 16)),
            ],
          ),
          ...newestIncome.map((income) {
            return Row(
              children: [
                Expanded(child: simpleText(income.item, 12)),
                Expanded(child: simpleText(income.price.toString(), 12)),
                Expanded(child: simpleText(income.amount.toString(), 12)),
                Expanded(child: simpleText(income.totalPrice.toString(), 12)),
                Expanded(child: simpleText(income.discount.toString(), 12)),
              ],
            );
          }).toList(),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              simpleText("Subtotal", 16),
              simpleText("$subtotal", 16).paddingOnly(right: 100),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              simpleText("Total Discount", 16),
              simpleText("$totalDiscount", 16).paddingOnly(right: 100),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              simpleText("Tax", 16),
              simpleText("2.5%", 16).paddingOnly(right: 100),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              simpleText("Total", 16),
              simpleText(grandTotal, 16).paddingOnly(right: 100),
            ],
          ),
        ],
      ),
    );
  }

  double calculateTotalPrice(List<Income> newestIncome) {
    return newestIncome.fold(0, (sum, income) => sum + income.totalPrice);
  }

  double calculateTotalDiscount(List<Income> newestIncome) {
    return newestIncome.fold(0, (sum, income) => sum + income.discount);
  }

  Widget _transPage() {
    final ctrl = IncomeTextController();
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 32, 41, 54),
          borderRadius: BorderRadius.circular(10)),
      child: Column(children: [
        simpleText("Transaction no."),
        simpleTextField(ctrl.no, "Transaction number").paddingOnly(bottom: 15),
        simpleText("Customer name"),
        simpleTextField(ctrl.name, "Customer name").paddingOnly(bottom: 15),
        ...tableRows,
        aButton(
          onPressed: addRow,
          child: Icon(Icons.add, color: Colors.white,),
          width: 70
        ).paddingOnly(bottom: 15, top: 15),
        SizedBox(
          width: double.infinity,
          child: aButton(
              onPressed: () {
                setState(() {
                  newestIncome.clear();
                  print(tableLength);
                  for (int i = 0; i < tableLength - 1; i++) {
                    print(i);
                    final newIncome = Income(
                        int.parse(ctrl.no.text),
                        ctrl.name.text,
                        int.parse(amountControllers[i].text),
                        itemControllers[i].text,
                        DateTime.now());
                    db.addIncome(newIncome);
                    newestIncome.add(newIncome);
                  }
                  print("TOTAL: ${_incomes.length}");
                  showInvoice = true;
                });
              },
              child: simpleText("Show invoice")).paddingOnly(bottom: 15),
        )
      ]),
    );
  }

  Widget _expensePage() {
    final ctrl = ExpenseTextController();
    final cats = _categories.map((category) {
    return DropdownMenuEntry<String>(
      value: category.name,
      label: category.name,
    );
  }).toList();
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 32, 41, 54),
          borderRadius: BorderRadius.circular(10)),
      child: Column(children: [
        simpleText("Description"),
        simpleTextField(ctrl.desc, "Description"),
        const SizedBox(height: 15),
        simpleText("Price"),
        simpleTextField(ctrl.price, "Price"),
        const SizedBox(height: 15),
        simpleText("Category"),
        simpleDropDown(ctrl.category, cats),
        Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          child: aButton(
              onPressed: () {
                setState(() {
                  db.addExpense(Expense(
                    ctrl.desc.text,
                    double.parse(ctrl.price.text),
                    ctrl.category.text,
                  ));
                  ctrl.desc.clear();
                  ctrl.price.clear();
                  ctrl.category.clear();
                });
              },
              child: Text("Add expenses")),
        )
      ]),
    );
  }

  Widget _headerOption() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (!inTransPage) {
                setState(() {
                  inTransPage = true;
                });
              }
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(5, 35, 5, 5),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 36, 124, 19),
                    Color.fromARGB(0, 36, 124, 19)
                  ],
                ),
              ),
              child: Text(
                "Add Transaction",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: inTransPage ? FontWeight.bold : null,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (inTransPage) {
                setState(() {
                  showInvoice = false;
                  inTransPage = false;
                });
              }
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(0, 35, 5, 5),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 124, 19, 19),
                    Color.fromARGB(0, 124, 19, 19),
                  ],
                ),
              ),
              child: Text(
                "Add Expenses",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: !inTransPage ? FontWeight.bold : null,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
