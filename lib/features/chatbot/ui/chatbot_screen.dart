import 'package:flutter/material.dart';
import 'package:medical_app/core/theming/colors.dart';
import 'package:bubble/bubble.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  //!
  final GlobalKey<AnimatedListState> _listkey = GlobalKey();
  List<String> _data = [];

  TextEditingController queryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkTheme ? Colors.grey.shade800 : Colors.grey[300],
      appBar: AppBar(
        title: const Text(
          "Chatbot",
          style: TextStyle(
            color: ColorsProvider.lightGray,
            fontSize: 24,
          ),
        ),
        backgroundColor: ColorsProvider.primaryBink,
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          AnimatedList(
            key: _listkey,
            initialItemCount: _data.length,
            itemBuilder:
                (BuildContext context, int index, Animation animation) {
              return buildItem(_data[index], animation, index);
            },
          ),
          //* TextField
          Align(
            alignment: Alignment.bottomCenter,
            child: ColorFiltered(
              colorFilter: ColorFilter.linearToSrgbGamma(),
              child: Container(
                color: isDarkTheme ? Colors.grey.shade500 : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.message,
                          color: ColorsProvider.primaryBink,
                        ),
                        hintText: "Ask me",
                        fillColor: Colors.white12,
                      ),
                      controller: queryController,
                      textInputAction: TextInputAction.send,
                      style: const TextStyle(color: Colors.black),
                      onSubmitted: (msg) {
                        this.getResponse();
                        queryController.clear();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getResponse() {
    if (queryController.text.length > 0) {
      this.insertSingleItem(queryController.text);
    }
  }

  void insertSingleItem(String message) {
    _data.add(message);
    _listkey.currentState!.insertItem(_data.length - 1);
  }
}

Widget buildItem(String item, Animation animation, int index) {
  bool mine = item.endsWith("<bot>");
  return SizeTransition(
    sizeFactor: animation as Animation<double>,
    child: Padding(
      padding: const EdgeInsets.only(top: 16, right: 10),
      child: Container(
        alignment: mine ? Alignment.topLeft : Alignment.topRight,
        child: Bubble(
          child: Text(
            item.replaceAll("<bot", ""),
            style: TextStyle(
              color: mine ? Colors.white : Colors.black,
            ),
          ),
          color: mine ? Colors.blue : Colors.grey[200],
          padding: BubbleEdges.all(10),
        ),
      ),
    ),
  );
}
