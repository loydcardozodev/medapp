import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medapp/routing/routes.dart';
import 'package:medapp/ui/patient_screen//home/view/widget/bannerWidget.dart';
import 'package:medapp/ui/patient_screen//home/view/widget/doc_list.dart';
import 'package:medapp/ui/patient_screen//home/view/widget/upcoming_list.dart';

List<Map<String, String>> items = [
  {
    "name": "Dr. John Doe",
    "type": "Cardiologist",
    "image": "https://i.pravatar.cc/150?img=1",
  },
  {
    "name": "Dr. Smith",
    "type": "Dentist",
    "image": "https://i.pravatar.cc/150?img=2",
  },
  {
    "name": "Dr. Alex",
    "type": "Neurologist",
    "image": "https://i.pravatar.cc/150?img=3",
  },
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Center(
                child: Text(
                  'Schedule your next medical appointment',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),

              SizedBox(height: 10),

              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[300],
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search',
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),

              SizedBox(height: 10),

              BannerWidget(),

              SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Today's reminder",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  TextButton(
                    onPressed: () {
                      context.push(Routes.appointmentscreen);
                    },
                    child: Text(
                      'See more',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),

              UpcomingList(),

              SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Doctors",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  TextButton(
                    onPressed: () {
                      context.push(Routes.doctorList);
                    },
                    child: Text(
                      'See more',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return DocList(
                    name: items[index]["name"]!,
                    type: items[index]["type"]!,
                    image: items[index]["image"]!,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
