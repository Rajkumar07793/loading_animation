library loading_animation;

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  final Tween<double> alignTween;
  final Tween<double> rotationTween;
  final Tween<double> sizeTween;
  final Curve curve;
  final Widget child;
  Loading({Key key, this.alignTween,this.rotationTween, this.sizeTween, this.curve, this.child}):super(key: key);
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin{
  AnimationController animationController;
  Animation<double> animation;
  Animation<double> animation1;
  Animation<double> animation2;

  @override
  void initState() {
    super.initState();
    animate();
  }

  animate(){
    animationController  = AnimationController(duration: Duration(seconds: 2),vsync: this);
    CurvedAnimation curve = CurvedAnimation(parent: animationController, curve: widget.curve??Curves.bounceIn);
    animation = (widget.sizeTween??Tween<double>(begin: 0,end: 100)).animate(curve)..addListener(() {update();});
    animation1 = (widget.alignTween??Tween<double>(begin: 1,end: -1)).animate(curve)..addListener(() {update();});
    animation2 = (widget.rotationTween??Tween<double>(begin: 0,end: 20)).animate(curve)..addListener(() {update();});
    animationController.repeat(reverse: true);
  }

  update(){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(animation1.value,animation1.value),
      child: Transform.rotate(
        angle: animation2.value,
        child: widget.child??Container(
          height: animation.value,
          width: animation.value,
          // color: Colors.greenAccent,
          child: FlutterLogo(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
