import 'package:boxi/widgets/appbar_widget.dart';
import 'package:boxi/widgets/bottom_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:boxi/controllers/customer_controller.dart';

class ProfilePage extends StatefulWidget {
  final String label;
  const ProfilePage({required this.label, super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class OptionList {
  String optionTitle;
  String optionSubTitle;
  IconData optionIcon;
  Function onTap;

  OptionList(
      {required this.optionTitle,
      required this.optionSubTitle,
      required this.optionIcon,
      required this.onTap});
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    CustomerController customerController = CustomerController();
    customerController.fetchCustomers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              flex: 1,
              child: AppBarWidget(label: widget.label, key: widget.key)),
          Expanded(
            flex: 7,
            child: _listView(context),
          ),
          const Expanded(
            child: BottomBarWidget(),
          ),
        ],
      ),
    );
  }

  Widget _listView(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.25,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, border: Border()),
                    child: Image.asset("assets/images/logo.jpeg",
                        fit: BoxFit.cover),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(2, 2, 2, 4),
                  child: Text(
                    "Hello, Umberto!",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: 18,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                ListView(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.all(3),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 30, 5, 5),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: ListTile(
                          tileColor: const Color(0xffffffff),
                          title: const Text(
                            "My Boxes",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              color: Color(0xff000000),
                            ),
                            textAlign: TextAlign.start,
                          ),
                          dense: false,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 4),
                          selected: false,
                          selectedTileColor: const Color(0x42000000),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            side:
                                BorderSide(color: Colors.grey[700]!, width: 1),
                          ),
                          leading: const Icon(Icons.work_outline,
                              color: Color(0xff212435), size: 24),
                          trailing: const Icon(Icons.arrow_forward_ios,
                              color: Color(0xff212435), size: 24),
                          onTap: () {},
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: ListTile(
                          tileColor: const Color(0x00000000),
                          title: const Text(
                            "Settings",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              color: Color(0xff000000),
                            ),
                            textAlign: TextAlign.left,
                          ),
                          dense: false,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 4),
                          selected: false,
                          selectedTileColor: const Color(0x42000000),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            side:
                                BorderSide(color: Colors.grey[700]!, width: 1),
                          ),
                          leading: const Icon(Icons.settings,
                              color: Color(0xff212435), size: 24),
                          trailing: const Icon(Icons.arrow_forward_ios,
                              color: Color(0xff212435), size: 24),
                          onTap: () {},
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: ListTile(
                          tileColor: const Color(0x00000000),
                          title: const Text(
                            "Payment Method ",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              color: Color(0xff000000),
                            ),
                            textAlign: TextAlign.start,
                          ),
                          dense: false,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 4),
                          selected: false,
                          selectedTileColor: const Color(0x42000000),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            side:
                                BorderSide(color: Colors.grey[700]!, width: 1),
                          ),
                          leading: const Icon(Icons.credit_card,
                              color: Color(0xff212435), size: 24),
                          trailing: const Icon(Icons.arrow_forward_ios,
                              color: Color(0xff212435), size: 24),
                          onTap: () {},
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: ListTile(
                          tileColor: const Color(0x00000000),
                          title: const Text(
                            "Invite Friends & Earn",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              color: Color(0xff000000),
                            ),
                            textAlign: TextAlign.start,
                          ),
                          dense: false,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 4),
                          selected: false,
                          selectedTileColor: const Color(0x42000000),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            side:
                                BorderSide(color: Colors.grey[700]!, width: 1),
                          ),
                          leading: const Icon(Icons.favorite_border,
                              color: Color(0xff000000), size: 24),
                          trailing: const Icon(Icons.arrow_forward_ios,
                              color: Color(0xff212435), size: 24),
                          onTap: () {},
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: ListTile(
                          tileColor: const Color(0x00000000),
                          title: const Text(
                            "Support",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              color: Color(0xff000000),
                            ),
                            textAlign: TextAlign.start,
                          ),
                          dense: false,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 4),
                          selected: false,
                          selectedTileColor: const Color(0x42000000),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            side:
                                BorderSide(color: Colors.grey[700]!, width: 1),
                          ),
                          leading: const Icon(Icons.help_outline,
                              color: Color(0xff212435), size: 24),
                          trailing: const Icon(Icons.arrow_forward_ios,
                              color: Color(0xff212435), size: 24),
                          onTap: () {},
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 15),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: ListTile(
                          tileColor: const Color(0x00000000),
                          title: const Text(
                            "About Us",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              color: Color(0xff000000),
                            ),
                            textAlign: TextAlign.start,
                          ),
                          dense: false,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 4),
                          selected: false,
                          selectedTileColor: const Color(0x42000000),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            side:
                                BorderSide(color: Colors.grey[700]!, width: 1),
                          ),
                          leading: const Icon(Icons.info_outline,
                              color: Color(0xff212435), size: 24),
                          trailing: const Icon(Icons.arrow_forward_ios,
                              color: Color(0xff212435), size: 24),
                          onTap: () {},
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                  child: MaterialButton(
                    onPressed: () {},
                    color: const Color(0xff000000),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                      side: const BorderSide(color: Colors.grey, width: 1),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    textColor: const Color(0xffffffff),
                    height: 40,
                    minWidth: 140,
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
