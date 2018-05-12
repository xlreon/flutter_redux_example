import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() => runApp(new MyApp());


class AppState {
  final counter;
  AppState(this.counter);
}

enum Actions { Increment }

AppState reducer(AppState prev,action) {
  if(action == Actions.Increment) {
    return new AppState(prev.counter+1);
  }
  else 
  return prev;
} 

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Redux Example',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  final store = new Store(reducer,initialState: new AppState(0));

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<dynamic>(
          store: store,
          child: new Scaffold(
        appBar: new AppBar(
          title: new Text("Flutter Redxu"),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                'You have pushed the button this many times:',
              ),
            new StoreConnector(
              converter: (store)=>store.state.counter,
              builder: (context,counter)=>new Text('$counter',style: Theme.of(context).textTheme.display1,),
            )
            ],
          ),
        ),
        floatingActionButton: new StoreConnector<dynamic,VoidCallback>(
          converter: (store) {
            return ()=> store.dispatch(Actions.Increment);
            },
          builder: (context,callback)=>new FloatingActionButton(
          onPressed: callback,
          tooltip: 'Increment',
          child: new Icon(Icons.add),
        )
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
