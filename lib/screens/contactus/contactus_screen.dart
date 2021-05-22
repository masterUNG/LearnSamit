import 'package:flutter/material.dart';
import 'package:ASmartApp/themes/theme.dart';

class ContactusScreen extends StatefulWidget {
  ContactusScreen({Key key}) : super(key: key);

  @override
  _ContactusScreenState createState() => _ContactusScreenState();
}

class _ContactusScreenState extends State<ContactusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ติดต่อทีมงาน'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'BAAC A-Staff Team contact',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'ติดต่อทีมงาน แนะนำ ติชม สอบถาม',
                          style: Theme.of(context).textTheme.smallerBlack,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'กลุ่มงานสารสนเทศ HR ฝ่ายทรัพยากรมนุษย์ (ฝทน.)',
                          style: Theme.of(context).textTheme.smallerBlack,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'ธนาคารเพื่อการเกษตรและสหกรณ์การเกษตร (ธ.ก.ส.)',
                          style: Theme.of(context).textTheme.smallerBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('อีเมล์'),
            subtitle: Text('hris@baac.or.th'),
            trailing: Icon(Icons.send),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.call),
            title: Text('โทรศัพท์'),
            subtitle: Text('0-2555-0555 ต่อ 8791-3'),
            trailing: Icon(Icons.call_missed_outgoing),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
