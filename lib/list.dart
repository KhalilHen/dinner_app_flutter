import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'; 
import 'homepage.dart';
import 'choose_meal.dart';
import 'firebase_options.dart';
import './dialogs/create_list_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'own_list.dart ';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key,);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  int _currentIndex = 2;
final db = FirebaseFirestore.instance;
var  docId;
    // final mediaQuery = MediaQuery.of(context);

// TODO Fix this later
    // final screenWidth = mediaQuery.size.width;



void retrieveList() async {

var collection =  FirebaseFirestore.instance.collection('customLists');
var querySnapshot = await collection.get();
for (var queryDocumentSnapshot in querySnapshot.docs) {

  String docId = queryDocumentSnapshot.id;
  print('Document ID: $docId');
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
          docId = snapshot.data!.docs[0].id;
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            final docs = snapshot.data!.docs;
            return GridView.builder(
              itemCount: docs.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                
                                final data = docs[index].data();
                                final doc = docs[index];
      print('Document ID: ${doc.id}');
                                
    return Card( 
          
        margin: EdgeInsets.all(15.0), //I am considering using it 


  color: Colors.white,

elevation: 10.0,

  shadowColor: Colors.black,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0),
  ),

child: GestureDetector(
  onTap: () {

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => OwnListPage(docId: doc.id),
      ),
    );
  },

child: Column(
mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
  children: [

 Text(data['title'] ?? 'No title',
  
  
  style:  TextStyle(
    decoration: TextDecoration.underline, 
  )
  
  
  ),
    Text(
                    'ID: ${doc.id}',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
    ),

  // if (screenWidth > 614 )
  // Text(data['description'] ?? 'No description'), //Think not gonna use it for phones as there for too less space 

  


    ],
),

),


  
        

        

 
    );
              },
            );
          }
          return Center(child: Text('No data found'));
        },
      ),

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