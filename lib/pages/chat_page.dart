import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key, required this.email});
  final String email;

  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('Messages');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal,
        body: StreamBuilder<QuerySnapshot>(
          stream:
              collectionReference.orderBy('date', descending: true).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Error Occurred'));
            } else if (!snapshot.hasData ||
                snapshot.data == null ||
                snapshot.data!.docs.isEmpty) {
              return Column(
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Start chatting now!!",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (value) {
                        controller.clear();
                        collectionReference.add({
                          "text": value,
                          'date': DateTime.now(),
                          'id': email
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Message",
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  )
                ],
              );
            } else {
              final List<DocumentSnapshot> documents = snapshot.data!.docs;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        controller: scrollController,
                        itemCount: documents.length,
                        reverse: true,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BubbleFormat(documents, index, email));
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (value) {
                        scrollController
                            .jumpTo(scrollController.position.minScrollExtent);
                        controller.clear();
                        collectionReference.add({
                          "text": value,
                          'date': DateTime.now(),
                          'id': email
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Message",
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
          },
        ));
  }
}

Widget BubbleFormat(var documents, var index, var email) {
  if (documents[index]['id'] == email) {
    return Bubble(
      color: Colors.greenAccent,
      nip: BubbleNip.rightTop,
      alignment: Alignment.topRight,
      child: Text(
        documents[index]['text'],
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
    );
  } else {
    return Bubble(
      color: Colors.tealAccent,
      nip: BubbleNip.leftTop,
      alignment: Alignment.topLeft,
      child: Text(
        documents[index]['text'],
        style: const TextStyle(fontSize: 15),
      ),
    );
  }
}
