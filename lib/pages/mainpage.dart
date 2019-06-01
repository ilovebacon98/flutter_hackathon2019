import 'package:flutter/material.dart';

enum PageMode { Photo, Message, Friends, Account }

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Flutter Community'),
      ),
      body: _getBody(index),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) => setState(() => index = value),
        items: [
          BottomNavigationBarItem(
              icon:
                  Icon(Icons.add_a_photo, color: Color.fromARGB(255, 0, 0, 0)),
              title: new Text('')),
          BottomNavigationBarItem(
              icon:
                  Icon(Icons.announcement, color: Color.fromARGB(255, 0, 0, 0)),
              title: new Text('')),
          BottomNavigationBarItem(
              icon: Icon(Icons.perm_identity,
                  color: Color.fromARGB(255, 0, 0, 0)),
              title: new Text(''))
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Widget _buildMessagePage() {
    return new Container(
      alignment: Alignment.centerLeft,
      margin: new EdgeInsets.all(8.0),
      padding: new EdgeInsets.all(8.0),
      height: 150.0,
      decoration: new BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
          boxShadow: [
            new BoxShadow(
                color: Colors.black54,
                offset: new Offset(2.0, 2.0),
                blurRadius: 5.0)
          ]),
      child: new Row(
        children: <Widget>[
          new CircleAvatar(
            backgroundColor: Colors.white70,
            radius: 50.0,
            backgroundImage: AssetImage('assets/user.jpg'),
          ),
          new Expanded(
              child: new Padding(
            padding: new EdgeInsets.only(left: 8.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  'Topic#1 How to make this widget works',
                  style: new TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                new Row(
                  children: <Widget>[
                    new Icon(
                      Icons.star,
                      color: Colors.white,
                    ),
                    new Icon(
                      Icons.star,
                      color: Colors.white,
                    ),
                    new Icon(
                      Icons.star,
                      color: Colors.white,
                    ),
                    new Icon(
                      Icons.star_half,
                      color: Colors.white,
                    ),
                    new Icon(
                      Icons.star_border,
                      color: Colors.white,
                    ),
                  ],
                ),
                new Wrap(
                  spacing: 2.0,
                  children: <Widget>[
                    new Chip(label: new Text('Widgets')),
                    new Chip(label: new Text('UI')),
                    new Chip(label: new Text('Material')),
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }

  Widget _buildProfile() {
    return new ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: 'assets/user.jpg',
                child: Container(
                  height: 125.0,
                  width: 125.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(62.5),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/user.jpg'))),
                ),
              ),
              SizedBox(height: 25.0),
              Text(
                'Eric',
                style: TextStyle(
                    fontFamily: 'Oswald',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.0),
              Text(
                'Singapore',
                style: TextStyle(fontFamily: 'Oswald', color: Colors.grey),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '24K',
                          style: TextStyle(
                              fontFamily: 'Oswald',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'FOLLOWERS',
                          style: TextStyle(
                              fontFamily: 'Oswald',
                              color: Colors.grey),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '31',
                          style: TextStyle(
                              fontFamily: 'Oswald',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Posts',
                          style: TextStyle(
                              fontFamily: 'Oswald',
                              color: Colors.grey),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '21',
                          style: TextStyle(
                              fontFamily: 'Oswald',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Friends',
                          style: TextStyle(
                              fontFamily: 'Oswald',
                              color: Colors.grey),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.table_chart)),
                    IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      );
  }

Widget _buildCamera(){
  return Container(
    margin: EdgeInsets.all(5.0),
    alignment: Alignment.center,
    child:  new Icon(Icons.camera_alt,),
  );
}


  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return _buildCamera(); // Create this function, it should return your first page as a widget
      case 1:
        return _buildMessagePage(); // Create this function, it should return your second page as a widget
      case 2:
        return _buildProfile(); // Create this function, it should return your fourth page as a widget
    }

    return Center(
      child: Text("There is no page builder for this index."),
    );
  }
}
