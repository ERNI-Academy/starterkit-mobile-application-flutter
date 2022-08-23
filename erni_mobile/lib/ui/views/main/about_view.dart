// coverage:ignore-file

import 'package:erni_mobile/common/localization/localization.dart';
import 'package:erni_mobile/ui/resources/resources.dart';
import 'package:erni_mobile/ui/widgets/widgets.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: Text(Il8n.of(context).aboutLicenses),
            onTap: () => showLicensePage(
              context: context,
              applicationIcon: Assets.graphics.icErniLogo.image(width: 128),
            ),
          ),
        ],
      ),
    );
  }
}
