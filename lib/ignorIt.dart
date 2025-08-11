// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:flutter/material.dart';
//
// class VarefayEmail extends StatelessWidget {
//   const VarefayEmail({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return  ConditionalBuilder(
//       condition: SocialAppCubit.get(context).model != null,
//
//       builder: (context) {
//         var model = SocialAppCubit.get(context).model;
//         return Column(
//           children: [
//             if (!(FirebaseAuth.instance.currentUser?.emailVerified ?? true))
//               Container(
//                 color: Colors.amber.withOpacity(.6),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                   child: Row(
//                     children: [
//                       const Icon(Icons.info_outline),
//                       const SizedBox(width: 10.0),
//                       const Expanded(
//                         child: Text('Please verify your email'),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           FirebaseAuth.instance.currentUser
//                               ?.sendEmailVerification()
//                               .then((_) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text('Verification email sent!'),
//                               ),
//                             );
//                           }).catchError((error) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text('Error: $error'),
//                               ),
//                             );
//                           });
//                         },
//                         child: const Text('Send'),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//           ],
//         );
//       },
//       fallback: (context) =>
//       const Center(child: CircularProgressIndicator()),
//     ),
//   }
// }
