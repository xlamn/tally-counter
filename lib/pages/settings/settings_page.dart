import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/size_constants.dart';
import '../../repositories/authentication.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: SizeConstants.normal,
            ),
            sliver: SliverAppBar(
              title: const Text(
                "Settings",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              toolbarHeight: HeightConstants.headerHeight,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
          SliverToBoxAdapter(
            child: CupertinoListSection.insetGrouped(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              header: const Text('Google Drive', style: TextStyle(fontFamily: "Poppins")),
              children: [
                CupertinoListTile.notched(
                  title: const Text(
                    'Sign in',
                    style: TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  leading: const FaIcon(
                    FontAwesomeIcons.userAstronaut,
                  ),
                  trailing: const CupertinoListTileChevron(),
                  onTap: () async {
                    await Authentication.signInWithGoogle(context: context);
                  },
                ),
                CupertinoListTile.notched(
                  title: const Text(
                    'Signed in',
                    style: TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  leading: const FaIcon(
                    FontAwesomeIcons.userAstronaut,
                  ),
                  trailing: const Text(
                    "Backup now",
                    style: TextStyle(
                      color: Colors.blue,
                      fontFamily: "Poppins",
                    ),
                  ),
                  onTap: () {},
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Last Backup: 24.6.29",
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: CupertinoListSection.insetGrouped(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              header: const Text('About', style: TextStyle(fontFamily: "Poppins")),
              children: <CupertinoListTile>[
                CupertinoListTile.notched(
                  title: const Text(
                    'GitHub',
                    style: TextStyle(fontFamily: "Poppins"),
                  ),
                  leading: const FaIcon(
                    FontAwesomeIcons.github,
                  ),
                  trailing: const CupertinoListTileChevron(),
                  onTap: () {},
                ),
                CupertinoListTile.notched(
                  title: const Text(
                    'Contact me',
                    style: TextStyle(fontFamily: "Poppins"),
                  ),
                  leading: const FaIcon(FontAwesomeIcons.envelope, color: Colors.blue),
                  trailing: const CupertinoListTileChevron(),
                  onTap: () {},
                ),
                CupertinoListTile.notched(
                  title: const Text(
                    'Tip me a coffee',
                    style: TextStyle(fontFamily: "Poppins"),
                  ),
                  leading: const FaIcon(
                    FontAwesomeIcons.gratipay,
                    color: Colors.red,
                  ),
                  trailing: const CupertinoListTileChevron(),
                  onTap: () {},
                ),
                const CupertinoListTile.notched(
                  title: Text(
                    'Version',
                    style: TextStyle(fontFamily: "Poppins"),
                  ),
                  leading: FaIcon(FontAwesomeIcons.mobileScreenButton),
                  additionalInfo: Text('1.1.1'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
