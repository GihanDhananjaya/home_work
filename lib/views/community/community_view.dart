import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_work/views/community/widget/comment_input_component.dart';
import 'package:home_work/views/community/widget/comment_list_component.dart';

import '../../utils/app_colors.dart';

class CommunityView extends StatefulWidget {
  const CommunityView({super.key});

  @override
  State<CommunityView> createState() => _CommunityViewState();
}

class _CommunityViewState extends State<CommunityView> {
  final commentController = TextEditingController();
  bool isSelect =false;

  @override
  void initState() {
    super.initState();
    final currentUser = FirebaseAuth.instance.currentUser;
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
        title: Center(
          child: Text(
            'Community',
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('community')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No data available'));
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var document = snapshot.data!.docs[index];
                    return LocationInfoCard(
                      name: document['user_name'],
                      comment: document['comment'],
                      isSelect: false,
                      initialLikeCount: document['likeCount'] ?? 0,
                      likedBy: document['likedBy'] ?? [],
                      docId: document.id,
                    );
                  },
                );
              },
            ),
          ),
          CommentInputBox(
            controller: commentController,
            sendTap: () async {
              final commentText = commentController.text.trim();
              final currentUser = FirebaseAuth.instance.currentUser;

              if (commentText.isEmpty || currentUser == null) return;

              try {
                final userDoc = await FirebaseFirestore.instance
                    .collection('users')
                    .doc(currentUser.uid)
                    .get();

                final userName =
                    userDoc['name'];

                // Save comment with name
                await FirebaseFirestore.instance.collection('community').add({
                  'comment': commentText,
                  'timestamp': FieldValue.serverTimestamp(),
                  'user_id': currentUser.uid,
                  'user_name': userName,
                  'likeCount': 0,
                  'likedBy': [],
                });

                commentController.clear();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Comment added')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to add comment: $e')),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
