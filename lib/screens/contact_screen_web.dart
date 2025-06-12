import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class ContactScreenWeb extends StatelessWidget{
  const ContactScreenWeb({super.key});
  @override
  Widget build(BuildContext context) {
    final employeeData = {
      'Name': 'Prateek Singla',
      'Designation':'Manager(Information System)',
      'Mobile': '917042526274',
      'Email': 'SINGLAP@IINDIANOIL.IN',
      'Location': 'Uttar Pradesh SO II',
      'Department': 'Information System',
    };
    final nameParts = (employeeData['Name'] ?? '').split(' ');
    final lastName = nameParts.length > 1 ? nameParts.last : '';
    final firstName = nameParts.isNotEmpty ? nameParts.first : '';

    final qrData = '''
BEGIN:VCARD
VERSION:3.0
N:$lastName;$firstName
FN:${employeeData['Name']}
TEL;TYPE=CELL:${employeeData['Mobile']}
EMAIL;TYPE=INTERNET:${employeeData['Email']}
END:VCARD
''';
    return Scaffold(
      backgroundColor: const Color(0xFF051951),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF37022),
        title: const Text('Employee Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code, color: Color(0xFF051951)),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('QR for Contact'),
                  content: SizedBox(
                    width: 220,
                    height: 220,
                    child: QrImageView(
                      data: qrData,
                      size: 200,
                    ),
                  ),
                  actions: [
                    IconButton(onPressed: ()async{
                      // final contact = Contact(
                      //   givenName: employeeData['Name'],
                      //   phones: [Item(label: 'mobile', value:employeeData['Mobile'])],
                      //   emails: [Item(label: "work", value: employeeData['Email'])],
                      // );
                      // await ContactsService.addContact(contact);
                    }, icon: Icon(Icons.person), tooltip: "Save Contact",),
                    IconButton(onPressed: (){
                    SharePlus.instance.share(
                        ShareParams(text: 'Name: ${employeeData['Name']}\n'
                        'Mobile: ${employeeData['Mobile']}\n'
                        'Email: ${employeeData['Email']}')
                      );
                    }, icon: Icon(Icons.share), tooltip: "Share Contact"),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: AssetImage('assets/507891.jpg') ,
                      onBackgroundImageError: (_, __) {},
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildInfoTile('Full Name', employeeData['Name']!),
                  _buildInfoTile('Designation', employeeData['Designation']!),
                  _buildInfoTile('Department', employeeData['Department']!),
                  _buildInfoTile('Location', employeeData['Location']!),
                  _buildInfoTile('Mobile', employeeData['Mobile']!),
                  _buildInfoTile('Email', employeeData['Email']!),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildInfoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF051951),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
            ),
          ),
          const Divider(color: Colors.grey),
        ],
      ),
    );
  }
