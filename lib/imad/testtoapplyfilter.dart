import 'package:flutter/material.dart';

class StickyTextOnScroll extends StatefulWidget {
  @override
  _StickyTextOnScrollState createState() => _StickyTextOnScrollState();
}

class _StickyTextOnScrollState extends State<StickyTextOnScroll> {
  ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sticky Text Example')),
      body: Stack(
        children: [
          // Your scrollable content
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  height: 2000, // Large content to allow scrolling
                  color: Colors.grey[300],
                  child: Center(child: Text("Scroll Down")),
                ),
              ),
            ],
          ),
          
          // Sticky Text
          Positioned(
            bottom: _scrollOffset < 100 ? 100 : _scrollOffset, // Text becomes "sticky" after 100 pixels
            left: 20,
            child: Material(
              elevation: 4, // Adds shadow to make it stand out
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.blueAccent,
                child: Text(
                  "Sticky Text",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: StickyTextOnScroll(),
  ));
}
