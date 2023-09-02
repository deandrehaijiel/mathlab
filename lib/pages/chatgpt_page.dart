// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animations/animations.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChatGPTPage extends StatefulWidget {
  const ChatGPTPage({super.key});

  @override
  State<ChatGPTPage> createState() => _ChatGPTPageState();
}

class _ChatGPTPageState extends State<ChatGPTPage> {
  String _apiKey = '';
  final TextEditingController _textController = TextEditingController();
  List<String> _responses = [];
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadApiKey();
    _loadConversationHistory();
  }

  void enterApiKey() {
    showModal(
      context: context,
      builder: (BuildContext context) {
        if (_apiKey.isNotEmpty) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Row(
              children: const [
                Icon(Icons.warning_amber_rounded),
                SizedBox(width: 12),
                Text('Remove API key'),
              ],
            ),
            content: const Text(
              'All conversation history will be deleted.',
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  MaterialButton(
                    child: const Text('Remove'),
                    onPressed: () {
                      _apiKey = '';
                      _responses = [];
                      _saveApiKey();
                      _saveConversationHistory();
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          );
        } else {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Text('Enter ChatGPT API key'),
            content: TextField(
              obscureText: true,
              onChanged: (value) {
                _apiKey = value;
              },
              decoration: const InputDecoration(
                hintText: 'API key',
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      _saveApiKey();
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ],
          );
        }
      },
    );
  }

  void _saveApiKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('chatGPTApiKey', _apiKey);
  }

  void _loadApiKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _apiKey = prefs.getString('chatGPTApiKey') ?? '';
    });
  }

  void _saveConversationHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('conversationHistory', _responses);
  }

  void _loadConversationHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _responses = prefs.getStringList('conversationHistory') ?? [];
    });
  }

  Future<void> _sendMessage(String message) async {
    setState(() {
      _responses.add(message);
    });

    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {
            'role': 'user',
            'content': message,
          }
        ],
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final responseText = jsonResponse['choices'][0]['message']['content'];
      setState(() {
        _responses.add(responseText);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10),
            ),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'Request failed with status: ${response.statusCode}.',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const Icon(Icons.warning_rounded, color: Colors.white)
            ],
          ),
        ),
      );
    }

    _saveConversationHistory();
  }

  void _deleteMessage(int index) {
    setState(() {
      _responses.removeAt(index);
    });

    _saveConversationHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Hero(
          tag: 'ChatGPT',
          child: DefaultTextStyle(
            style: TextStyle(
              fontFamily: 'Berlin',
              fontSize: 40,
              fontWeight: FontWeight.bold,
              letterSpacing: 4,
              color: Colors.white,
            ),
            child: Text(
              'ChatGPT',
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => enterApiKey(),
            icon: _apiKey.isEmpty
                ? const Icon(Icons.account_circle_rounded)
                : const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
          bottom: 20,
        ),
        child: Column(
          children: [
            Expanded(
              child: FadingEdgeScrollView.fromSingleChildScrollView(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  reverse: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: _responses.asMap().entries.map(
                        (entry) {
                          final index = entry.key;
                          final responseText = entry.value;
                          return ClipRect(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Slidable(
                                key: ValueKey(responseText),
                                endActionPane: ActionPane(
                                  extentRatio: 0.1,
                                  motion: const StretchMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        _deleteMessage(index);
                                      },
                                      label: 'Delete',
                                      backgroundColor: Colors.red,
                                      borderRadius: BorderRadius.circular(12),
                                      padding: const EdgeInsets.all(0),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onLongPress: () {
                                          final data =
                                              ClipboardData(text: responseText);
                                          Clipboard.setData(data);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              backgroundColor: Colors.grey[400],
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                  top: Radius.circular(30),
                                                ),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 24,
                                                      vertical: 30),
                                              content: const Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 18),
                                                  child: Text(
                                                    'Copied to Clipboard',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        child: AnimatedTextKit(
                                          animatedTexts: [
                                            TypewriterAnimatedText(
                                              responseText,
                                              textStyle: const TextStyle(
                                                  color: Colors.black),
                                              speed: const Duration(
                                                  milliseconds: 21),
                                            ),
                                          ],
                                          isRepeatingAnimation: false,
                                          displayFullTextOnTap: true,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _textController,
                    onSubmitted: (value) {
                      if (_apiKey.isNotEmpty) {
                        _sendMessage(_textController.text);
                        _textController.clear();
                      } else {
                        _sendMessage(_textController.text);
                        _textController.clear();
                      }
                    },
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Ask ChatGPT',
                      hintText: '...',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                    ),
                    enabled: _apiKey.isNotEmpty,
                  ),
                ),
                const SizedBox(width: 10),
                _apiKey.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _sendMessage(_textController.text);
                          _textController.clear();
                        },
                        icon: const Icon(Icons.send, color: Colors.black),
                      )
                    : IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.send, color: Colors.grey),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
