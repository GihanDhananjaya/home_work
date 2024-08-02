// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'details_list_view.dart';
//
// class HomeView extends StatefulWidget {
//   @override
//   State<HomeView> createState() => _HomeViewState();
// }
//
// class _HomeViewState extends State<HomeView> {
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//
//   Future<void> _saveData() async {
//     String firstName = _firstNameController.text;
//     String lastName = _lastNameController.text;
//
//     if (firstName.isNotEmpty && lastName.isNotEmpty) {
//       try {
//         await FirebaseFirestore.instance.collection('personal_details').add({
//           'first_name': firstName,
//           'last_name': lastName,
//         });
//         _firstNameController.clear();
//         _lastNameController.clear();
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Data saved successfully!')),
//         );
//       } catch (e) {
//         print('Error saving data: $e');
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Failed to save data.')),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please fill out all fields')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home Work'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             TextField(
//               controller: _firstNameController,
//               decoration: const InputDecoration(labelText: 'First Name'),
//             ),
//             TextField(
//               controller: _lastNameController,
//               decoration: const InputDecoration(labelText: 'Last Name'),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _saveData,
//               child: const Text('Save Data'),
//             ),
//
//             SizedBox(height: 20,),
//             GestureDetector(
//               onTap: (){
//                 Navigator.pushNamed(context, '/details');
//               },
//               child: Container(height: 100,width: double.infinity,
//               decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
//                 color: Colors.cyanAccent,
//               ),
//                 child: Center(child: Text("Details List",style: TextStyle(
//                     fontSize: 16,fontWeight: FontWeight.w800),)),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
