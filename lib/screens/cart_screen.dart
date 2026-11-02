import 'package:flutter/material.dart';

List<Map<String, dynamic>> cartItems = [];

void addToCart(String name, int price, String image) {
  for (var item in cartItems) {
    if (item["name"] == name) {
      item["qty"]++;
      return;
    }
  }
  cartItems.add({"name": name, "price": price, "qty": 1, "image": image});
}

class CartScreen extends StatefulWidget {
  CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final int shipping = 6;

  List<Map<String, dynamic>> get items => cartItems;

  int get subtotal {
    int sum = 0;
    for (var item in items) {
      sum += (item["price"] as int) * (item["qty"] as int);
    }
    return sum;
  }

  Widget qtyButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          color: Color(0xFF3B2814),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 14, color: Color(0xFFC99660)),
      ),
    );
  }

  Widget cartTile(Map<String, dynamic> item) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFFC99660),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.asset(
            item["image"],
            width: 50,
            height: 50,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.coffee, size: 40, color: Color(0xFF3B2814));
            },
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item["name"],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  '\$${item["price"]}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          qtyButton(Icons.remove, () {
            setState(() {
              if (item["qty"] > 1) {
                item["qty"]--;
              } else {
                items.remove(item);
              }
            });
          }),
          SizedBox(width: 8),
          Text(
            '${item["qty"]}',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          SizedBox(width: 8),
          qtyButton(Icons.add, () {
            setState(() {
              item["qty"]++;
            });
          }),
        ],
      ),
    );
  }

  Widget totalRow(String label, int value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.white, fontSize: 11)),
          Text(
            '\$$value',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4E3620),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Color(0xFFC99660),
                      size: 18,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Cart",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Icon(Icons.notifications_none, color: Colors.white),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "My Order",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    ...items.map((item) => cartTile(item)),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xFFC99660),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    color: Color(0xFFD8AE7E),
                                    child: TextField(
                                      style: TextStyle(fontSize: 11),
                                      decoration: InputDecoration(
                                        hintText: "Enter Coupon Code here",
                                        hintStyle: TextStyle(fontSize: 10),
                                        border: InputBorder.none,
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Color(0xFF3B2814),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 22,
                                    vertical: 13,
                                  ),
                                  child: Text(
                                    "Apply",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 14),
                          totalRow("Sub-total", subtotal),
                          totalRow("Shipping", items.isEmpty ? 0 : shipping),
                          totalRow(
                            "Total",
                            items.isEmpty ? 0 : subtotal + shipping,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Finalize Order",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Color(0xFFC99660),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.home_outlined, color: Color(0xFF3B2814)),
            ),
            Transform.translate(
              offset: Offset(0, -10),
              child: Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: Color(0xFF3B2814),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Color(0xFFC99660),
                ),
              ),
            ),
            Icon(Icons.favorite_border, color: Color(0xFF3B2814)),
            Icon(Icons.person_outline, color: Color(0xFF3B2814)),
          ],
        ),
      ),
    );
  }
}