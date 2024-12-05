import 'package:flutter/material.dart';
import 'report_details.dart';
import '../styles/style.dart';
class ReportSpecific extends StatelessWidget{
  final String title;
  final List<String> options;

  const ReportSpecific({super.key, required this.title,required this.options});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Report',
          style: AppStyles.headerTextStyle,
          
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppStyles.primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
       
      ),
      body:SingleChildScrollView(
        child: Padding(
        padding: AppStyles.screenPadding,
        child: Column(
          children: [
            Text(title,
            style: AppStyles.listSubtitleTextStyle,
            ),
            const SizedBox(height: 25),
            for(var option in options)
              Column(
                children: [
                   ListTile(
              title: Text(
                option,
                style: AppStyles.listTitleTextStyle,
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReportDetailsScreen(title:option)),
                );
              },
              
            ),
            const Divider(),
                ],
              )
             
            
          ]
        ),
      ),
      ),
    );
  }


}