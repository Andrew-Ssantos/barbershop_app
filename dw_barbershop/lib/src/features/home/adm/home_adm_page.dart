import 'package:dw_barbershop/src/features/home/widgets/home_header.dart';
import 'package:flutter/material.dart';

class HomeAdmPage extends StatelessWidget {
  const HomeAdmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: HomeHeader(),
          ),
        ],
      ),
    );
  }
}
