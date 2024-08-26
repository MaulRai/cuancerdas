import 'package:cuancerdas/services/datas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add Income to Firestore
  Future<void> addIncome(Income income) async {
    final data = {
      'no': income.no,
      'name': income.name,
      'amount': income.amount,
      'item': income.item,
      'date': income.date.toIso8601String(),
    };
    await _db.collection('incomes').add(data);
  }

  // Get Income from Firestore
  Future<List<Income>> getIncomes() async {
    try {
      final querySnapshot = await _db.collection('incomes').get();
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Income(
          data['no'],
          data['name'],
          data['amount'],
          data['item'],
          DateTime.parse(data['date']),
        );
      }).toList();
    } on Exception catch (_) {
      return [];
    }
  }

  // Add Product to Firestore
  Future<void> addProduct(Product product) async {
    final data = {
      'item': product.item,
      'price': product.price,
      'discount': product.discount,
    };
    await _db.collection('products').add(data);
  }

  // Get Products from Firestore
  Future<List<Product>> getProducts() async {
    try {
      final querySnapshot = await _db.collection('products').get();
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Product(
          data['item'],
          data['price'],
          data['discount'],
        );
      }).toList();
    } on Exception catch (_) {
      return [];
    }
  }

  // Add Expense to Firestore
  Future<void> addExpense(Expense expense) async {
    final data = {
      'desc': expense.desc,
      'price': expense.price,
      'category': expense.category,
      'date': expense.date.toIso8601String(),
    };
    await _db.collection('expenses').add(data);
  }

  // Get Expenses from Firestore
  Future<List<Expense>> getExpenses() async {
    try {
      final querySnapshot = await _db.collection('expenses').get();
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Expense.custom(
          data['desc'],
          data['price'],
          data['category'],
          DateTime.parse(data['date']),
        );
      }).toList();
    } on Exception catch (_) {
      return [];
    }
  }

  // Add Category to Firestore
  Future<void> addCategory(Category category) async {
    final data = {
      'name': category.name,
      'desc': category.desc,
    };
    await _db.collection('categories').add(data);
  }

  // Get Categories from Firestore
  Future<List<Category>> getCategories() async {
    try {
      final querySnapshot = await _db.collection('categories').get();
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Category(
          data['name'],
          data['desc'],
        );
      }).toList();
    } on Exception catch (_) {
      return [];
    }
  }

  // Convert class data to JSON strings
  String incomeJsonStringify() {
    return Income.jsonStringify();
  }

  String productJsonStringify() {
    return Product.jsonStringify();
  }

  String expenseJsonStringify() {
    return Expense.jsonStringify();
  }
}
