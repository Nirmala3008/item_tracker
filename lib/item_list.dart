import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'add_item.dart';
import 'item_provider.dart';

class ItemListPage extends StatefulWidget {
  @override
  State<ItemListPage> createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  final Map<int, GlobalKey> itemKeys = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 25, 50, 1),
        elevation: 0,
        centerTitle: true,
        title: Text('Item Tracker',
          style: GoogleFonts.poppins(
              color: Colors.white,
              // fontFamily: 'Poppins',
              fontSize: 22,
              letterSpacing: 0 ,
              fontWeight: FontWeight.w500,
              height: 1),),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Consumer<ItemProvider>(
          builder: (context, itemProvider, child) {
            return Column(
              children: [
                SizedBox(height: 15,),
                SizedBox(
                  width: 180,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddItems(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Text('Add Item',style: GoogleFonts.poppins(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          // fontFamily: 'Poppins',
                          fontSize: 17,
                          letterSpacing: 0 ,
                          fontWeight: FontWeight.w500,
                          height: 1),),
                    ),
                    style: ButtonStyle(
                        overlayColor:
                        MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.white.withOpacity(0.8);
                            }
                            return Colors.transparent;
                          },
                        ),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(0, 25, 50, 1))

                        ),
                  ),
                ),
                SizedBox(height: 10),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: itemProvider.itemsList.length,
                  itemBuilder: (context, index) {
                    final item = itemProvider.itemsList[index];
                    return Column(
                      children: [
                        Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.only(left: 10.0, right: 10, top: 0, bottom: 0),
                          child: ListTile(
                            contentPadding: EdgeInsets.only(left: 20, right: 3),
                            visualDensity: VisualDensity(horizontal: -3, vertical: -2),
                            dense: true,
                            tileColor: Colors.grey.shade300,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            title: Text(item.name,
                              style: GoogleFonts.poppins(
                                  color: Colors.black87,
                                  // fontFamily: 'Poppins',
                                  fontSize: 14.7,
                                  letterSpacing: 0 ,
                                  fontWeight: FontWeight.w500,
                                  height: 1),),
                            subtitle: Text(item.description,
                              style: GoogleFonts.poppins(
                                  color: Colors.black87,
                                  // fontFamily: 'Poppins',
                                  fontSize: 14,
                                  letterSpacing: 0 ,
                                  fontWeight: FontWeight.w400,
                                  height: 1),),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit_outlined),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddItems(
                                          item: item,
                                          id: index,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete_outlined),
                                  onPressed: () {
                                    itemProvider.removeItem(index);
                                  },
                                ),
                              ],
                            ),
                            onTap: () {
                              final renderBox = itemKeys[index]!.currentContext!.findRenderObject() as RenderBox;
                              final size = renderBox.size;
                              final position = renderBox.localToGlobal(Offset.zero);
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Item Info'),
                                    content: Text('Size: $size\nPosition: $position'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },

                          ),
                        ),
                        SizedBox(height: 3,)
                      ],
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),

    );
  }
}
