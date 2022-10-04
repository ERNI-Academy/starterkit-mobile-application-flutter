// coverage:ignore-file

import 'package:erni_mobile/business/services/ui/navigation/navigation_service_impl.dart';
import 'package:erni_mobile/common/localization/localization.dart';
import 'package:erni_mobile/ui/widgets/widgets.dart';

class AboutView extends StatelessWidget {
  const AboutView() : super(key: const Key(AboutViewRoute.name));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: Text(Il8n.of(context).aboutLicenses),
            onTap: () => showLicensePage(context: context, useRootNavigator: true),
          ),
        ],
      ),
    );
  }
}
