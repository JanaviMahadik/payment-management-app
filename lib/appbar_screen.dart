//appbar_screen.dart
import 'package:flutter/material.dart';
import 'package:payment_management_app/user.dart';
import 'appbar_presenter.dart';
import 'appbar_view.dart';
import 'package:shimmer/shimmer.dart';

class AppbarScreen extends StatefulWidget {
  @override
  _AppbarScreenState createState() => _AppbarScreenState();
}

class _AppbarScreenState extends State<AppbarScreen> implements AppbarView {
  late AppbarPresenter _presenter;
  late User _user;
  double _balance = 1234.56;
  int _currentIndex = 0;
  List<Map<String, dynamic>> _transactions = [
    {'item': 'Groceries', 'amount': 50.25},
    {'item': 'Dining', 'amount': 32.75},
    {'item': 'Utilities', 'amount': 75.00},
    {'item': 'Entertainment', 'amount': 20.50},
    {'item': 'Clothing', 'amount': 80.00},
    {'item': 'College', 'amount': 80.00},
    {'item': 'travelling', 'amount': 80.00},
  ];

  @override
  void initState() {
    super.initState();
    _presenter = AppbarPresenterImpl(this);
    _presenter.loadUserData();
  }

  @override
  void updateUserData(User user) {
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          Expanded(
          child:CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 200.0,
                flexibleSpace: FlexibleSpaceBar(
                  title: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(_user.photoUrl),
                        radius: 30.0,
                      ),
                      SizedBox(width: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _user.name,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            _user.description,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Balance',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$${_balance.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Send Again',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 100.0, // Adjust the height as needed
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 20, // Number of circles
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage('https://th.bing.com/th/id/OIP.E95e-X6l6dr3sXlS2Gc7lwHaHa?w=201&h=200&c=7&r=0&o=5&dpr=1.3&pid=1.7'),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              'User Name',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    return ListTile(
                      title: Text(_transactions[index]['item']),
                      trailing: Text('\$${_transactions[index]['amount'].toStringAsFixed(2)}'),
                    );
                  },
                  childCount: _transactions.length,
                ),
              ),
            ],
          ),

          ),
          Scaffold(
            body: Center(
              child: Text('Scan Receipt'),
            ),
          ),
          Scaffold(
            body: Center(
              child: Text('Send'),
            ),
          ),
          Scaffold(
            body: Center(
              child: Text('Settings'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Shimmer.fromColors(
              baseColor: Colors.black,
              highlightColor: Colors.grey[300]!,
              child: Icon(Icons.dashboard),
            ),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Shimmer.fromColors(
              baseColor: Colors.black,
              highlightColor: Colors.grey[300]!,
              child: Icon(Icons.camera_alt),
            ),
            label: 'Scan Receipt',
          ),
          BottomNavigationBarItem(
            icon: Shimmer.fromColors(
              baseColor: Colors.black,
              highlightColor: Colors.grey[300]!,
              child: Icon(Icons.send),
            ),
            label: 'Send',
          ),
          BottomNavigationBarItem(
            icon: Shimmer.fromColors(
              baseColor: Colors.black,
              highlightColor: Colors.grey[300]!,
              child: Icon(Icons.settings),
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
