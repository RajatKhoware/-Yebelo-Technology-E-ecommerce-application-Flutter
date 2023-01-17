// ignore_for_file: public_member_api_docs, sort_constructors_first, unrelated_type_equality_checks

import 'dart:convert';
import 'package:e_commere/utils/colors.dart';
import 'package:e_commere/utils/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widget/product_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Fields
  late String _newAvailability;
  String? _selectedCategory = "All";
  final jsonUri = "assets/product_data.json";
  final borderCircular = BorderRadius.circular(10);
  List _products = [];
  List _filteredProducts = [];
  final List<String> _categories = ["All", "Premium", "Tamilnadu"];

  //Getting data from json file using future.
  Future<void> readJson() async {
    final String response = await rootBundle.loadString(jsonUri);
    final data = await jsonDecode(response);
    setState(() {
      _products = data["products"];
      _filterProducts();
    });
  }

  //Filtering out the Products based on there categories
  void _filterProducts() {
    _filteredProducts = _selectedCategory == "All"
        ? _products
        : _products
            .where((product) => product["p_category"] == _selectedCategory)
            .toList();
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    // Lits of colors of ProductTile background color
    List<Color> bgColor = [red, yellow, pink, orange];

    return Scaffold(
      appBar: appBar(),
      backgroundColor: white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 10, top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children:const [
                      CustomText(
                          text: "One Fruits a ",
                          fontsize: 25,
                          colors: black,
                          fontWeight: FontWeight.w500),
                      CustomText(
                          text: "Day",
                          fontsize: 30,
                          colors: black,
                          fontWeight: FontWeight.w600),
                    ],
                  ),
                  SizedBox(
                    width: 120,
                    height: 50,
                    child: dropdownButton(),
                  )
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                height: 570,
                child: GridView.builder(
                 
                  itemCount: _filteredProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.75,
                  ),
                  itemBuilder: (context, index) {
                    var product = _filteredProducts[index];
                    // This if method is used to filter out products form there category
                    if (_selectedCategory == "All" ||
                        _selectedCategory == product["p_category"]) {
                      return ProductTile(
                        productName: product["p_name"],
                        productPrice: product["p_cost"].toString(),
                        productImg: product["p_image"],
                        productBgColor: bgColor[index],
                        productId: product["p_id"].toString(),
                        productQunatity: product["p_availability"].toString(),
                        onTap: () {
                          //This Dialog help to get user input to update the product value
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Update availability"),
                                content: TextField(
                                  keyboardType: TextInputType.number,
                                  //Getting the value form user and saving it to _newAvailability
                                  onChanged: (value) =>
                                      _newAvailability = value,
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text("Update"),
                                    onPressed: () async {
                                      //Updating the value of p_availability by the user input
                                      setState(() {
                                        _products[index]["p_availability"] =
                                            _newAvailability;
                                      });
                                      Navigator.pop(context);
                                      //Showing the list of updated values of products
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text("Updated Products"),
                                            content: SizedBox(
                                              width: 300,
                                              height: 300,
                                              child: ListView.builder(
                                                itemCount:
                                                    _filteredProducts.length,
                                                itemBuilder: (context, index) {
                                                  var product =
                                                      _filteredProducts[index];
                                                  return ListTile(
                                                    title:
                                                        Text(product["p_name"]),
                                                    subtitle: Text(
                                                        "Availability: ${product["p_availability"]}"),
                                                  );
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Cancel"),
                                  )
                                ],
                              );
                            },
                          );
                        },
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// AppBar
  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      leading: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.menu,
          color: black.withOpacity(0.7),
          size: 30,
        ),
      ),
      title: const CustomText(
          text: "Easy Basket",
          colors: black,
          fontsize: 20,
          fontWeight: FontWeight.w600),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            CupertinoIcons.person_fill,
            color: black.withOpacity(0.7),
            size: 30,
          ),
        ),
      ],
    );
  }

// DropdownButon for selecting Categories
  DropdownButtonFormField<String> dropdownButton() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        labelText: "Category",
        floatingLabelStyle: const TextStyle(
          color: lightBlue,
        ),
        border: OutlineInputBorder(
          borderRadius: borderCircular,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderCircular,
          borderSide: const BorderSide(
            color: lightBlue,
          ),
        ),
        contentPadding: const EdgeInsets.all(10),
      ),
      value: _selectedCategory,
      items: _categories.map((String category) {
        return DropdownMenuItem(
          value: category,
          child: Text(category),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedCategory = value;
          _filterProducts();
        });
      },
    );
  }
}
