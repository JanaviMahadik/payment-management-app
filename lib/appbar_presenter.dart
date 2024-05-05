//appbar_presenter.dart
import 'package:payment_management_app/user.dart';
import 'appbar_view.dart';

abstract class AppbarPresenter {
  void loadUserData();
}

class AppbarPresenterImpl implements AppbarPresenter {
  final AppbarView _view;

  AppbarPresenterImpl(this._view);

  @override
  void loadUserData() {
    final user = User(
      name: 'Janavi Mahadik',
      description: 'Software Engineer intern',
      photoUrl: 'https://th.bing.com/th/id/OIP.h8x8sLthc7TlaKAihKaY7AHaLE?w=127&h=190&c=7&r=0&o=5&dpr=1.3&pid=1.7',
    );
    _view.updateUserData(user);
  }
}