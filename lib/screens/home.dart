import 'package:flutter/material.dart';
import 'package:flutter_task3/widgets/coffecard.dart';
import 'cart_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  List<Map<String, dynamic>> coffees = [
    {"name": "Arabica", "price": 18, "image": 'lib/assets/images/Arabica.png'},
    {"name": "Robusta", "price": 20, "image": 'lib/assets/images/Robusta.png'},
    {"name": "Excelsa", "price": 15, "image": 'lib/assets/images/Excelsa.png'},
    {"name": "Liberica", "price": 12, "image": 'lib/assets/images/Liberica.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4E3620),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 10),
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Color(0xFFC99660),
                    backgroundImage: AssetImage('lib/assets/images/icon.png'),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Shahzaib",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Good Morning!",
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.search, color: Colors.white),
                  SizedBox(width: 16),
                  Icon(Icons.notifications_none, color: Colors.white),
                ],
              ),
              SizedBox(height: 20),
              Container(
                height: 120,
                width: double.infinity,
                padding: EdgeInsets.only(left: 16),
                decoration: BoxDecoration(
                  color: Color(0xFF6E4E2E),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Get 20% Discount\nOn your First Order!",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Image.asset(
                      'lib/assets/images/banner.png',
                      width: 100,
                      height: 100,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  itemCount: coffees.length,
                  padding: EdgeInsets.only(bottom: 20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (context, index) {
                    return CoffeeCard(
                      name: coffees[index]["name"],
                      price: coffees[index]["price"],
                      image: coffees[index]["image"],
                      onAdd: () {
                        addToCart(
                          coffees[index]["name"],
                          coffees[index]["price"],
                          coffees[index]["image"],
                        );


                      },
                    );
                  },
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
            Transform.translate(
              offset: Offset(0, -10),
              child: Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: Color(0xFF3B2814),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.home_outlined, color: Color(0xFFC99660)),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen()),
                );
              },
              child: Icon(Icons.shopping_cart_outlined, color: Color(0xFF3B2814)),
            ),
            Icon(Icons.favorite_border, color: Color(0xFF3B2814)),
            Icon(Icons.person_outline, color: Color(0xFF3B2814)),
          ],
        ),
      ),
    );
  }
}