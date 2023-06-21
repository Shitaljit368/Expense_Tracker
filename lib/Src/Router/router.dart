import 'package:auto_route/auto_route.dart';
import 'package:exptracker/Core/loading.dart';
import 'package:exptracker/Src/First_two_screens/getstarted.dart';
import 'package:exptracker/Src/Forgot_password_module/forgot_password.dart';
import 'package:exptracker/Src/Forgot_password_module/save_password.dart';
import 'package:exptracker/Src/Forgot_password_module/verify_password.dart';
import 'package:exptracker/Src/Login_module/Page/login_page.dart';
import 'package:exptracker/Src/Sign_in_module/Page/sign_in.dart';

import '../../Core/auth_flow_page.dart';
import '../../Utility/firebase_authentication.dart';
import '../Main_Page/chart_page.dart';
import '../Main_Page/dashboard.dart';
import '../Main_Page/home_page.dart';
import '../Main_Page/list_of_expenses.dart';
import '../Main_Page/list_of_income.dart';
import '../Main_Page/list_of_savings.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(page: SignInPage),
    AutoRoute(page: ForgotPasswordPage),
    AutoRoute(page: VerifyPasswordPage),
    AutoRoute(page: SavePasswordPage),
    AutoRoute(page: GetStartedPage),
    AutoRoute(page: AuthPage),
    AutoRoute(page: MyExpenseListPage),
    AutoRoute(page: MySavingsListPage),
    AutoRoute(page: MyIncomeListPage),
    AutoRoute(page: SpinkitPage),
    AutoRoute(
      page: AuthFlowPage,
      initial: true,
      path: '/',
      children: [
        AutoRoute(
          page: DashBoardPage,
          children: [
            AutoRoute(page: ExpenseBoardPage),
            AutoRoute(page: ChartPage),
          ],
        ),
        AutoRoute(page: LoginPage),
      ],
    ),
  ],
)
class $AppRouter {}
