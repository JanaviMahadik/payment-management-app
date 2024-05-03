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
        ],
      ),
    );
  }
}