import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:task_app/custom_widgets/custom_appbar.dart';
import 'package:task_app/custom_widgets/customtext.dart';
import 'package:task_app/datamodel/datamodel.dart';
import 'package:task_app/local_db/login_db.dart';
import 'package:task_app/provider/teacher_notifier.dart';
import 'package:task_app/provider/userdetails_notifier.dart';
import 'package:task_app/repeat_fucntion/constant.dart';
import 'package:task_app/repeat_fucntion/flutter_toast.dart';
import 'package:task_app/repeat_fucntion/repeat_function.dart';
import 'package:task_app/screens/admin_panel/classes_page.dart';
import 'package:task_app/screens/admin_panel/students_page.dart';
import 'package:task_app/screens/admin_panel/teachers_page.dart';
import 'package:task_app/screens/school_management_system/school_home_page.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  List<DataModel> standardData = [
    DataModel(icon: "attendance", id: "1", title: "Manage Teacher"),
    DataModel(icon: "attendance", id: "2", title: "Mange Student"),
    DataModel(icon: "request", id: "3", title: "Manage Classes"),
    // DataModel(icon: "myleaves", id: "4", title: ""),
  ];
  Widget svgImage({required String? name, double? height, double? width}) {
    return SvgPicture.asset(
      "assets/$name.svg",
      height: height ?? 200,
      width: width ?? double.infinity,
      fit: BoxFit.cover,
    );
  }

  @override
  void initState() {
    super.initState();
    Provider.of<TeacherNotifier>(context, listen: false).initAll();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    TeacherNotifier teacherNotifier = Provider.of<TeacherNotifier>(context);
    UserdetailsNotifier userdetailsNotifier = Provider.of(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(
        title: "Dashboard",
        action: [
          InkWell(
            onTap: () {
              RepeatFunction().showLogoutDialog(
                ontap: () {
                  userdetailsNotifier
                      .userLogout(userEnum: UserEnum.admin)
                      .whenComplete(() {
                    ToastClass.showToast(
                        msg: "Logout Successfully",
                        bgColor: Colors.green,
                        color: Colors.white);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SchoolHomePage(),
                      ),
                      (route) => false,
                    );
                  });
                },
                context: context,
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 5),
              child: CircleAvatar(
                backgroundColor: primarycolor,
                child: Text(
                  userdetailsNotifier.admindetails.email?[0].toUpperCase() ??
                      "",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          svgImage(
              name: "deshboard", height: size.height / 3, width: size.width),
          const SizedBox(
            height: 35,
          ),
          SizedBox(
            // width: MediaQuery.of(context).size.width * .90,
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: Wrap(

                  // physics: const NeverScrollableScrollPhysics(),
                  // MainAxisAlignment: MainAxisAlignment.center,
                  // childAspectRatio: 2 / 1.6,
                  // // shrinkWrap: true,

                  // // crossAxisAlignment: WrapCrossAlignment.center,
                  // // runSpacing: 20,
                  // // spacing: 30,
                  // mainAxisSpacing: 5,
                  // crossAxisCount: 3,
                  spacing: size.width * .015,
                  children: List.generate(standardData.length, (index) {
                    var data = standardData[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: InkWell(
                        onTap: () {
                          if (data.id == "1") {
                            RepeatFunction.navigatorPush(
                                context: context,
                                pageWidget: const TeachersPage());
                          } else if (data.id == "2") {
                            RepeatFunction.navigatorPush(
                                context: context,
                                pageWidget: const StudentsPage());
                          } else if (data.id == "3") {
                            RepeatFunction.navigatorPush(
                                context: context,
                                pageWidget: const ClassesPage());
                          } else if (data.id == "4") {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => const MyLeavesPage(),
                            //     ));
                          } else if (data.id == "5") {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => DummyReportPage(),
                            //     ));
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => const ReportPage(),
                            //     ));
                          } else if (data.id == "6") {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => UserListPage(),
                            //     ));
                          } else {}
                        },
                        child: SizedBox(
                          height: 120,
                          width: size.width * .28,
                          child: CustomContainer(
                            elevation: 3,
                            color: Colors.white,
                            borderColor: Colors.grey,

                            // height: 60,
                            width: double.maxFinite,
                            widget: Column(
                                // mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  index == 0
                                      ? CustomText(
                                          text: teacherNotifier.teachers.length
                                              .toString())
                                      : index == 1
                                          ? CustomText(
                                              text: teacherNotifier
                                                  .students.length
                                                  .toString())
                                          : index == 2
                                              ? CustomText(
                                                  text: teacherNotifier
                                                      .classes.length
                                                      .toString())
                                              : Container(),

                                  // const SizedBox(
                                  //   height: 30,
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 6.0, right: 6, top: 5),
                                    child: Center(
                                      child: CustomText(
                                        textAlign: TextAlign.center,
                                        text: data.title,
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                ]),
                          ),
                        ),
                      ),
                    );
                  })),
            ),
          ),
        ],
      ),
    );
  }
}
