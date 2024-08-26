import 'package:cuancerdas/UI_UX/widget.dart';
import 'package:cuancerdas/services/firestore_service.dart';
import 'package:cuancerdas/services/datas.dart';
import 'package:cuancerdas/services/text_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryPage extends StatefulWidget {
  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool inProductPage = true;
  int crntProductPage = 1;
  int crntCategoryPage = 1;
  // final db = Get.find<UserDatabase>();
  final db = FirestoreService();
  // final

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Color.fromARGB(255, 17, 24, 37),
        child: Column(
          children: [
            SizedBox(height: 30),
            _headerOption(),
            Expanded(child: SizedBox()),
            (inProductPage ? _addProduct() : _addCategory()),
            SizedBox(
              height: 80,
            ),
            Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }

  Widget _addProduct() {
    final ctrl = ProductTextController();
    return FutureBuilder<List<Product>>(
      future: db.getProducts(), // Await the Future here
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Loading indicator while waiting for the data
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          List<Product> products = snapshot.data!;
          int totalPage = (products.length / 6).ceil() == 0
              ? 1
              : (products.length / 6).ceil();
          return Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 32, 41, 54),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Row(
                  children: [
                    simpleText("List of items", 14),
                  ],
                ),
                Row(children: [
                  Expanded(child: simpleText("#"), flex: 1),
                  Expanded(child: simpleText("Barang"), flex: 3),
                  Expanded(child: simpleText("Harga"), flex: 3),
                  Expanded(child: simpleText("Discount"), flex: 3),
                  Expanded(child: simpleText("Edit"), flex: 1),
                  // Expanded(child: simpleText("Date"), flex: 4),
                ]),
                Container(
                  height: 100,
                  child: ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      int dataIndex = (crntProductPage - 1) * 6 + index;
                      if (dataIndex < products.length) {
                        final prod = products[dataIndex];
                        return Container(
                            alignment: Alignment.centerLeft,
                            // padding: const EdgeInsets.all(2.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: simpleText("${dataIndex + 1}"),
                                    flex: 1),
                                Expanded(child: simpleText(prod.item), flex: 3),
                                Expanded(
                                    child: simpleText(prod.fPrice), flex: 3),
                                Expanded(
                                    child: simpleText('${prod.stringDisc}%'),
                                    flex: 3),
                                Expanded(
                                  child: Icon(
                                    Icons.edit_square,
                                    size: 13,
                                    color: Colors.white,
                                  ),
                                  flex: 1,
                                ),
                              ],
                            ));
                      }
                      return Container(
                          // height: 10,
                          // width: 200,
                          );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    aButton(
                        onPressed: () {
                          if (crntProductPage > 1) {
                            setState(() {
                              crntProductPage--;
                            });
                          }
                        },
                        tight: true,
                        child: Text("Previous")),
                    simpleText("Page $crntProductPage of $totalPage"),
                    aButton(
                        onPressed: () {
                          if (crntProductPage < totalPage) {
                            setState(() {
                              crntProductPage++;
                            });
                          }
                        },
                        tight: true,
                        width: 70,
                        child: Text("Next")),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    simpleText("Add new item", 14).paddingOnly(bottom: 15),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    simpleText("Item name"),
                    simpleTextField(ctrl.itemName, "Item name")
                        .paddingOnly(bottom: 15),
                    simpleText("Item price"),
                    simpleTextField(ctrl.itemPrice, "Item price")
                        .paddingOnly(bottom: 15),
                    simpleText("Discount (%)"),
                    simpleTextField(ctrl.discount, "Discount")
                        .paddingOnly(bottom: 15),
                    SizedBox(
                      width: double.infinity,
                      child: aButton(
                        onPressed: () {
                          setState(() {
                            db.addProduct(Product(
                                ctrl.itemName.text,
                                double.parse(ctrl.itemPrice.text),
                                double.parse(ctrl.discount.text)));
                            ctrl.itemName.clear();
                            ctrl.itemPrice.clear();
                            ctrl.discount.clear();
                          });
                        },
                        child: Text("Add product"),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        } else {
          return Text('No Products Found');
        }
      },
    );
  }

  Widget _addCategory() {
    final ctrl = CategoryTextController();
    return FutureBuilder<List<Category>>(
      future: db.getCategories(), // Await the Future here
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Loading indicator while waiting for the data
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          List<Category> categories = snapshot.data!;
          int totalPage = (categories.length / 6).ceil() == 0
              ? 1
              : (categories.length / 6).ceil();
          return Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 32, 41, 54),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Row(
                  children: [
                    simpleText("List of Expense Categiry", 14),
                  ],
                ),
                Row(children: [
                  Expanded(child: simpleText("#"), flex: 1),
                  Expanded(child: simpleText("Name"), flex: 4),
                  Expanded(child: simpleText("Desc"), flex: 4),
                  Expanded(child: simpleText("Action"), flex: 2),
                ]),
                Container(
                  height: 100,
                  child: ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      int dataIndex = (crntCategoryPage - 1) * 6 + index;
                      if (dataIndex < categories.length) {
                        final cat = categories[dataIndex];
                        return Container(
                            alignment: Alignment.centerLeft,
                            // padding: const EdgeInsets.all(2.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: simpleText("${dataIndex + 1}"),
                                    flex: 1),
                                Expanded(child: simpleText(cat.name), flex: 4),
                                Expanded(child: simpleText(cat.desc), flex: 4),
                                Expanded(
                                  child: Icon(
                                    Icons.edit_square,
                                    size: 13,
                                    color: Colors.white,
                                  ),
                                  flex: 2,
                                ),
                              ],
                            ));
                      }
                      return Container(
                          // height: 10,
                          // width: 200,
                          );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    aButton(
                        onPressed: () {
                          if (crntCategoryPage > 1) {
                            setState(() {
                              crntCategoryPage--;
                            });
                          }
                        },
                        tight: true,
                        child: Text("Previous")),
                    simpleText("Page $crntCategoryPage of $totalPage"),
                    aButton(
                        onPressed: () {
                          if (crntCategoryPage < totalPage) {
                            setState(() {
                              crntCategoryPage++;
                            });
                          }
                        },
                        tight: true,
                        width: 70,
                        child: Text("Next")),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                simpleText("Add new item", 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    simpleText("Item name"),
                    simpleTextField(ctrl.catName, "Name"),
                    simpleText("Item price"),
                    simpleTextField(ctrl.desc, "Description"),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: aButton(
                        onPressed: () {
                          setState(() {
                            db.addCategory(Category(
                              ctrl.catName.text,
                              ctrl.desc.text,
                            ));
                            ctrl.catName.clear();
                            ctrl.desc.clear();
                          });
                        },
                        child: Text("Add category"),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        } else {
          return Text('No Products Found');
        }
      },
    );
  }

  Widget _headerOption() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (!inProductPage) {
                setState(() {
                  inProductPage = true;
                });
              }
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 19, 49, 124),
                    Color.fromARGB(0, 19, 49, 124)
                  ],
                ),
              ),
              child: Text(
                "Add Product",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: inProductPage ? FontWeight.bold : null,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (inProductPage) {
                setState(() {
                  inProductPage = false;
                });
              }
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(0, 5, 5, 5),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 19, 49, 124),
                    Color.fromARGB(0, 19, 49, 124),
                  ],
                ),
              ),
              child: Text(
                "Add Category",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: !inProductPage ? FontWeight.bold : null,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
