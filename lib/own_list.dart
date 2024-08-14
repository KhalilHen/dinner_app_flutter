import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dinnerapp/dialogs/create_list_item_dialog.dart';
import 'package:flutter/material.dart'; 
import 'choose_meal.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';


class OwnListPage extends StatefulWidget {
  // var docId;
  final String docId; 

  const OwnListPage({Key? key, required this.docId}) : super(key: key);
  @override
  _OwnListPageState createState() => _OwnListPageState();
}

class _OwnListPageState extends State<OwnListPage> {
final db = FirebaseFirestore.instance;
var docId;
  

// TODO Fix this laterwy.size.width;

void retrieveId() async {
    print('Document ID: ${widget.docId}');

}
void retrieveParentList() async {

var parentCollection = FirebaseFirestore.instance.collectionGroup('list');


var querySnapshot = await parentCollection.get();
for (var queryDocumentSnapshot in querySnapshot.docs) {


  print(queryDocumentSnapshot.data() == ('title'));
}

try {


}
catch (e) {
  print('Failed to retrieve list: $e');
}

}



  Stream<QuerySnapshot<Map<String, dynamic>>> retrieveSubcollection() {
    // Access the subcollection under the document with widget.docId
    return db.collection('list').doc(widget.docId).collection('mealItem').snapshots();
  }


  @override
  Widget build(BuildContext context) {
    final primaryBackgroundColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: primaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(
          // '{$list.title}',
          'test',
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
        stream:  retrieveSubcollection(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            final docs = snapshot.data!.docs;
            return GridView.builder(
              itemCount: docs.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
              ),
              itemBuilder: (context, index) {
                                final data = docs[index].data();
                                final doc = docs[index];
                                print(data);


                              //  return ListTile(


                              //  );

                              return Column(


                                children: [

ListTile(


  //These didn't work for me

  //     visualDensity: VisualDensity(horizontal: 0, vertical: -4),
  //               dense:true,
  //  contentPadding: EdgeInsets.zero,
  // minVerticalPadding: 0,


titleAlignment: ListTileTitleAlignment.top,
  title: Text(data['mealname'] ?? 'No title'),
  subtitle: Text(data['mealDescription'] ?? 'No description'),
  trailing: IconButton(
    icon: Icon(Icons.delete),
    onPressed: () {
    },



  ),
//Add also a border to the tile

    // minTileHeight: 100,

  tileColor: Colors.white,
  onTap: () {
 //Add her elater logic 
  },
)

                                ],
                              );
//     return Card( 

//         margin: EdgeInsets.all(15.0), //I am considering using it 


//   color: Colors.white,

// elevation: 10.0,

//   shadowColor: Colors.black,
//     shape: RoundedRectangleBorder(
//     borderRadius: BorderRadius.circular(15.0),
//   ),

// child: GestureDetector(
//   onTap: () {

 
//   },

// child: Column(
// mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//   children: [
    

//  Text(data['mealname'] ?? 'No title',
  
  
//   style:  TextStyle(
//     decoration: TextDecoration.underline, 
//   )
  
  
//   ),
// Text(data['mealDescription' ?? 'No description']),

//   // if (screenWidth > 614 )
//   // Text(data['description'] ?? 'No description'), //Think not gonna use it for phones as there for too less space 

  


//     ],
// ),

// ),


  
        

        

 
//     );
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
              return CreateListItemDialog(docId: widget.docId);

    },
  );
},
child: Icon(Icons.add),

),

    );
  }
}