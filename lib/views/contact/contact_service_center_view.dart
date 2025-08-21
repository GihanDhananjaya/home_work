import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';

class ContactServiceCenterView extends StatefulWidget {
  const ContactServiceCenterView({super.key});

  @override
  State<ContactServiceCenterView> createState() =>
      _ContactServiceCenterViewState();
}

class _ContactServiceCenterViewState extends State<ContactServiceCenterView> {
  String? _token;

  final List<String> images = [
    AppImages.appHome5,
    AppImages.appHome6,
    AppImages.appHome7,
  ];

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.containerColor7,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.btnGradient1, AppColors.fontColorDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: 50.0),
          child: Text(
            'User Points Table',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
          ),
        ),
      ),
      body: Center(
        child:  Column(
          children: [
            SizedBox(height: 10,),
            Container(
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  AppImages.appProfileIcon,
                  height: 180,
                  width: 180,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Mr. Home Worker',
              style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Service Center',
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 12),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 40),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       InkResponse(
            //           onTap:(){
            //             _makePhoneCall('0712345678');
            //           },
            //           child: _buildInfoCard('400+', 'Call Now', Icons.call,Colors.green)),
            //       _buildInfoCard('4 Yr+', 'Experience', Icons.work_history,Colors.blueAccent),
            //       _buildInfoCard('4.4', 'Rating', Icons.star,Colors.orange),
            //     ],
            //   ),
            // ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Gentle and expert dental care for children, ensuring healthy teeth, bright smiles, and a comfortable experience every visit...",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              'Our Service Category',
              style: TextStyle(color: Colors.black54,fontWeight:FontWeight.w700),
            ),
            const SizedBox(height: 20),
            // SizedBox(
            //   height: 50,
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //     itemCount: 7,
            //     padding: const EdgeInsets.symmetric(horizontal: 16),
            //     itemBuilder: (context, index) {
            //       List<String> days = ['Fan', 'Washing Machine', 'Gas conker', 'Fridge', 'Blender', 'TV', 'Radio'];
            //       return Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 8),
            //         child: Chip(
            //           label: Text(days[index]),
            //           backgroundColor: Colors.grey[850],
            //           labelStyle: TextStyle(color: Colors.grey),
            //         ),
            //       );
            //     },
            //   ),
            // ),
            // CarouselSlider(
            //   items: images.map((imagePath) {
            //     return ClipRRect(
            //       borderRadius: BorderRadius.circular(10),
            //       child: Image.asset(imagePath, fit: BoxFit.cover, width: double.infinity),
            //     );
            //   }).toList(),
            //   options: CarouselOptions(
            //     height: 150,
            //     autoPlay: true,
            //     enlargeCenterPage: true,
            //     viewportFraction: 0.9,
            //   ),
            // )

          ],
        ),
      ),
    );
  }

  // Widget _buildInfoCard(String value, String label, IconData icon,Color iconColor) {
  //   return Column(
  //     children: [
  //       Icon(icon, color: iconColor, size: 28),
  //       const SizedBox(height: 4),
  //       Text(value, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
  //       Text(label, style: TextStyle(color: Colors.black, fontSize: 12)),
  //     ],
  //   );
  // }

  // void _makePhoneCall(String phoneNumber) async {
  //   final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
  //   if (await canLaunchUrl(phoneUri)) {
  //     await launchUrl(phoneUri);
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Could not launch phone dialer')),
  //     );
  //   }
  // }

}
