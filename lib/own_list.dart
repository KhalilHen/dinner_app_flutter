import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dinnerapp/dialogs/create_list_item_dialog.dart';
import 'package:flutter/material.dart'; 
import 'choose_meal.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './dialogs/create_list_dialog.dart';
import './dialogs/edit_list_item.dart';

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
  var itemId;
  String? listTitle;

  @override
    void initState() {
      super.initState();
     
      fetchListTitle();
    }



void fetchListTitle() async {
  var doc = await db.collection('list').doc(widget.docId).get();
  var data = doc.data();
  setState(() {
    listTitle = data!['title'];
  });
}




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

// void editMeal() async {

//  var itemCollection = FirebaseFirestore.instance.collection('mealItem').doc(itemId).get();
//   print(itemCollection);

//     print(itemId);
// }

  @override
  Widget build(BuildContext context) {
    final primaryBackgroundColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: primaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(

            // '{$list.title}',
          // 'test',
          // 'Your list(s)',



          listTitle ?? 'No title'
          ,
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
                     childAspectRatio: 4,
              ),
              itemBuilder: (context, index) {
                                final data = docs[index].data();
                                final doc = docs[index];
                                print(data);


                              //  return ListTile(


                              //  );

          return Container(
            padding: EdgeInsets.all(5),          
height: 60,
child: ListTile(



    //Might add this not sure yet.
    // shape: RoundedRectangleBorder(

    //   borderRadius: BorderRadius.circular(20),
    // ),

    
      title: Text(data['mealname'] ?? 'No title'),

                    contentPadding: EdgeInsets.all(15.0),
     dense: true,
    
  
    // color: Colors.white,
    tileColor: Colors.white,
      subtitle: Text(data['mealDescription'] ?? 'No description'),
      
      trailing: Wrap(

      
        spacing: 12,
        children: <Widget>  [
// Text(data['mealId']),
// Text('data: {$data  }'),

 IconButton(onPressed: () {
// editMeal( );

            showDialog(
              context: context,
           
           builder: (context) {

            return EditListItemDialog(
              
              
    docId: widget.docId,
                    itemId: doc.id,
                    mealName: data['mealname'] ?? '',
                    mealDescription: data['mealDescription'] ?? '',
                    mealImage: data['mealImage'] ?? '',              
              
              );
          // return EditListItemDialog();

           }
              // builder: (context) {
              //   return CreateListItemDialog(docId: widget.docId, doc: doc);
              // },
 
 );},
         icon: Icon(Icons.edit),),



IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            db.collection('list').doc(widget.docId).collection('mealItem').doc(doc.id).delete();
          },
        ),
       


        ] 
      ),
      onTap: () {
    
      }, 
    
    ),

          );                  
return LimitedBox(


    maxHeight: 40,
    maxWidth: 80,
    // color: Colors.white,
    child: ListTile(
                        contentPadding: EdgeInsets.all(15.0),
     dense: true,
    
    // color: Colors.white,
    tileColor: Colors.white,
      title: Text(data['mealname'] ?? 'No title'),
      subtitle: Text(data['mealDescription'] ?? 'No description'),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          db.collection('list').doc(widget.docId).collection('mealItem').doc(doc.id).delete();
        },
      ),
      onTap: () {
    
      }, 
    
    ),
  

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