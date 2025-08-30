import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamic_qa/Home/chat_controller.dart';
import 'package:islamic_qa/Login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final ChatController controller = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      // Custom AppBar
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green[900]!, Colors.green[600]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: AppBar(
            leading: Container(),
            elevation: 0,
            backgroundColor: Colors.transparent,
            titleSpacing: 0,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.white,
                  child: Image.asset("assets/logo.png"),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Islamic Scholar",
                      style: GoogleFonts.robotoSlab(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Online",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove("auth_token");
                  Get.back();
                  Get.offAll(() => LoginScreen());
                },
                icon: Icon(Icons.logout, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // Chat Messages
          GetBuilder<ChatController>(
            builder:
                (controller) => Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: controller.messages.length,
                    itemBuilder: (context, index) {
                      bool isUser = controller.messages[index]["isUser"];
                      return Align(
                        alignment:
                            isUser
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 6),
                          padding: EdgeInsets.all(14),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width,
                          ),
                          decoration: BoxDecoration(
                            gradient:
                                isUser
                                    ? LinearGradient(
                                      colors: [
                                        Colors.green[700]!,
                                        Colors.green[500]!,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    )
                                    : LinearGradient(
                                      colors: [
                                        Color(0xFFF5F7FA), // Light gray/white
                                        Color(0xFFE4EBF7), // Subtle bluish tint
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                              bottomLeft: Radius.circular(isUser ? 16 : 0),
                              bottomRight: Radius.circular(isUser ? 0 : 16),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child:
                              controller.messages[index]["isTyping"] == true
                                  ? TypingBubble()
                                  : Text(
                                    controller.messages[index]["text"],
                                    style: TextStyle(
                                      color:
                                          isUser
                                              ? Colors.white
                                              : Colors.black87,
                                      fontSize:
                                          controller.messages[index]["isTyping"] ==
                                                  true
                                              ? 14
                                              : 16,

                                      height: 1.4,
                                    ),
                                  ),
                        ),
                      );
                    },
                  ),
                ),
          ),
          // Input Box
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Obx(
                  () => GestureDetector(
                    onLongPress: () {
                      controller.startListening();
                    },
                    onLongPressUp: () {
                      controller.stopListening();
                    },
                    child: CircleAvatar(
                      radius: 26,
                      backgroundColor:
                          controller.isListening.value
                              ? Colors.red
                              : Colors.green,
                      child: Icon(
                        controller.isListening.value
                            ? Icons.mic
                            : Icons.mic_none,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: controller.messageController,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: "Type your question...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.green[800],
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: controller.askFatwa,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TypingBubble extends StatelessWidget {
  const TypingBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (index) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 400),
            margin: EdgeInsets.symmetric(horizontal: 2),
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              shape: BoxShape.circle,
            ),
            // Animate dots one by one
            child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: Duration(milliseconds: 1200),
              curve: Curves.easeInOut,
              builder: (context, value, child) {
                return Opacity(
                  opacity: (value - index * 0.3).clamp(0.0, 1.0),
                  child: child,
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  shape: BoxShape.circle,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
