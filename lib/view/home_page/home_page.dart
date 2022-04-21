import 'package:flutter/material.dart';
import '../../api/citation_api.dart';
import '../../models/citationResponse.dart';

class HomePage extends StatefulWidget {
  final String title;
  HomePage({this.title});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    bool isSelected = false;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        title: Text(widget.title, style: TextStyle(color: Colors.blue, fontSize: 32)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder<List<Result>>(
                    future: CitationApiServices().fetchCitationServices(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: Wrap(
                                    spacing: 5.0,
                                    runSpacing: 5.0,
                                    children: <Widget>[
                                      ChoiceChipWidget(
                                          chipName: 'Meio Ambiente'),
                                      ChoiceChipWidget(chipName: 'Saúde'),
                                      ChoiceChipWidget(chipName: 'Educação'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data.length,
                                // ignore: missing_return
                                itemBuilder: (context, index) {
                                  if (snapshot.data[index].category.name ==
                                      "Meio Ambiente") {
                                    return CitationOnScreen(
                                      author: snapshot.data[index].author,
                                      text: snapshot.data[index].text,
                                    );
                                  } else {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                },
                              ),
                            ),
                          ],
                        );
                      }
                    }))
          ],
        ),
      ),
    );
  }
}

class CitationOnScreen extends StatelessWidget {
  final String author;
  final String text;

  const CitationOnScreen({
    Key key,
    this.author,
    this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Expanded(
              child: Container(
                width: 350.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade200,
                          spreadRadius: 5.0,
                          blurRadius: 5.0),
                    ]),
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          text,
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 16),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            author,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 80.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const <Widget>[
                              Icon(
                                Icons.content_copy,
                                color: Colors.grey,
                                size: 25.0,
                              ),
                              Icon(
                                Icons.share,
                                color: Colors.grey,
                                size: 25.0,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ChoiceChipWidget extends StatefulWidget {
  final String chipName;

  ChoiceChipWidget({Key key, this.chipName}) : super(key: key);

  @override
  _ChoiceChipWidgetState createState() => _ChoiceChipWidgetState();
}

class _ChoiceChipWidgetState extends State<ChoiceChipWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(widget.chipName),
      labelStyle: TextStyle(
        color: Colors.black,
        fontSize: 16.0,
      ),
      selected: _isSelected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      backgroundColor: Colors.white,
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
        });
      },
      selectedColor: Colors.blue,
    );
  }
}
