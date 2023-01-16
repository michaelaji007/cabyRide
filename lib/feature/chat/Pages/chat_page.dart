import 'package:flutter/material.dart';

import '../model/chatModel.dart';

ValueNotifier<List<Chat>> chatsNotifier = ValueNotifier<List<Chat>>(
  [],
);

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  // ChatState chatState;
  // LoginState loginState;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ChatsProvider().getChats(widget.data.token!);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      // appBar: kAppBar("Chat", showLead: false),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: _width * .05),
          child: Column(
            children: [
              _buildSearchTextField(),
              SizedBox(
                height: 3,
              ),
              Divider(),
              SizedBox(
                height: 2,
              ),
              Expanded(
                child: ValueListenableBuilder(
                  builder:
                      (BuildContext context, List<Chat>? value, Widget? child) {
                    print(value);
                    if (value!.isEmpty) {
                      return Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [Text("Begin Chat")],
                        ),
                      );
                    }
                    return ListView.separated(
                      itemCount: value.length,
                      separatorBuilder: (context, index) => Divider(
                        thickness: 1,
                      ),
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => AgoraMessage(
                            //         chatId: value[index].chatId,
                            //         receiverFcmToken:
                            //             value[index].receiverFcmToken,
                            //         channelName: value[index].channelName,
                            //         userName: value[index].riderName,
                            //         token: value[index].token,
                            //         userId: value[index].riderId,
                            //         myId: ""),
                            //   ),
                            // );
                          },
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue.withOpacity(0.2),
                            radius: 20,
                            child: Text(
                              value[index].riderName![0].toUpperCase(),
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          title: Text(
                            value[index].riderName!,
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20),
                          ),
                          subtitle: Text("Tap to chat"),
                        );
                      },
                    );
                  },
                  valueListenable: chatsNotifier,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchTextField() {
    return Container(
      width: MediaQuery.of(context).size.width * .9,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        onSubmitted: (value) {
          // chatState.filterChats(value);
        },
        cursorColor: Color(0XF757575),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          fillColor: Colors.white,
          labelText: "Search",
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).primaryColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide:
                BorderSide(width: 1.5, color: Theme.of(context).primaryColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 1.5),
          ),
        ),
      ),
    );
  }
}
