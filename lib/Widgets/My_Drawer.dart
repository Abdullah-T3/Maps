import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maps/Constants/Strings.dart';
import 'package:maps/View_Models/Auth_ViewModel.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  
  Widget buildDrawerHeader(context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsetsDirectional.fromSTEB(70, 10, 70, 10),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.blue[100],
          ),
          child: Image.asset("assets/images/Abdullah.jpg"),
        ),
        const Text(
          "Abdullah Ahmed",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Xp6Xw@example.com",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget buildDrawerListItem(
      {required IconData leadingIcon,
      required String title,
      Widget? triling,
      Function()? onTap,
      Color? color}) {
    return ListTile(
      leading: Icon(
        leadingIcon,
        color: color ?? Colors.blue,
      ),
      title: Text(title),
      trailing: triling ??
          Icon(
            Icons.arrow_right,
            color: Colors.blue,
          ),
      onTap: onTap,
    );
  }

  void _luncherUrl(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  Widget buildIcon(IconData icon, String url) {
    return InkWell(
      onTap: () {
        _luncherUrl(url);
      },
      child: Icon(
        icon,
        color: Colors.blue,
        size: 30,
      ),
    );
  }

  Widget buildSocialIcon() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          buildIcon(FontAwesomeIcons.github, 'https://github.com/Abdullah-T3'),
          SizedBox(width: 15),
          buildIcon(FontAwesomeIcons.linkedin,
              'https://www.linkedin.com/in/abdullah-ahmed59/'),
          SizedBox(width: 15),
          buildIcon(FontAwesomeIcons.facebook,
              'https://www.facebook.com/profile.php?id=100078438493136'),
        ],
      ),
    );
  }

  Widget buildDrawerListItemDivider() {
    return const Divider(
      height: 0,
      thickness: 1,
      indent: 18,
      endIndent: 24,
    );
  }

  @override
  Widget build(BuildContext context) {
     final authViewModel = Provider.of<AuthViewModel>(context);
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          height: 280,
          child: DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue[100],
            ),
            child: buildDrawerHeader(context),
          ),
        ),
        buildDrawerListItem(leadingIcon: Icons.person, title: "My Profile"),
        buildDrawerListItemDivider(),
        buildDrawerListItem(
          leadingIcon: Icons.history,
          title: "Places History",
          onTap: () {},
        ),
        buildDrawerListItemDivider(),
        buildDrawerListItem(leadingIcon: Icons.settings, title: "Settings"),
        buildDrawerListItemDivider(),
        buildDrawerListItem(leadingIcon: Icons.help, title: "Help"),
        buildDrawerListItemDivider(),
        buildDrawerListItem(
          leadingIcon: Icons.logout,
          title: "Logout",
          onTap: ()async {
            await authViewModel.signOut();
            Navigator.of(context).pushNamedAndRemoveUntil(signInRoute , (route) => false);
          },
          color: Colors.red,
          triling: const SizedBox()
        ),
        const SizedBox(
          height: 100,
        ),
        ListTile(
          leading: Text("Follow me",style: TextStyle(color: Colors.grey[600 ]),),
          
        ),
        buildSocialIcon()
      ],
    ));
  }
}
