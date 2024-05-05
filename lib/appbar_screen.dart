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

  List<String> _userImages = [
    'https://th.bing.com/th?id=OIP.g1m0K7yumfwkc_ub224a4AHaE7&w=306&h=203&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2',
    'https://th.bing.com/th?id=OIP.IJKEfyGfsngEzegazo0L2wHaGm&w=264&h=236&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2',
    'https://th.bing.com/th?id=OIP.Cyh8Uho74DcMA4MTnMUjbAHaLC&w=204&h=305&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2',
    'https://th.bing.com/th?id=OIP.mT0xDqqWpCcm8my_uYkMUwHaLG&w=204&h=306&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2',
    'https://th.bing.com/th?id=OIP.Sx4DawgrM3gPDgHxtGIKQAHaFA&w=304&h=205&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2',
    'https://th.bing.com/th?id=OIP.QexcnKLol8SaCraOMz2o6AHaFo&w=286&h=217&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2',
    'https://th.bing.com/th?id=OSK.HEROkQRuJ1powxZKx_jC17o5J2XaSDLZSe4V18ev3ojsKPo&w=472&h=280&c=13&rs=2&o=6&oif=webp&dpr=1.3&pid=SANGAM',
    'https://th.bing.com/th?id=OSK.mmcolmV6Cz2e80qVyhsO0z81Nyep0lKtMpStCnUNAA4qxnrc&w=130&h=100&c=8&o=6&dpr=1.3&pid=SANGAM',
    'https://th.bing.com/th?id=OSK.mmcol1gZP2Vo0l0jyugVKL07YCbP8G_EHtnO1skZksAV5mYU&w=130&h=100&c=8&o=6&dpr=1.3&pid=SANGAM',
    'https://th.bing.com/th/id/OIP.Gh8QtnFEh8LOj1a6-Q88FQHaFj?w=236&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
    'https://th.bing.com/th?q=Cat+Book&w=120&h=120&c=1&rs=1&qlt=90&cb=1&dpr=1.3&pid=InlineBlock&mkt=en-IN&cc=IN&setlang=en&adlt=strict&t=1&mw=247',
    'https://th.bing.com/th?q=Flying+Cat&w=120&h=120&c=1&rs=1&qlt=90&cb=1&dpr=1.3&pid=InlineBlock&mkt=en-IN&cc=IN&setlang=en&adlt=strict&t=1&mw=247',
    'https://th.bing.com/th?q=Cat+Play&w=120&h=120&c=1&rs=1&qlt=90&cb=1&dpr=1.3&pid=InlineBlock&mkt=en-IN&cc=IN&setlang=en&adlt=strict&t=1&mw=247',
    'https://th.bing.com/th?q=Winter+Cat&w=120&h=120&c=1&rs=1&qlt=90&cb=1&dpr=1.3&pid=InlineBlock&mkt=en-IN&cc=IN&setlang=en&adlt=strict&t=1&mw=247',
  ];

  List<Map<String, dynamic>> _filteredTransactions = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _presenter = AppbarPresenterImpl(this);
    _presenter.loadUserData();
    _filteredTransactions = _transactions;
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    String searchText = _searchController.text.toLowerCase();
    setState(() {
      _filteredTransactions = _transactions.where((transaction) {
        String item = transaction['item'].toLowerCase();
        return item.contains(searchText);
      }).toList();
    });
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Row(
                children: [
                Tooltip(
                message: 'View Profile',
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserProfilePage(user: _user)),
                    );
                  },
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(_user.photoUrl),
                    radius: 30.0,
                  ),
                ),
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
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                tooltip: "search transaction",
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: _CustomSearchDelegate(_transactions),
                  );
                },
              ),
            ],
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
                itemCount: _userImages.length, // Number of user images
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(_userImages[index]),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          'User ${index + 1}', // Change to user specific information if available
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
                  title: Text(_filteredTransactions[index]['item']),
                  trailing: Text(
                    '\$${_filteredTransactions[index]['amount'].toStringAsFixed(2)}',
                  ),
                );
              },
              childCount: _filteredTransactions.length,
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

class _CustomSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> transactions;

  _CustomSearchDelegate(this.transactions);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Map<String, dynamic>> results = transactions.where((transaction) {
      String item = transaction['item'].toLowerCase();
      return item.contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index]['item']),
          subtitle: Text('\$${results[index]['amount'].toStringAsFixed(2)}'),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Map<String, dynamic>> results = transactions.where((transaction) {
      String item = transaction['item'].toLowerCase();
      return item.contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index]['item']),
          subtitle: Text('\$${results[index]['amount'].toStringAsFixed(2)}'),
        );
      },
    );
  }
}

class UserProfilePage extends StatelessWidget {
  final User user;

  UserProfilePage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: ListView(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(user.photoUrl),
                  radius: 50.0,
                ),
                SizedBox(height: 20.0),
                Text(
                  user.name,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  user.description,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  height: 60.0, // Adjust the height as needed
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Personal Info'),
                  ),
                ),
                Container(
                  height: 60.0, // Adjust the height as needed
                  child: ListTile(
                    leading: Icon(Icons.qr_code),
                    title: Text('My QR Code'),
                  ),
                ),
                Container(
                  height: 60.0, // Adjust the height as needed
                  child: ListTile(
                    leading: Icon(Icons.credit_card),
                    title: Text('Banks and Cards'),
                  ),
                ),
                Container(
                  height: 60.0, // Adjust the height as needed
                  child: ListTile(
                    leading: Icon(Icons.account_balance_wallet),
                    title: Text('Payment Preferences'),
                  ),
                ),
                Container(
                  height: 60.0, // Adjust the height as needed
                  child: ListTile(
                    leading: Icon(Icons.account_balance),
                    title: Text('Accounts Payment'),
                  ),
                ),
                Container(
                  height: 60.0, // Adjust the height as needed
                  child: ListTile(
                    leading: Icon(Icons.security),
                    title: Text('Login and Security'),
                  ),
                ),
                Container(
                  height: 60.0, // Adjust the height as needed
                  child: ListTile(
                    leading: Icon(Icons.notifications),
                    title: Text('Notifications'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
