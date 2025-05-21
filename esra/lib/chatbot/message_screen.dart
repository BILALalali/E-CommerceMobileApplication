// import 'package:flutter/material.dart';

// class MessageScreen extends StatefulWidget {
//   final List messages;
//   const MessageScreen({super.key, required this.messages});

//   @override
//   State<MessageScreen> createState() => _MessageScreenState();
// }

// class _MessageScreenState extends State<MessageScreen> {
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     return ListView.separated(
//         separatorBuilder: (context, Index) =>
//             const Padding(padding: EdgeInsets.only(top: 10)),
//         itemCount: widget.messages.length,
//         itemBuilder: (context, Index) {
//           return Container(
//             margin: const EdgeInsets.all(10),
//             child: Row(
//               mainAxisAlignment: widget.messages[Index]["isUserMessage"]
//                   ? MainAxisAlignment.end
//                   : MainAxisAlignment.start,
//               children: [
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(21),
//                         topLeft: Radius.circular(21),
//                         bottomRight: Radius.circular(
//                             widget.messages[Index]["isUserMessage"] ? 0 : 21),
//                         topRight: Radius.circular(
//                             widget.messages[Index]["isUserMessage"] ? 21 : 0)),
//                     color: widget.messages[Index]["isUserMessage"]
//                         ? Colors.deepPurple
//                         : Colors.green.shade300,
//                   ),
//                   constraints: BoxConstraints(maxWidth: width * 2 / 3),
//                   child: Text(
//                     widget.messages[Index]["message"].text.text[0],
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                 )
//               ],
//             ),
//           );
//         });
//   }
// }

import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  final List messages;
  const MessageScreen({super.key, required this.messages});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ListView.separated(
      separatorBuilder: (context, Index) =>
          const Padding(padding: EdgeInsets.only(top: 10)),
      itemCount: widget.messages.length,
      itemBuilder: (context, Index) {
        bool isUserMessage = widget.messages[Index]["isUserMessage"];

        return Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment:
                isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              // Container for message bubble
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(21),
                    topLeft: Radius.circular(21),
                    bottomRight: Radius.circular(isUserMessage ? 0 : 21),
                    topRight: Radius.circular(isUserMessage ? 21 : 0),
                  ),
                  color: isUserMessage
                      ? Colors.deepPurple[400] // Dark purple for user messages
                      : Colors.green.shade400, // Light green for bot messages
                ),
                constraints: BoxConstraints(maxWidth: width * 2 / 3),
                child: Text(
                  widget.messages[Index]["message"].text.text[0],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16, // Increased font size for better readability
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
