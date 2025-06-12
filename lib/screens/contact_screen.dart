import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';
import 'package:share_plus/share_plus.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key, required this.xmldata, required this.empId});

  final String xmldata; // JSON string
  final String empId;

  Map<String, String> _parseJsonData(String jsonString) {
    final Map<String, dynamic> data = json.decode(jsonString);
    // Support both list and map for EmpMasterPWAOutput
    final empRaw = data['EmpMasterPWAOutput'];
    final emp = empRaw is List ? empRaw[0] : empRaw;
    return {
      'Name': emp['EMP_NAME'] ?? '',
      'Designation': emp['DESIGNATION'] ?? '',
      'Mobile': emp['MOBILE_NO'] ?? '',
      'Email': emp['EMAIL_ID'] ?? '',
      'Location': emp['LOC_NAME'] ?? '',
      'Department': emp['FUNC'] ?? '',
    };
  }

  @override
  Widget build(BuildContext context) {
    final employeeData = _parseJsonData(xmldata);

    // vCard fields
    final nameParts = (employeeData['Name'] ?? '').split(' ');
    final lastName = nameParts.length > 1 ? nameParts.last : '';
    final firstName = nameParts.isNotEmpty ? nameParts.first : '';

    final qrData = '''
BEGIN:VCARD
VERSION:3.0
N:$lastName;$firstName
FN:${employeeData['Name']}
TITLE:${employeeData['Designation']}
ORG:${employeeData['Department']}
ADR;TYPE=WORK:;;${employeeData['Location']}
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
                      if(await FlutterContacts.requestPermission()){
                        final name = employeeData['Name']??'';
                        final nameParts = name.split(' ');
                        final firstName = nameParts.isNotEmpty ? nameParts.first : '';
                        final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';
                        final contact = Contact()
                          ..name.first = firstName
                          ..name.last = lastName
                          ..phones = [Phone(employeeData['Mobile'] ?? '')]
                          ..emails = [Email(employeeData['Email'] ?? '')]
                          ..organizations = [
                            Organization(
                              company: employeeData['Department'] ?? '',
                              title: employeeData['Designation'] ?? '',
                            )
                          ];
                        await contact.insert();
                        if(context.mounted){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Contact Saved!')));
                        }
                      }
                      else{
                        if(context.mounted){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error !')));
                        }
                      }
                    }, icon: Icon(Icons.person), tooltip: "Save Contact",),
                    IconButton(onPressed: (){
                      SharePlus.instance.share(ShareParams(
                        text: ('Name: ${employeeData['Name']}\n'
                          'Mobile: ${employeeData['Mobile']}\n'
                          'Email: ${employeeData['Email']}'),
                        subject: 'Contact Info',
                        title: 'Contact'
                      )); 
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
                      backgroundImage: NetworkImage(
                        'https://xsparsh.indianoil.in/APIManager/empphoto/$empId.jpg',
                      ),
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
}