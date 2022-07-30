import 'package:arz_app/Models/Currency.dart';
import 'package:arz_app/constant.dart';
import 'package:arz_app/controllers/theme_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert' as convert;
import 'dart:developer' as developer;
import 'package:get/get.dart';

//? Import ------------------------------

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Currency> currency = [];
  var isDark = Get.find<ThemeController>().isDark.value;

  //? GetResponse -----------------------
  Future getResponse(BuildContext cxt) async {
    var url =
        'https://sasansafari.com/flutter/api.php?access_key=flutter123456';
    var value = await http.get(Uri.parse(url));
    //print(value.statusCode);
    //developer.log(value.body,name: "main", error: 'not found');
    if (currency.isEmpty) {
      if (value.statusCode == 200) {
        _showUpdateMessageSnackBar(context, "اطلاعات با موفقیت بروزرسانی شد");
        List jsonList = convert.jsonDecode(value.body);
        if (jsonList.length > 0) {
          for (int i = 0; i < jsonList.length; i++) {
            setState(() {
              currency.add(Currency(
                  id: jsonList[i]["id"],
                  title: jsonList[i]["title"],
                  price: jsonList[i]["price"],
                  changes: jsonList[i]["changes"],
                  status: jsonList[i]["status"]));
            });
          }
        }
      }
      // else{
      //   _showUpdateMessageSnackBar(context, "خطا در دریافت اطلاعات!");
      // }
    }
    return value;
  }

  @override
  void initState() {
    super.initState();
    //? GetResponse -----------------------
    getResponse(context);
  }

  @override
  Widget build(BuildContext context) {
    //getResponse(context);
    //? Scaffold --------------------------
    return Scaffold(
      backgroundColor:  Get.find<ThemeController>().isDark.value ? kDarkGreyColor : kBackGroundColor,

      //? Drawer ------------------------
      drawer: ArzDrawer(),

      //? AppBar ------------------------
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kClaretColor,
        title: const Text(
          'اپلیکیشن قیمت',
          style: TextStyle(
            fontFamily: 'Samim',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: kWhiteColor,
          ),
          //Theme.of(context).textTheme.headline1,
        ),
      ),

      //? Body --------------------------
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:[
                  const Icon(
                    Icons.question_mark,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'نرخ ارز آزاد چیست؟',
                    style: TextStyle(
                      fontFamily: 'Samim',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isDark ? kWhiteColor : kBlackColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                discText,
                style: TextStyle(
                  fontFamily: 'Samim',
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  color: isDark ? kWhiteColor : kBlackColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 24.0,
                ),
                child: Container(
                  width: double.infinity,
                  height: 35,
                  decoration: const BoxDecoration(
                      color: kHeadRowColor,
                      borderRadius: BorderRadius.all(Radius.circular(1000))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'نام آزاد ارز',
                            style: TextStyle(
                              fontFamily: 'Samim',
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: kBackGroundColor,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'قیمت',
                            style: TextStyle(
                              fontFamily: 'Samim',
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: kBackGroundColor,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'تغییر',
                            style: TextStyle(
                              fontFamily: 'Samim',
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: kBackGroundColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                  width: double.infinity,
                  // height: 350.0,
                  height: MediaQuery.of(context).size.height / 2,
                  child: listFutureBuilder(context)),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 16,
                  decoration: BoxDecoration(
                      color: kGreyColor,
                      borderRadius: BorderRadius.circular(1000)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 16,
                        child: TextButton.icon(
                          onPressed: () {
                            currency.clear();
                            listFutureBuilder(context);
                          },
                          icon: const Icon(
                            CupertinoIcons.refresh_bold,
                            color: kClaretColor,
                          ),
                          label: const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              'بروزرسانی',
                              style: TextStyle(
                                fontFamily: 'Samim',
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: kBlackColor,
                              ),
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(kBlueButtonColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(1000),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'آخرین بروزرسانی ${_getTime()}',
                      ),
                      const SizedBox(
                        width: 8.0,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<dynamic> listFutureBuilder(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: currency.length,
                itemBuilder: (BuildContext context, int position) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ArzItem(position, currency),
                  );
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
      future: getResponse(context),
    );
  }
}

//! Functions ----------------------------
String getFarsiNumber(String number) {
  const en = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const fa = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

  en.forEach((element) {
    number = number.replaceAll(element, fa[en.indexOf(element)]);
  });
  return number;
}

String _getTime() {
  DateTime now = DateTime.now();

  return DateFormat('kk:mm:ss').format(now);
}

void _showUpdateMessageSnackBar(BuildContext context, String message) {
  Get.back();
  Get.snackbar('پیغام', message,
      icon: const Icon(
        Icons.task_alt,
        color: kWhiteColor,
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: kClaretColor,
      colorText: kWhiteColor,
      animationDuration: const Duration(seconds: 1),
      duration: const Duration(seconds: 3));
  //? Old -----------------------------------
  // ScaffoldMessenger.of(context).showSnackBar(
  //   SnackBar(
  //       content: Text(
  //         message,
  //         style: Theme.of(context).textTheme.headline1,
  //       ),
  //       backgroundColor: kClaretColor),
  // );
}

//! Widgets ------------------------------
class ArzItem extends StatelessWidget {
  ArzItem(
    this.position,
    this.currency, {
    Key? key,
  }) : super(key: key);
  int position;
  List<Currency> currency;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        boxShadow: const <BoxShadow>[
          BoxShadow(blurRadius: 1.0, color: kBlackColor),
        ],
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(1000),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //? Title ------------------------------------

          Expanded(
            child: Align(
              child: Text(
                currency[position].title!,
                style: const TextStyle(
                  fontFamily: 'Samim',
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: kBlackColor,
                ),
              ),
              alignment: Alignment.center,
            ),
          ),

          //? Price ------------------------------------

          Expanded(
            child: Align(
              child: Text(
                getFarsiNumber(currency[position].price.toString()),
                style: const TextStyle(
                  fontFamily: 'Samim',
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: kBlackColor,
                ),
              ),
              alignment: Alignment.center,
            ),
          ),

          //? Changes ----------------------------------
          Expanded(
            child: Align(
              child: Text(getFarsiNumber(currency[position].changes.toString()),
                  style: TextStyle(
                    fontFamily: 'Samim',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: currency[position].status == "n"
                        ? kRedColor
                        : kGreenColor,
                  )),
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }
}

class ArzDrawer extends StatelessWidget {
  ArzDrawer({
    Key? key,
  }) : super(key: key);
  var isDark = Get.find<ThemeController>().isDark.value;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: Text(
                'ورود',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              leading: Icon(
                CupertinoIcons.person,
                color: isDark ? kWhiteColor : kClaretColor,
              ),
              onTap: () {},
            ),
            const Divider(
              height: 2,
            ),
            ListTile(
              title: Text(
                'ماشین حساب',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              leading: Icon(
                Icons.calculate,
                color: isDark ? kWhiteColor : kClaretColor,
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'پرسش و پاسخ',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              leading: Icon(
                Icons.question_answer,
                color: isDark ? kWhiteColor : kClaretColor,
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'نسخه جدید',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              leading: Icon(
                Icons.upgrade_sharp,
                color: isDark ? kWhiteColor : kClaretColor,
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'درباره',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              leading: Icon(
                CupertinoIcons.question_circle,
                color: isDark ? kWhiteColor : kClaretColor,
              ),
              onTap: () {},
            ),
            const Divider(
              height: 2,
            ),
            ListTile(
              title: Text(
                'زمینه تیره',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              leading: Icon(
                Icons.dark_mode,
                color: isDark ? kWhiteColor : kClaretColor,
              ),
              trailing: Obx(() => Switch(
                    activeColor: isDark ? kWhiteColor : kClaretColor,
                    onChanged: (value) {
                      Get.find<ThemeController>().toggle();
                      Get.find<ThemeController>().changeTheme();
                    },
                    value: Get.find<ThemeController>().isDark.value,
                  )),
            ),
            ListTile(
              title: Text(
                'English Language',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              leading: Icon(
                Icons.language,
                color: isDark ? kWhiteColor : kClaretColor,
              ),
              trailing: Switch(
                activeColor: isDark ? kWhiteColor : kClaretColor,
                onChanged: (value) {},
                value: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
