import 'package:flutter/material.dart';
import 'package:flutter_assignment/model/api_services.dart';
import 'package:flutter_assignment/model/user_model.dart';
import 'package:flutter_assignment/model/user_req.dart';

class AddCard extends StatefulWidget {
  const AddCard({Key? key}) : super(key: key);

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  TextEditingController commentController = TextEditingController();
  List<UserRecord> userList = [];
  bool isLoading = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    userList = await ApiService.getUserData();
    userList = userList.reversed.toList();
    setState(() {});
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 220,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade50,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 70.0,right: 70,top: 100),
                        child: Image.asset('assets/credit.png'),
                      )
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      height: 95,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40)),
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          'Add Comments',
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: 335,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    elevation: 2,
                    child: TextField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          prefixIcon: const Icon(
                            Icons.search,
                            size: 28,
                          ),
                          hintText: 'Search',
                          filled: true,
                          fillColor: Colors.indigo.shade50,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(40))),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 370,
                  child: ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, bottom: 6),
                            child: Container(
                              height: 55,
                              width: 330,
                              decoration: BoxDecoration(
                                  color: Colors.indigo.shade50,
                                  borderRadius: BorderRadius.circular(15),
                                  border:
                                      Border.all(width: 2, color: Colors.grey)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                userList[index].url),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              width: 2,
                                              color: Colors.green.shade700)),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: Text(
                                    userList[index].title,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 16),
                                  )),
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return StatefulBuilder(
                                                builder: (BuildContext context,
                                                    void Function(
                                                            void Function())
                                                        setState) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                      'Type below',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    content: isLoading
                                                        ? const SizedBox(
                                                            width: double
                                                                .maxFinite,
                                                            height: 100,
                                                            child: Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            ))
                                                        : Form(
                                                            key: _formKey,
                                                            child:
                                                                Material(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                  elevation: 5,
                                                                  shadowColor: Colors.black,
                                                                  child: TextFormField(
                                                              validator:
                                                                    (value) {
                                                                  if (value ==
                                                                          null ||
                                                                      value
                                                                          .isEmpty) {
                                                                    return 'Please enter comment';
                                                                  }
                                                                  return null;
                                                              },
                                                              controller:
                                                                    commentController,
                                                              maxLines: 2,
                                                              decoration:
                                                                    InputDecoration(
                                                                  contentPadding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              10,
                                                                          top: 4,
                                                                          bottom:
                                                                              4),
                                                                  fillColor: Colors
                                                                      .indigo
                                                                      .shade100,
                                                                  filled: true,
                                                                  hintText:
                                                                      'Comments',

                                                                  border: OutlineInputBorder(

                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                                  10),
                                                                      borderSide:
                                                                          BorderSide
                                                                              .none),
                                                              ),
                                                            ),
                                                                ),
                                                          ),
                                                    actions: [
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                          if (_formKey
                                                              .currentState!
                                                              .validate()) {
                                                            isLoading = true;
                                                            setState(() {});
                                                            String comment =
                                                                commentController
                                                                    .text
                                                                    .toString();
                                                            String thumbUrl =
                                                                'https://t1.gstatic.com/faviconV2?client=SOCIAL&type=FAVICON&fallback_opts=TYPE,SIZE,URL&url=http://yahoo.com&size=64';
                                                            debugPrint(
                                                                'comment $comment');
                                                            commentController
                                                                .clear();
                                                            UserReq userReq =
                                                                UserReq(
                                                                    title:
                                                                        comment,
                                                                    thumbnailUrl:
                                                                        thumbUrl);
                                                            var value =
                                                                await ApiService
                                                                    .postUserData(
                                                                        userReq);
                                                            if (value) {
                                                              UserRecord
                                                                  userRecord =
                                                                  UserRecord(
                                                                      albumId:
                                                                          1,
                                                                      id: 1,
                                                                      title:
                                                                          comment,
                                                                      url:
                                                                          thumbUrl,
                                                                      thumbnailUrl:
                                                                          thumbUrl);
                                                              userList.insert(0,
                                                                  userRecord);
                                                              isLoading = false;
                                                              setState(() {});
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      customSnackBar());
                                                            }
                                                          }
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .indigo),
                                                        child: const Text(
                                                          'Add',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      )
                                                    ],
                                                  );
                                                },
                                              );
                                            });
                                      },
                                      icon: const Icon(Icons.add))
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SnackBar customSnackBar() {
    return SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.indigo.shade100,
      content: const Row(
        children: [
          Expanded(
              child: Text(
            'New comment was added!',
            style: TextStyle(color: Colors.black),
          )),
          Icon(
            Icons.check_circle_outline_outlined,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
