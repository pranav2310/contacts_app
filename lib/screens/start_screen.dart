import 'package:contacts_app/screens/contact_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final _empIdController = TextEditingController();
  Future <void> _getInfo() async{
    String empId = _empIdController.text.trim();
    empId = empId.replaceFirst(RegExp(r'^0+'), '');
    if(empId.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Enter Employee ID')));
      return;
    }
    final xmllink = "https://xsparsh.indianoil.in/soa-infra/resources/default/MPower/EmpProfile/?emp_code=$empId";
    try{
      final response = await http.get(Uri.parse(xmllink));
      print(response.body);
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
      if(kIsWeb){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("CORS Error Demo Data")));
        Navigator.push(
          context, MaterialPageRoute(
            builder: (ctx)=>ContactScreen(
              xmldata: '''
                {
                  "EmpMasterPWAOutput" : [ {
                    "EMP_CODE" : "000000",
                    "EMP_INI" : "Mr.",
                    "EMP_NAME" : "IOCL",
                    "DESIGNATION_CODE" : "00000000",
                    "DESIGNATION" : "IOCL",
                    "CURR_COMP_CODE" : "0000",
                    "CURR_COMP" : "IOCL",
                    "DIG" : "00000000",
                    "PA_CODE" : "IOCL",
                    "PA" : "IOCL",
                    "PSA_CODE" : "AA00",
                    "PSA" : "IOCL",
                    "LOC_CODE" : "0000",
                    "LOC_NAME" : "IOCL",
                    "EMP_GRP_CODE" : "A",
                    "EMP_GRP" : "A",
                    "EMP_SUB_GRP_CODE" : "AA",
                    "EMP_SUB_GRP" : "IOCL",
                    "SALES_GROUP" : "NA",
                    "SALES_AREA" : "NA",
                    "FUNC_CODE" : "A00",
                    "FUNC" : "Information Systems",
                    "FUNC_AREA_CODE" : "M1900",
                    "FUNC_AREA" : "Information Systems",
                    "FUNC_HEAD_YN" : "NA",
                    "LOCN_IC_YN" : "NA",
                    "MOBILE_NO" : "NA",
                    "EMAIL_ID" : "NA"
                  } ]
                }''', 
              empId: empId
            )
          )
        );
      }
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
      backgroundColor: const Color(0xFFFFFFFF),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/logo.gif",height: 150,),
              const SizedBox(height: 40,),
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                color: const Color(0xFFF37022),
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Employee Id:',
                        style: TextStyle(
                          color: Color(0xFF051951), 
                          fontSize: 25,fontWeight: 
                          FontWeight.bold
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 24,),
                      TextFormField(
                        controller: _empIdController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Employee ID',
                          hintText: 'Enter a valid Employee ID',
                          prefixIcon: const Icon(Icons.badge),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                      ),
                      const SizedBox(height: 24,),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: (){
                            _getInfo();
                          }, 
                          label: const Text(
                            'Get Info',
                            style: TextStyle(fontSize: 18),
                          ),
                          icon: Icon(Icons.login),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF051951),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            )
                          ),
                        )
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
