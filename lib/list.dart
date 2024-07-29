import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'; 
import 'homepage.dart';
import 'choose_meal.dart';
import 'firebase_options.dart';
import './dialogs/create_list_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';


class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  int _currentIndex = 2;
final db = FirebaseFirestore.instance;



// db = FirebaseFirestore.instance;

void retrieveList() async {

var collection =  FirebaseFirestore.instance.collection('list');
var querySnapshot = await collection.get();
for (var queryDocumentSnapshot in querySnapshot.docs) {
  print(queryDocumentSnapshot.data());
}
try {


}
catch (e) {
  print('Failed to retrieve list: $e');
}

}


  @override
  Widget build(BuildContext context) {
    final primaryBackgroundColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: primaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(
          'Homepage',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Handle notification button press
            },
            icon: Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () {
              // Handle help button press
            },
            icon: Icon(Icons.help),
          ),
        ],
      ),
 body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('list').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          if (snapshot.connectionState == ConnectionState.waiting) {
            //return Center(child: CircularProgressIndicator());
          return Wrap(

children: [
  Card()
],

          );
          }
          if (snapshot.hasData) {
            final docs = snapshot.data!.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final data = docs[index].data();
                return ListTile(
                  title: Text(data['title']),
                );
              },
            );
          }
          return Center(child: Text('No data found'));
        },
      ),
    //   body: SingleChildScrollView(
    //     child: Wrap (
        
    //       children: [
        
    //         Row(
    //     children: [

    //  GridView(



    //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 2,
    //       crossAxisSpacing: 10,
    //       mainAxisSpacing: 10,
    //     ),


    //    children: [

    //   Card.outlined(
        
       
    //    child: Text('Title'),          ),
    //    ], 
    //  )
        
    //     ],
        
          
    //     ///Here for each every list
        
    //         )
    //       ],
             
        
    //     ),
    //   ),
floatingActionButton: FloatingActionButton(

onPressed: () {
  showDialog(
    context: context,
    builder: (context) {
      return CreateListDialog();
    },
  );
},
child: Icon(Icons.add),

),
           bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          switch (index) {
            case 0:
Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const Homepage(),
                    ),
                  );
              break;
            case 1:
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChooseMealPage(),
                ),
              );
              break;
            case 2:
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ListPage(),
                ),
              );
              break;
          }
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lunch_dining),
            label: 'Choose',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Lists',
          ),
        ],
      ),
    );
  }
}