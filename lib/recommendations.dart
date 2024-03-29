import 'package:WeCare/medicine.dart';
import 'package:WeCare/mybot.dart';
import 'package:flutter/material.dart';
import 'availability.dart';
import 'Welcome.dart';

void main() {
  runApp(Recomend());
}

class Recomend extends StatefulWidget {
  @override
  _RecomendState createState() => _RecomendState();
}

class _RecomendState extends State<Recomend> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WelcomeUser()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Recomend()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Shop()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => chatbot()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DocScreen()),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color.fromRGBO(67, 177, 75, 1.0)),
      ),
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Padding(
            padding: EdgeInsets.only(top: 22),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeUser()),
                    );
                  },
                ),
                SizedBox(width: 5),
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                  child: const CircleAvatar(
                    backgroundImage: AssetImage("assets/profile_image.png"),
                    radius: 20,
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Welcome',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      'Aastha',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  children: const [
                    Icon(Icons.location_on, size: 20),
                    Text(
                      'Patna, Bihar',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(width: 30),
                    SizedBox(width: 16),
                  ],
                ),
              ],
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search doctor',
                          border: InputBorder.none,
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.filter_list),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Icon(Icons.search),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 55),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recommendations',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  _buildRecommendationItem(
                      "Dr Olivia Wilson\nconsultant-physiotheraphy",
                      "assets/profile_image1.png",
                      4),
                  SizedBox(height: 20),
                  _buildRecommendationItem(
                      "Dr. Jonathan Patterson\nconsultant-Dentist",
                      "assets/profile_image2.png",
                      3),
                  SizedBox(height: 20),
                  _buildRecommendationItem(
                      "Dr. Mathur Chande\nconsultant-Internal Medicine",
                      "assets/profile_image3.png",
                      5),
                  SizedBox(height: 20),
                  _buildRecommendationItem(
                      "Dr. Manmohan Singh\nconsultant-surgeon",
                      "assets/profile_image4.png",
                      2),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: 55, top: 5),
              child: Row(
                children: [
                  Text(
                    'See availability',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 120),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Availability(),
                        ),
                      );
                    },
                    child: Text('Click Here'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(67, 177, 75, 1.0)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromARGB(255, 112, 238, 119),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital),
              label: 'Doctor',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Shop',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Ask',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.description),
              label: 'Doc',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.white,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Widget _buildRecommendationItem(String name, String imagePath, int rating) {
    return Row(
      children: [
        SizedBox(width: 10),
        Container(
          width: 40,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey,
          ),
          child: CircleAvatar(
            backgroundImage: AssetImage(imagePath),
            radius: 30,
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(fontSize: 15),
            ),
            Row(
              children: List.generate(
                rating,
                (index) => Icon(Icons.star, color: Colors.yellow, size: 20),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ShopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
      ),
      body: Center(
        child: Text('Shop Screen'),
      ),
    );
  }
}

class AskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ask'),
      ),
      body: Center(
        child: Text('Ask Screen'),
      ),
    );
  }
}

class DocScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doc'),
      ),
      body: Center(
        child: Text('Doc Screen'),
      ),
    );
  }
}
