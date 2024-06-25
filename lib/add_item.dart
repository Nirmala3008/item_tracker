import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'item_model.dart';
import 'item_provider.dart';

class AddItems extends StatefulWidget {
  final Item? item;
  final int? id;

  AddItems({this.item, this.id});

  @override
  _AddItemsState createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String description;

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      name = widget.item!.name;
      description = widget.item!.description;
    } else {
      name = '';
      description = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 25, 50, 1),
        elevation: 0,
        centerTitle: true,
        title: Text(widget.item == null ? 'Add Item' : 'Edit Item',
          style: GoogleFonts.poppins(
            color: Colors.white,
            // fontFamily: 'Poppins',
            fontSize: 22,
            letterSpacing: 0 ,
            fontWeight: FontWeight.w500,
            height: 1),),
        leading: GestureDetector(
            onTap: () {
                Navigator.pop(context);
            },
            child:  Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 20,
            )
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: name,
                decoration: InputDecoration(
                    labelText: 'Item Name',

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 0.50,
                        color:
                        Theme.of(context).dividerColor),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),

                ),
                cursorColor: Colors.black87,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value!;
                },
              ),
              SizedBox(height: 20,),
              TextFormField(
                initialValue: description,
                decoration: InputDecoration(labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 0.50,
                        color:
                        Theme.of(context).dividerColor),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                cursorColor: Colors.black87,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  description = value!;
                },
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 120,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      if (widget.item == null) {
                        Provider.of<ItemProvider>(context, listen: false).addItem(Item(name: name, description: description));
                      } else {
                        Provider.of<ItemProvider>(context, listen: false).editItem(widget.id!,
                            Item(name: name, description: description));
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: Text(widget.item == null ? 'Add' : 'Save',
                      style: GoogleFonts.poppins(
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
            ],
          ),
        ),
      ),
    );
  }
}
