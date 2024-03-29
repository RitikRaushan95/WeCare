import 'package:WeCare/appointment.dart';
import 'package:WeCare/document.dart';
import 'package:WeCare/feedback.dart';
import 'package:WeCare/mybot.dart';
import 'package:WeCare/payment/supportPayment.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'loginui.dart';
import 'medicine.dart';
import 'recommendations.dart';

int _selectedIndex = 0;
void main() => runApp(WelcomeUser());

class WelcomeUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Article>> _newsArticlesFuture;
  int _currentIndex = 0;
  bool _isParacetamolChecked = true;
  bool _isDigeneTabletsChecked = false;
  bool _isDarkMode = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WelcomeUser()));
        break;
      case 1:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Recomend()));
        break;
      case 2:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Shop()));
        break;
      case 3:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => chatbot()));
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Doc()),
        );
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _newsArticlesFuture = fetchNewsArticles();
    _newsArticlesFuture.then((articles) {
      _newsArticles = articles;
      Timer.periodic(const Duration(seconds: 2), (Timer timer) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % _newsArticles.length;
        });
      });
    });
  }

  late List<Article> _newsArticles = [];

  Future<List<Article>> fetchNewsArticles() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=in&category=health&apiKey=f9de620adab044ea852839ab79673f0b'));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      List<Article> articles = [];
      if (jsonData['articles'] != null) {
        for (var article in jsonData['articles']) {
          articles.add(Article.fromJson(article));
        }
      }
      return articles;
    } else {
      throw Exception('Failed to load news');
    }
  }

  // Toggle between light and dark mode
  // void _toggleThemeMode() {
  //   setState(() {
  //     _isDarkMode = !_isDarkMode;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(67, 177, 75, 1.0),
          title: Row(
            children: [
              const SizedBox(
                width: 8,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Aastha',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Spacer(),
              const CircleAvatar(
                backgroundImage: AssetImage('assets/profile_image.png'),
              ),
              const SizedBox(
                width: 8,
              ),
              IconButton(
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding:
                EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            children: <Widget>[
              SizedBox(
                height: 120,
                child: DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 112, 238, 119),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.person),
                          const SizedBox(width: 10),
                          const Text(
                            'Aastha',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.brightness_4),
                            onPressed: () {
                              // Toggle between light and dark themes
                              //  _toggleThemeMode();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                title: const Text('My Account'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Settings'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Records'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Document(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Appointments'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Appointment(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Community Collab'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Support'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Payment(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Funds'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('About'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Feedback'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FeedbackForm(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Logout'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Thank you"),
                        content: Text("Successfully Loged out"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginUi(),
                                ),
                              );
                            },
                            child: Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
          width: MediaQuery.of(context).size.width * 0.5,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 10),
          child: Container(
            color: _isDarkMode
                ? Colors.black
                : const Color.fromARGB(255, 226, 244, 252),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: const Color.fromRGBO(67, 177, 75, 1.0),
                  padding: EdgeInsets.only(
                    right: 18.0,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.location_on, color: Colors.black),
                      SizedBox(width: 3),
                      Text(
                        'Patna, Bihar',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Latest News',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 8),
                      FutureBuilder<List<Article>>(
                        future: _newsArticlesFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData &&
                              snapshot.data!.isNotEmpty) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _newsArticles[_currentIndex].title!,
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    String articleUrl =
                                        _newsArticles[_currentIndex].url!;
                                    if (articleUrl.isNotEmpty) {
                                      launch(articleUrl);
                                    }
                                  },
                                  child: const MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Text(
                                      'Know more',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return const Text(
                              'No news available',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Facilities',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Show All',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildBox('assets/doctor.png', 'Doctor'),
                    _buildBox('assets/ambulance.png', 'Emergency'),
                    _buildBox('assets/hospital.png', 'Hospital'),
                    _buildBox('assets/cart.png', 'Stores'),
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Today's Checklist",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildChecklistItem(
                          'Paracetamol', '8:00 pm', _isParacetamolChecked,
                          (bool isChecked) {
                        setState(() {
                          _isParacetamolChecked = isChecked;
                        });
                      }),
                      _buildChecklistItem(
                          'Digene tablets', '10:00 pm', _isDigeneTabletsChecked,
                          (bool isChecked) {
                        setState(() {
                          _isDigeneTabletsChecked = isChecked;
                        });
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: EdgeInsets.all(25),
                  child: Text(
                    "Appointments",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 75 / 20,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 2),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                  ),
                  items: _buildAppointmentSlides(),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
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
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.white,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Widget _buildBox(String imagePath, String text) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (imagePath == 'assets/doctor.png') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Recomend()),
            );
          } else if (imagePath == 'assets/cart.png') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Shop()),
            );
          }
        },
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.white,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: 40,
                height: 40,
              ),
              const SizedBox(height: 8),
              Text(
                text,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChecklistItem(
      String itemName, String time, bool isChecked, Function(bool)? onChanged) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            itemName,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(width: 10),
          Text(
            time,
            style: const TextStyle(fontSize: 16),
          ),
          Checkbox(
            value: isChecked,
            onChanged: onChanged != null
                ? (bool? value) => onChanged(value ?? false)
                : null,
            activeColor: Color.fromARGB(255, 112, 238, 119),
            shape: const CircleBorder(),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildAppointmentSlides() {
    List<Map<String, String>> appointments = [
      {
        'name': 'Dr. Karan Sharma',
        'specialization': 'Dentist',
        'date': 'Wednesday, 5th Jan',
        'time': '9:00 PM',
        'image': 'assets/profile_image2.png',
      },
      {
        'name': 'Dr. Olivia Wilson',
        'specialization': 'Physiotherapy',
        'date': 'Thursday, 8th Jan',
        'time': '10:00 AM',
        'image': 'assets/profile_image3.png',
      },
      {
        'name': 'Dr. Jonathan Patirson',
        'specialization': 'Pediatrician',
        'date': 'Thursday, 8th Jan',
        'time': '11:00 AM',
        'image': 'assets/profile_image4.png',
      },
    ];

    List<Widget> appointmentCards = appointments.map((appointment) {
      return Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 88,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                image: DecorationImage(
                  image: AssetImage(appointment['image']!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appointment['name']!,
                    style: const TextStyle(
                      color: Color.fromRGBO(76, 175, 80, 1),
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    appointment['specialization']!,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 112, 238, 119),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 20,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      appointment['date']!,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 20,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      appointment['time']!,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }).toList();

    return appointmentCards;
  }
}

class Article {
  String? title;
  String? url;

  Article({this.title, this.url});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      url: json['url'],
    );
  }
}

class _Welcomestate extends StatefulWidget {
  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<_Welcomestate> {
  int cartItemCount = 0;
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
