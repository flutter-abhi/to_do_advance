// ignore: file_names
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'data.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

bool isSearchCard = false;
bool isEdit = false;

class Todo_list_home extends StatefulWidget {
  const Todo_list_home({super.key});

  @override
  State<Todo_list_home> createState() => _Todo_list_homeState();
}

GlobalKey<FormState> formkey = GlobalKey<FormState>();
//controller define here
TextEditingController title = TextEditingController();
TextEditingController discription = TextEditingController();
TextEditingController date = TextEditingController();
TextEditingController search = TextEditingController();

class _Todo_list_homeState extends State<Todo_list_home> {
  @override
  void initState() {
    super.initState();
    callAllFun();
    setState(() {});
  }

  void callAllFun() async {
    await createDataBase();
    userList = await getToDoData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(111, 81, 255, 1),
      body: Column(
        children: [
          //top text
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(top: 8, left: 29),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (isSearchCard)
                      ? SizedBox(
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 15),
                            child: TextField(
                              autofocus: true,
                              controller: search,
                              onChanged: (value) {
                                setState(() {
                                  // searchFun(value);
                                });
                              },
                              onSubmitted: (value) {
                                setState(() {
                                  isSearchCard = false;
                                });
                              },
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.search),
                                hintText: "Search",
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 7,
                                    color: Colors.red,
                                    // color: Color.fromRGBO(0, 139, 148, 1),
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(
                          height: 45,
                        ),
                  Row(
                    children: [
                      const Text(
                        "Good morning",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              isSearchCard = true;
                            });
                          },
                          icon: const Icon(Icons.search))
                    ],
                  ),
                  const Text(
                    // "${userDataList[userIndex].userName}",
                    " Abhishek",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(
                          217,
                          217,
                          217,
                          1,
                        ),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40))),
                  ),
                ],
              ),
            ),
          ),

// gray container
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.only(
                top: 20,
              ),
              // height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: Color.fromRGBO(217, 217, 217, 1),
              ),
              child: Column(children: [
                const Text(
                  "CREATE TO DO LIST",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
// white container
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.only(top: 12, left: 13, right: 11),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: ListView.builder(
                      itemCount: userList.length,
//card
//slider
                      itemBuilder: (context, index) => Slidable(
                        closeOnScroll: true,
                        endActionPane: ActionPane(
                            extentRatio: 0.2,
                            motion: const DrawerMotion(),
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isEdit = true;
                                          edit(userList[index]);
                                        });
                                      },
                                      child: Container(
                                        height: 32,
                                        width: 32,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color.fromRGBO(89, 57, 241, 1),
                                        ),
                                        child: const Icon(
                                          Icons.edit_outlined,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          deleteData(userList[index]);
                                          callAllFun();
                                        });
                                      },
                                      child: Container(
                                        height: 32,
                                        width: 32,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color.fromRGBO(89, 57, 241, 1),
                                        ),
                                        child: const Icon(
                                          Icons.delete_outline,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ]),
///////////////////////////
                        ///  //card start
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.08),
                                  offset: Offset(0, 4),
                                  blurRadius: 20,
                                )
                              ]),
                          padding: const EdgeInsets.only(
                              left: 5, top: 20, bottom: 13),
                          child: Row(children: [
                            Container(
                              height: 52,
                              width: 52,
                              decoration: const BoxDecoration(
                                  color: Color.fromRGBO(217, 217, 217, 1),
                                  shape: BoxShape.circle),
                              child: Image.network(
                                "https://pixsector.com/cache/517d8be6/av5c8336583e291842624.png",
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ///titile
                                  Text(
                                    userList[index].title,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
//disceiption
                                  Text(
                                    userList[index].discription,
                                    style: const TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(0, 0, 0, 0.7)),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    userList[index].date,
                                    style: const TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(0, 0, 0, 0.7)),
                                  ),
                                ],
                              ),
                            ),
//complete Button ////////////////////////////////////////////////////////////////////////////////
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (userList[index].complete == 0) {
                                    // userList[index].complete = 1;
                                    updateToDo(UserData(
                                        id: userList[index].id,
                                        title: userList[index].title,
                                        discription:
                                            userList[index].discription,
                                        date: userList[index].date,
                                        complete: 1));
                                  } else {
                                    updateToDo(UserData(
                                        id: userList[index].id,
                                        title: userList[index].title,
                                        discription:
                                            userList[index].discription,
                                        date: userList[index].date,
                                        complete: 0));
                                  }
                                });
                                callAllFun();
                              },
                              icon: (userList[index].complete == 1)
                                  ? const Icon(
                                      Icons.check_circle_outline,
                                      color: Color.fromRGBO(4, 189, 0, 1),
                                    )
                                  : const Icon(
                                      Icons.circle_outlined,
                                    ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(89, 57, 241, 1),
        onPressed: () {
          modelBottomsheet(false);
        },
        child: const Icon(
          Icons.add,
          size: 46,
        ),
      ),
    );
  }

