import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LocationInfoCard extends StatefulWidget {
  final String name;
  final String comment;
  final bool isSelect;
  final int initialLikeCount;
  final String docId;
  final List likedBy;

  const LocationInfoCard({
    super.key,
    required this.name,
    required this.comment,
    this.isSelect = false, // default unselect
    this.initialLikeCount = 0,
    required this.docId,
    required this.likedBy,
  });

  @override
  State<LocationInfoCard> createState() => _LocationInfoCardState();
}

class _LocationInfoCardState extends State<LocationInfoCard> {
  late bool isSelect;
  late int likeCount;

  @override
  void initState() {
    super.initState();
    isSelect = widget.isSelect; // default false unless given
    likeCount = widget.initialLikeCount;
    final currentUser = FirebaseAuth.instance.currentUser;
    isSelect = widget.likedBy.contains(currentUser?.uid);
    likeCount = widget.initialLikeCount;
  }

  void toggleFavorite() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    setState(() {
      isSelect = !isSelect;
      likeCount += isSelect ? 1 : -1;
    });

    try {
      final docRef =
      FirebaseFirestore.instance.collection('community').doc(widget.docId);

      await docRef.update({
        'likeCount': likeCount,
        'likedBy': isSelect
            ? FieldValue.arrayUnion([currentUser.uid])
            : FieldValue.arrayRemove([currentUser.uid]),
      });
    } catch (e) {
      print('Failed to update like info: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
      child: Row(
        children: [
          const Icon(Icons.supervised_user_circle),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Customer',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.push_pin, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        widget.comment,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              InkResponse(
                onTap: toggleFavorite,
                child: Icon(
                  isSelect ? Icons.favorite : Icons.favorite_border,
                  color: isSelect ? Colors.red : Colors.grey,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '$likeCount',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
