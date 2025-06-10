import 'package:contacts_app/screens/contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final _empIdController = TextEditingController();

  // void _submit(){
  //   final empID = _empIdController.text.trim();
  //   final String xmldata = '''
  //   <ns0:EmpMasterPWAOutputCollection xmlns:jca="http://xmlns.oracle.com/pcbpel/wsdl/jca/" xmlns:plnk="http://docs.oasis-open.org/wsbpel/2.0/plnktype" xmlns:ns1="http://xmlns.oracle.com/XsparshSOA/MPower/EmpProfile" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" xmlns:tns="http://xmlns.oracle.com/pcbpel/adapter/db/XsparshSOA/MPower/EmpMasterPWA" xmlns:plt="http://schemas.xmlsoap.org/ws/2003/05/partner-link/" xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/EmpMasterPWA">
  //     <ns0:EmpMasterPWAOutput>
  //       <ns0:EMP_CODE>507891</ns0:EMP_CODE>
  //       <ns0:EMP_INI>Mr.</ns0:EMP_INI>
  //       <ns0:EMP_NAME>Prateek Singla</ns0:EMP_NAME>
  //       <ns0:DESIGNATION_CODE>80917016</ns0:DESIGNATION_CODE>
  //       <ns0:DESIGNATION>Manager (Information System)</ns0:DESIGNATION>
  //       <ns0:CURR_COMP_CODE>1500</ns0:CURR_COMP_CODE>
  //       <ns0:CURR_COMP>Uttar Pradesh SO II</ns0:CURR_COMP>
  //       <ns0:DIG>13032024</ns0:DIG>
  //       <ns0:PA_CODE>MSE1</ns0:PA_CODE>
  //       <ns0:PA>Uttar Pradesh SO II</ns0:PA>
  //       <ns0:PSA_CODE>IS00</ns0:PSA_CODE>
  //       <ns0:PSA>Info. Systems</ns0:PSA>
  //       <ns0:LOC_CODE>1500</ns0:LOC_CODE>
  //       <ns0:LOC_NAME>Uttar Pradesh SO II</ns0:LOC_NAME>
  //       <ns0:EMP_GRP_CODE>R</ns0:EMP_GRP_CODE>
  //       <ns0:EMP_GRP>Regular</ns0:EMP_GRP>
  //       <ns0:EMP_SUB_GRP_CODE>AC</ns0:EMP_SUB_GRP_CODE>
  //       <ns0:EMP_SUB_GRP>IOC Ofcr Gr C</ns0:EMP_SUB_GRP>
  //       <ns0:SALES_GROUP>NA</ns0:SALES_GROUP>
  //       <ns0:SALES_AREA>NA</ns0:SALES_AREA>
  //       <ns0:FUNC_CODE>M19</ns0:FUNC_CODE>
  //       <ns0:FUNC>Information Systems</ns0:FUNC>
  //       <ns0:FUNC_AREA_CODE>M1900</ns0:FUNC_AREA_CODE>
  //       <ns0:FUNC_AREA>Information Systems</ns0:FUNC_AREA>
  //       <ns0:FUNC_HEAD_YN>NA</ns0:FUNC_HEAD_YN>
  //       <ns0:LOCN_IC_YN>NA</ns0:LOCN_IC_YN>
  //       <ns0:MOBILE_NO>917042526274</ns0:MOBILE_NO>
  //       <ns0:EMAIL_ID>SINGLAP@INDIANOIL.IN</ns0:EMAIL_ID>
  //     </ns0:EmpMasterPWAOutput>
  //   </ns0:EmpMasterPWAOutputCollection>''';
  //   if(empID.isEmpty || ! xmldata.contains('EmpMasterPWAOutput')){
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter Valid Employee Id")));
  //     return;
  //   }
    
  //   Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ContactScreen(xmldata: xmldata, empId: "507891",)));
  // }

  Future <void> _submit() async{
    final empId = _empIdController.text.trim();
    if(empId.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Enter Employee ID')));
      return;
    }
    final xmllink = "https://xsparsh.indianoil.in/soa-infra/resources/default/MPower/EmpProfile/?emp_code=$empId";
    try{
      final response = await http.get(Uri.parse(xmllink));
      if(response.statusCode == 200 && response.body.contains("EmpMasterPWAOutput")){
        Navigator.push(
          context, MaterialPageRoute(
            builder: (ctx)=>ContactScreen(
              xmldata: response.body, 
              empId: empId
            )
          )
        );
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Invalid Employee ID'
            )
          )
        );
      }
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error: ${e.toString()}'
          )
        )
      );
    }
  }

  @override
  void dispose() {
    _empIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF37022),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Employee Id:',
                style: TextStyle(color: Color(0xFF051951), fontSize: 25,fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              TextField(
                controller: _empIdController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
