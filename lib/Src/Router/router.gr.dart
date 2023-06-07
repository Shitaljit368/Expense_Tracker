// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i16;
import 'package:flutter/material.dart' as _i17;

import '../../Core/auth_flow_page.dart' as _i11;
import '../../Core/loading.dart' as _i10;
import '../../Utility/firebase_authentication.dart' as _i6;
import '../First_two_screens/getstarted.dart' as _i5;
import '../Forgot_password_module/forgot_password.dart' as _i2;
import '../Forgot_password_module/save_password.dart' as _i4;
import '../Forgot_password_module/verify_password.dart' as _i3;
import '../Login_module/Page/login_page.dart' as _i13;
import '../Main_Page/chart_page.dart' as _i15;
import '../Main_Page/dashboard.dart' as _i12;
import '../Main_Page/home_page.dart' as _i14;
import '../Main_Page/list_of_expenses.dart' as _i7;
import '../Main_Page/list_of_income.dart' as _i9;
import '../Main_Page/list_of_savings.dart' as _i8;
import '../Sign_in_module/Page/sign_in.dart' as _i1;

class AppRouter extends _i16.RootStackRouter {
  AppRouter([_i17.GlobalKey<_i17.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i16.PageFactory> pagesMap = {
    SignInRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SignInPage(),
      );
    },
    ForgotPasswordRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.ForgotPasswordPage(),
      );
    },
    VerifyPasswordRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.VerifyPasswordPage(),
      );
    },
    SavePasswordRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.SavePasswordPage(),
      );
    },
    GetStartedRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.GetStartedPage(),
      );
    },
    AuthRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.AuthPage(),
      );
    },
    MyExpenseListRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.MyExpenseListPage(),
      );
    },
    MySavingsListRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.MySavingsListPage(),
      );
    },
    MyIncomeListRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.MyIncomeListPage(),
      );
    },
    SpinkitRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.SpinkitPage(),
      );
    },
    AuthFlowRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i11.AuthFlowPage(),
      );
    },
    DashBoardRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i12.DashBoardPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i13.LoginPage(),
      );
    },
    ExpenseBoardRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i14.ExpenseBoardPage(),
      );
    },
    ChartRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i15.ChartPage(),
      );
    },
  };

  @override
  List<_i16.RouteConfig> get routes => [
        _i16.RouteConfig(
          SignInRoute.name,
          path: '/sign-in-page',
        ),
        _i16.RouteConfig(
          ForgotPasswordRoute.name,
          path: '/forgot-password-page',
        ),
        _i16.RouteConfig(
          VerifyPasswordRoute.name,
          path: '/verify-password-page',
        ),
        _i16.RouteConfig(
          SavePasswordRoute.name,
          path: '/save-password-page',
        ),
        _i16.RouteConfig(
          GetStartedRoute.name,
          path: '/get-started-page',
        ),
        _i16.RouteConfig(
          AuthRoute.name,
          path: '/auth-page',
        ),
        _i16.RouteConfig(
          MyExpenseListRoute.name,
          path: '/my-expense-list-page',
        ),
        _i16.RouteConfig(
          MySavingsListRoute.name,
          path: '/my-savings-list-page',
        ),
        _i16.RouteConfig(
          MyIncomeListRoute.name,
          path: '/my-income-list-page',
        ),
        _i16.RouteConfig(
          SpinkitRoute.name,
          path: '/spinkit-page',
        ),
        _i16.RouteConfig(
          AuthFlowRoute.name,
          path: '/',
          children: [
            _i16.RouteConfig(
              DashBoardRoute.name,
              path: 'dash-board-page',
              parent: AuthFlowRoute.name,
              children: [
                _i16.RouteConfig(
                  ExpenseBoardRoute.name,
                  path: 'expense-board-page',
                  parent: DashBoardRoute.name,
                ),
                _i16.RouteConfig(
                  ChartRoute.name,
                  path: 'chart-page',
                  parent: DashBoardRoute.name,
                ),
              ],
            ),
            _i16.RouteConfig(
              LoginRoute.name,
              path: 'login-page',
              parent: AuthFlowRoute.name,
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.SignInPage]
class SignInRoute extends _i16.PageRouteInfo<void> {
  const SignInRoute()
      : super(
          SignInRoute.name,
          path: '/sign-in-page',
        );

  static const String name = 'SignInRoute';
}

/// generated route for
/// [_i2.ForgotPasswordPage]
class ForgotPasswordRoute extends _i16.PageRouteInfo<void> {
  const ForgotPasswordRoute()
      : super(
          ForgotPasswordRoute.name,
          path: '/forgot-password-page',
        );

  static const String name = 'ForgotPasswordRoute';
}

/// generated route for
/// [_i3.VerifyPasswordPage]
class VerifyPasswordRoute extends _i16.PageRouteInfo<void> {
  const VerifyPasswordRoute()
      : super(
          VerifyPasswordRoute.name,
          path: '/verify-password-page',
        );

  static const String name = 'VerifyPasswordRoute';
}

/// generated route for
/// [_i4.SavePasswordPage]
class SavePasswordRoute extends _i16.PageRouteInfo<void> {
  const SavePasswordRoute()
      : super(
          SavePasswordRoute.name,
          path: '/save-password-page',
        );

  static const String name = 'SavePasswordRoute';
}

/// generated route for
/// [_i5.GetStartedPage]
class GetStartedRoute extends _i16.PageRouteInfo<void> {
  const GetStartedRoute()
      : super(
          GetStartedRoute.name,
          path: '/get-started-page',
        );

  static const String name = 'GetStartedRoute';
}

/// generated route for
/// [_i6.AuthPage]
class AuthRoute extends _i16.PageRouteInfo<void> {
  const AuthRoute()
      : super(
          AuthRoute.name,
          path: '/auth-page',
        );

  static const String name = 'AuthRoute';
}

/// generated route for
/// [_i7.MyExpenseListPage]
class MyExpenseListRoute extends _i16.PageRouteInfo<void> {
  const MyExpenseListRoute()
      : super(
          MyExpenseListRoute.name,
          path: '/my-expense-list-page',
        );

  static const String name = 'MyExpenseListRoute';
}

/// generated route for
/// [_i8.MySavingsListPage]
class MySavingsListRoute extends _i16.PageRouteInfo<void> {
  const MySavingsListRoute()
      : super(
          MySavingsListRoute.name,
          path: '/my-savings-list-page',
        );

  static const String name = 'MySavingsListRoute';
}

/// generated route for
/// [_i9.MyIncomeListPage]
class MyIncomeListRoute extends _i16.PageRouteInfo<void> {
  const MyIncomeListRoute()
      : super(
          MyIncomeListRoute.name,
          path: '/my-income-list-page',
        );

  static const String name = 'MyIncomeListRoute';
}

/// generated route for
/// [_i10.SpinkitPage]
class SpinkitRoute extends _i16.PageRouteInfo<void> {
  const SpinkitRoute()
      : super(
          SpinkitRoute.name,
          path: '/spinkit-page',
        );

  static const String name = 'SpinkitRoute';
}

/// generated route for
/// [_i11.AuthFlowPage]
class AuthFlowRoute extends _i16.PageRouteInfo<void> {
  const AuthFlowRoute({List<_i16.PageRouteInfo>? children})
      : super(
          AuthFlowRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'AuthFlowRoute';
}

/// generated route for
/// [_i12.DashBoardPage]
class DashBoardRoute extends _i16.PageRouteInfo<void> {
  const DashBoardRoute({List<_i16.PageRouteInfo>? children})
      : super(
          DashBoardRoute.name,
          path: 'dash-board-page',
          initialChildren: children,
        );

  static const String name = 'DashBoardRoute';
}

/// generated route for
/// [_i13.LoginPage]
class LoginRoute extends _i16.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: 'login-page',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i14.ExpenseBoardPage]
class ExpenseBoardRoute extends _i16.PageRouteInfo<void> {
  const ExpenseBoardRoute()
      : super(
          ExpenseBoardRoute.name,
          path: 'expense-board-page',
        );

  static const String name = 'ExpenseBoardRoute';
}

/// generated route for
/// [_i15.ChartPage]
class ChartRoute extends _i16.PageRouteInfo<void> {
  const ChartRoute()
      : super(
          ChartRoute.name,
          path: 'chart-page',
        );

  static const String name = 'ChartRoute';
}
