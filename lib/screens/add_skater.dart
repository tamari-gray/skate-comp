import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skate_comp/state.dart';

class AddSkater extends StatefulWidget {
  @override
  _AddSkaterState createState() => _AddSkaterState();
}

class _AddSkaterState extends State<AddSkater> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add skater"),
        automaticallyImplyLeading: false,
      ),
      body: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  // Add TextFormFields and RaisedButton here.
                  TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: "enter name"),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter skaters name';
                      }
                      return null;
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            // add skater to state
                            Provider.of<ContestState>(context, listen: false)
                                .addSkater(_controller.text);
                            // redirect to home
                            Navigator.pop(context);
                          }
                        },
                        child: Text("Add"),
                      ),
                      FlatButton(
                        onPressed: () {
                          // clear text feild
                          _controller.clear();
                          // redirect to home
                          Navigator.pop(context);
                        },
                        child: Text("Cancel"),
                      )
                    ],
                  ),
                ]),
              ),
              width: 350,
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.fromLTRB(0, 75, 0, 0),
          //   child: Container(
          //     child: Row(
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: <Widget>[
          //         RaisedButton(
          //           onPressed: () {
          //             // add skater to state
          //             Provider.of<ContestState>(context, listen: false)
          //                 .addSkater(_controller.text);
          //             // redirect to home
          //             Navigator.pop(context);
          //           },
          //           child: Text("Add"),
          //         ),
          //         FlatButton(
          //           onPressed: () {
          //             // clear text feild
          //             _controller.clear();
          //             // redirect to home
          //             Navigator.pop(context);
          //           },
          //           child: Text("Cancel"),
          //         )
          //       ],
          //     ),
          //   ),
          // )
        ],
      )),
    );
  }
}
