import 'package:flutter/material.dart';
import 'package:payment_management_app/user.dart';
import 'appbar_presenter.dart';
import 'appbar_view.dart';

class AppbarScreen extends StatefulWidget {
  @override
  _AppbarScreenState createState() => _AppbarScreenState();
}

class _AppbarScreenState extends State<AppbarScreen> implements AppbarView {
  late AppbarPresenter _presenter;
  late User _user;
  double _balance = 1234.56;

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
      body: CustomScrollView(
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
        ],
      ),
    );
  }
}