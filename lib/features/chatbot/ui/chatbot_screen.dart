
import 'dart:convert';

import 'package:flutter/material.dart';
import 'api_converter.dart';
//import 'package:bubble/bubble.dart';
import 'package:dio/dio.dart';
class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  //!
  final GlobalKey<AnimatedListState> _listkey = GlobalKey();
  List<String> _data = ['welcome to Rita chat-bot,we are happy to help you0'];
  TextEditingController queryController = TextEditingController();
  Dio dio = Dio();
  Future<void> sendMessage(String message) async {
    try {
      Response response = await dio.post(
        'http://10.0.2.2:5005/webhooks/rest/webhook',
        data: jsonEncode({'message': message}),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic>? data = response.data;
        if (data != null) {
          final List<chatbot> chat =
              data.map((json) => chatbot.fromJson(json)).toList();
          for(int x=0;x<chat.length;x++)
          {
            _data.add(chat[x].text.toString()+'0');
            _listkey.currentState!.insertItem(_data.length - 1);
          }
          
        }
      } else {
        print('Failed with response: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending message: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text(
          "Chatbot",
          style: TextStyle(
            color: Color.fromARGB(255, 158, 208, 233),
            fontSize: 24,
          ),
        ),
        backgroundColor:Color.fromARGB(255, 188, 111, 111),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            height:(MediaQuery.of(context).size.height)*.77,
            child: AnimatedList(
              key: _listkey,
              
              initialItemCount: _data.length,
              itemBuilder:
                  (BuildContext context, int index, Animation animation) {
                return buildItem(_data[index], animation, index);
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: TextField(
                            keyboardType: TextInputType.text,
                            //maxLines: 2,
                            //minLines: 1,
                          controller: queryController, 
                          decoration: InputDecoration(
                              //focusColor: Colors.amber,
                              //hoverColor: Colors.amber,
                              filled: true,
                              fillColor: Colors.deepOrange,
                              border: const OutlineInputBorder(    
                                  borderRadius: BorderRadius.all(Radius.circular(60))
                              ),
                              focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(60)),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 107, 46, 27),
                                  )
                              ),   
                              hintText:'chat' ,
                              hintStyle:const TextStyle(color: Colors.white),
                              suffixIcon: IconButton(
                                  color: const Color.fromARGB(255, 107, 46, 27),
                                  onPressed:  () {
                                    this.getResponse();
                                    sendMessage(queryController.text);
                                    queryController.clear();
                                  },
                                  icon:const Icon(Icons.send)
                              )
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
  bool mine = item.endsWith("0");
  return SizeTransition(
    sizeFactor: animation as Animation<double>,
    child: Align(
      alignment: mine ? Alignment.topLeft : Alignment.topRight,
      child: Container(
        margin: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
        width: 225,
        alignment: mine ? Alignment.topLeft : Alignment.topRight,
        child: Material(
          color: mine ? Color.fromARGB(255, 167, 88, 88) : const Color.fromARGB(255, 237, 159, 159),
          borderRadius:mine?const BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                ):const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              item.replaceAll('0', ''),
              style: TextStyle(
                fontSize: 17,
                color: mine ? Colors.white : Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}