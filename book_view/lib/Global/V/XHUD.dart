import 'package:flutter/material.dart';
import 'dart:async';

class XHud extends StatefulWidget {
  final Color backgroundColor;
  final Color color;
  final Color containerColor;
  final double borderRadius;
  final bool loading;
  XHudState state;

  XHud(
      {Key key,
        this.backgroundColor = Colors.black12,
        this.color = Colors.white,
        this.containerColor = Colors.black26,
        this.borderRadius = 5.0,
        this.loading = true})
      : super(key: key){
    state = new XHudState();
  }

  @override
  XHudState createState() {
    return state;
  }
}

class XHudState extends State<XHud> {
  bool _visible = true;
  bool _isSuccess = false;
  String _text;

  @override
  void initState() {
    super.initState();

    _visible = widget.loading;
    this._visible = false;
  }

  void dismiss() {
    if(widget == null){
      return;
    }
    setState(() {
      this._visible = false;
    });
  }

  void showWithString(String text) {
    if(widget == null){
      return;
    }
    _isSuccess = false;
    _text = text;
    setState(() {
      this._visible = true;
    });
  }
  void showSuccessWithString(String text) {
    if(widget == null){
      return;
    }
    _isSuccess = true;
    _text = text;
    setState(() {
      this._visible = true;
    });
    Future.delayed(const Duration(milliseconds: 2000))
        .then((val) {
          dismiss();
    });
  }
  void show() {
    _text = "";
    if(widget == null){
      return;
    }
    _isSuccess = false;
    setState(() {
      this._visible = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (_visible) {
      return new Scaffold(
          backgroundColor: widget.backgroundColor,
          body: new Stack(
            children: <Widget>[
              new Center(
                child: new Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: new BoxDecoration(
                      color: widget.containerColor,
                      borderRadius: new BorderRadius.all(
                          new Radius.circular(widget.borderRadius))),
                ),
              ),
              new Center(
                child: _getCenterContent(),
              )
            ],
          ));
    } else {
      return new Container();
    }
  }

  Widget _getCenterContent() {
    if (_text == null || _text.isEmpty) {
      return _getCircularProgress();
    }

    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _getCircularProgress(),
          new Container(
            width: 90.0,
            margin: const EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 0.0),
            child: new Text(
              _text,
              textAlign: TextAlign.center,
              style: new TextStyle(color: widget.color,),
            ),
          )
        ],
      ),
    );
  }

  Widget _getCircularProgress() {
    if(_isSuccess){
      return Icon(Icons.check,color: Colors.lightGreenAccent,size: 60.0,);
    }else{
      return new CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation(widget.color));
    }

  }
}