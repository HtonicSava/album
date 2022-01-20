// import 'package:album/UI/widgets/custom_bottom_nav_bar.dart';
// import 'package:album/navigator/router_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class TestNavigatorAlbum extends StatelessWidget {
//   final Function(BuildContext context) onBtnTap;
//   final String text;
//
//   const TestNavigatorAlbum({
//     Key? key,
//     required this.onBtnTap,
//     required this.text,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//     appBar: AppBar(),
//     bottomNavigationBar: BlocBuilder<RouterCubit, RouterState>(
//
//       builder: (context, state) => CustomBottomNavBar(context) ,
//     ) ,
//     body: Row(
//       mainAxisAlignment: MainAxisAlignment.center
//       ,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(text),
//             const SizedBox(height: 20),
//             ElevatedButton(onPressed: () => onBtnTap(context), child: const Text("Push me")),
//           ],
//         ),
//       ],
//     ),
//   );
// }