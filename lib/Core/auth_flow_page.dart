import 'package:auto_route/auto_route.dart';
import 'package:exptracker/Core/cubit/authflow_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Src/Router/router.gr.dart';

class AuthFlowPage extends StatelessWidget {
  const AuthFlowPage({super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.watch<AuthflowCubit>().state;

    return AutoRouter.declarative(
      routes: (handler) {
        switch (state.status) {
          case Status.initial:
            return [];

          case Status.login:
            return [const DashBoardRoute()];

          case Status.logout:
          
            return [const LoginRoute()];
        }
      },
    );
  }
}