// edit aasel tr default value set keli
  void edit(UserData modelobj) {
    title.text = modelobj.title;
    discription.text = modelobj.discription;
    date.text = modelobj.date;
    modelBottomsheet(true, modelobj);
  }

// main bottom sheet
//

  void modelBottomsheet(bool isEdit, [UserData? modelobj]) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
          side: BorderSide(
            color: Color.fromRGBO(89, 57, 241, 1),
            width: 2.0,
          ),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: 450,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: const Color.fromRGBO(89, 57, 241, 1),
                ),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Center(
                child: Form(
                  key: formkey,
                  child: Center(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, bottom: 5),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 112,
                              ),
                              child: (isEdit)
                                  ? const Text(
                                      "Edit Task",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600),
                                    )
                                  : const Text(
                                      "Create Task",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600),
                                    ),
                            ),
                            //
                            const SizedBox(
                              height: 20,
                              child: Text(
                                "Title",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(89, 57, 241, 1)),
                              ),
                            ),
///////////////////////////////////
/////Title text fild
                            TextFormField(
                              autofocus: true,
                              controller: title,
                              validator: (value) {
                                if (value == "" || value!.trim().isEmpty) {
                                  return "Please enter The Title";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(89, 57, 241, 1),
                                  ),
                                ),
                                hintText: "Enter The Titile",
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 10,
                                    color: Colors.red,
                                    // color: Color.fromRGBO(0, 139, 148, 1),
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Description",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(89, 57, 241, 1),
                              ),
                            ),
////////////////////discriptin textformfild
                            TextFormField(
                              controller: discription,
                              maxLines: 3,
                              minLines: 1,
                              validator: (value) {
                                if (value == "" || value!.trim().isEmpty) {
                                  return "Plese Enter the Discription";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(89, 57, 241, 1),
                                  ),
                                ),
                                hintText: "Enter The Description",
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(89, 57, 241, 1),
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Date",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(89, 57, 241, 1),
                              ),
                            ),
////////////////////// // date
                            TextFormField(
                              validator: (value) {
                                if (value == "" || value!.trim().isEmpty) {
                                  return "Plese Select Date";
                                }
                                return null;
                              },
                              onTap: () async {
                                DateTime? datepicke = await (showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2023),
                                    lastDate: DateTime(2025)));

                                // ignore: non_constant_identifier_names
                                String FormateDate =
                                    DateFormat.yMMMd().format(datepicke!);
                                date.text = FormateDate;
                                setState(() {});
                              },
                              controller: date,
                              readOnly: true,
                              decoration: InputDecoration(
                                suffixIcon: const Icon(Icons.calendar_month),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(89, 57, 241, 1),
                                  ),
                                ),
                                hintText: "Enter Date",
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(89, 57, 241, 1),
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),

                            //////////////
                            /// ////////////// /// submit button
                            Padding(
                              padding: const EdgeInsets.only(left: 30, top: 20),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromRGBO(89, 57, 241, 1),
                                ),
                                onPressed: () {
                                  setState(() {
                                    (isEdit)
                                        ? submmit(isEdit, modelobj)
                                        : submmit(isEdit);
                                  });
                                },
                                child: const SizedBox(
                                  height: 50,
                                  width: 250,
                                  child: Center(
                                    child: Text(
                                      "Submit",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  void submmit(bool isEdit, [UserData? modelobj]) {
    //valid or not
    // which error for this
    bool validationResult = formkey.currentState!.validate();

    if (validationResult) {
//valid aasel tr chek kel ki edit karaychi
// ka create
//edit karaych aasel tr value insert karaychi
      if (isEdit) {
        // modelobj!.date = date.text.trim();
        // modelobj.title = title.text.trim();
        // modelobj.discription = discription.text.trim();
        updateToDo(UserData(
            id: modelobj!.id,
            title: title.text.trim(),
            discription: discription.text.trim(),
            date: date.text.trim(),
            complete: modelobj.complete));
        callAllFun();

        Navigator.pop(context);
      } else {
//New data Add kela tr

        insertData(UserData(
            title: title.text,
            discription: discription.text,
            date: date.text,
            complete: 0));
        callAllFun();
        Navigator.pop(context);
      }
      clearController();
      setState(() {});
    }
  }

// after summited controller value is clear
// and value of error is set false
  void clearController() {
    title.clear();
    date.clear();
    discription.clear();
  }

  // List searchFun(String searchTitle) {
  //   if (search.text.trim() == "") {
  //     userList = databaseList;
  //   } else {
  //     userList = [];

  //     for (int i = 0; i < databaseList.length; i++) {
  //       if (databaseList[i]
  //           .title
  //           .toLowerCase()
  //           .contains(searchTitle.toLowerCase())) {
  //         userList.add(databaseList[i]);
  //       }
  //     }
  //   }
  //   return userList;
  // }
}
