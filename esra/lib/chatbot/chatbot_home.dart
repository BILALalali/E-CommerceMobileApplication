// import 'package:dialog_flowtter/dialog_flowtter.dart';
// import 'package:esra/chatbot/message_screen.dart';
// import 'package:flutter/material.dart';

// class ChatbotHome extends StatefulWidget {
//   const ChatbotHome({super.key});

//   @override
//   State<ChatbotHome> createState() => _ChatbotHomeState();
// }

// class _ChatbotHomeState extends State<ChatbotHome> {
//   late DialogFlowtter dialogFlowtter;
//   final TextEditingController controller = TextEditingController();
//   List<Map<String, dynamic>> messages = [];

//   @override
//   void initState() {
//     super.initState();
//     DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("ChatBot",
//             style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
//         backgroundColor: Colors.deepPurple[400], // Changed to avoid error
//         centerTitle: true,
//         elevation: 4,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Colors.deepPurple[100]!,
//               Colors.deepPurple[300]!
//             ], // Changed to avoid error
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Column(
//           children: [
//             // Screen for displaying messages
//             Expanded(child: MessageScreen(messages: messages)),

//             // Text input field with send button
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               decoration: BoxDecoration(
//                 color: Color.fromRGBO(255, 255, 255, 0.9), // Updated opacity
//                 borderRadius: BorderRadius.circular(30),
//                 boxShadow: [
//                   BoxShadow(
//                     blurRadius: 10,
//                     color: Color.fromRGBO(0, 0, 0, 0.1), // Updated opacity
//                     spreadRadius: 1,
//                   )
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   // Text field for message input
//                   Expanded(
//                     child: TextField(
//                       controller: controller,
//                       style: TextStyle(
//                           color:
//                               Colors.deepPurple[700]), // Updated to avoid error
//                       decoration: InputDecoration(
//                         hintText: "Type your message...",
//                         hintStyle: TextStyle(color: Colors.deepPurple[300]),
//                         border: InputBorder.none,
//                         contentPadding: const EdgeInsets.symmetric(
//                             vertical: 10, horizontal: 15),
//                       ),
//                     ),
//                   ),

//                   // Send button
//                   IconButton(
//                     onPressed: () {
//                       sendMessage(controller.text);
//                       controller.clear();
//                     },
//                     icon: Icon(Icons.send,
//                         color:
//                             Colors.deepPurple[400]), // Updated to avoid error
//                     iconSize: 30,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Function to send message to Dialogflow
//   sendMessage(String text) async {
//     if (text.isEmpty) {
//       print("Message is Empty");
//     } else {
//       setState(() {
//         addMessage(
//           Message(text: DialogText(text: [text])),
//           true,
//         );
//       });

//       // Send the message to DialogFlow and get the response
//       DetectIntentResponse response = await dialogFlowtter.detectIntent(
//         queryInput: QueryInput(
//           text: TextInput(text: text),
//         ),
//       );

//       // If response exists, display the message from DialogFlow
//       if (response.message != null) {
//         setState(() {
//           addMessage(response.message!);
//         });
//       }
//     }
//   }

//   // Add messages to the chat
//   addMessage(Message message, [bool isUserMessage = false]) {
//     messages.add({"message": message, "isUserMessage": isUserMessage});
//   }
// }
////
///

import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:esra/chatbot/message_screen.dart';
import 'package:flutter/material.dart';

class ChatbotHome extends StatefulWidget {
  const ChatbotHome({super.key});

  @override
  State<ChatbotHome> createState() => _ChatbotHomeState();
}

class _ChatbotHomeState extends State<ChatbotHome> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController controller = TextEditingController();
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70), // Height of the AppBar
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(210, 54, 121, 71),
                const Color.fromARGB(189, 78, 53, 123),
              ], // Gradient colors
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            title: const Text("ChatBot",
                style:
                    TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
            backgroundColor:
                Colors.transparent, // Make the background transparent
            centerTitle: true,
            elevation: 0, // Remove shadow
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(211, 141, 115, 188),
              const Color.fromARGB(255, 88, 148, 81)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            // Screen for displaying messages
            Expanded(child: MessageScreen(messages: messages)),

            // Text input field with send button
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.9), // Updated opacity
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Color.fromRGBO(0, 0, 0, 0.1), // Updated opacity
                    spreadRadius: 1,
                  )
                ],
              ),
              child: Row(
                children: [
                  // Text field for message input
                  Expanded(
                    child: TextField(
                      controller: controller,
                      style: TextStyle(
                          color:
                              Colors.deepPurple[700]), // Updated to avoid error
                      decoration: InputDecoration(
                        hintText: "Type your message...",
                        hintStyle: TextStyle(color: Colors.deepPurple[300]),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                      ),
                    ),
                  ),

                  // Send button
                  IconButton(
                    onPressed: () {
                      sendMessage(controller.text);
                      controller.clear();
                    },
                    icon: Icon(Icons.send,
                        color:
                            Colors.deepPurple[400]), // Updated to avoid error
                    iconSize: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to send message to Dialogflow
  sendMessage(String text) async {
    if (text.isEmpty) {
      print("Message is Empty");
    } else {
      setState(() {
        addMessage(
          Message(text: DialogText(text: [text])),
          true,
        );
      });

      // Send the message to DialogFlow and get the response
      DetectIntentResponse response = await dialogFlowtter.detectIntent(
        queryInput: QueryInput(
          text: TextInput(text: text),
        ),
      );

      // If response exists, display the message from DialogFlow
      if (response.message != null) {
        setState(() {
          addMessage(response.message!);
        });
      }
    }
  }

  // Add messages to the chat
  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({"message": message, "isUserMessage": isUserMessage});
  }
}
