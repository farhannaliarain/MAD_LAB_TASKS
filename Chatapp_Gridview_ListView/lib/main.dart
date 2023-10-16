import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home:const MyHomePage(title: "hello",));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String text = "hello";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
                iconSize: 25,
              ),
              IconButton(
                onPressed: () {},
                icon:const Icon(Icons.camera_alt),
                iconSize: 25,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
                iconSize: 25,
              ),
            ],
            bottom: const TabBar(
              tabs: [
              Tab(
                child: Text("chats"),
                //icon: Icon(Icons.ac_unit),
              ),
              Tab(
                child: Text("status"),
              ),
              Tab(
                child: Text("Calls"),
              )
            ]),
            backgroundColor:const Color.fromRGBO(18, 140, 126, 50), //18 140 126,
          ),
          body: TabBarView(children:[GridWidget(), lab_dub(), Text("hello")]),
          drawer: Drawer(
            child: ListView(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }
}

class GridWidget extends StatelessWidget {
  const GridWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:GridView.builder(
          itemCount: 10,
           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 60, crossAxisSpacing: 60),
          itemBuilder: (context, index) {
            return Container(
                //decoration: const BoxDecoration(
               color: Colors.blue,
                  //  borderRadius: BorderRadius.all(Radius.circular(30))),
                height: 50,
                width: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   const Icon(
                      Icons.person,
                      size: 50,
                    ),
                    Text("Person $index")
                  ],
                )
                );
          },
        ),
     // ),
    );
  }
}

class lab_dub extends StatelessWidget {
  lab_dub({super.key});

  //String? name;
  List<String> students = ["shahzad", "awais", "asad", "Junaid", "farhan"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, Index) {
              return ListTile(
                //leading: Icon(Icons.person),
                title: Text(students[Index]),
              );
            }));
  }
}