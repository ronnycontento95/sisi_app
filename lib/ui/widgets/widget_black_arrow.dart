import 'package:flutter/material.dart';
import 'package:sisi_iot_app/ui/utils/global.dart';
import 'package:sisi_iot_app/ui/utils/global_palette.dart';

class WidgetBlackArrow extends StatelessWidget {
  final bool borderActive;
  final VoidCallback? callback;
  const WidgetBlackArrow({Key? key,this.borderActive=false,this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(callback!=null){
          callback!();
        }
        Navigator.of(context).pop();
      },
      child: Container(
        margin:const EdgeInsets.only(top: 10, bottom: 10,left: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: borderActive? Theme.of(context).primaryColor:Colors.transparent,
            style: BorderStyle.solid,
            width: 1,
          ),
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(50.0)),
          //boxShadow: <BoxShadow>[BoxShadow(color: Colors.black54, blurRadius: 5.0, offset: Offset(0.0, 0.75))],
        ),
        child: const Image(
          image: AssetImage("${Global.assetsIcons}arrow.png"),
          fit: BoxFit.contain,
          height: 25,
          width: 25,
          color: ColorsPalette.colorPrimary,
        ),
      ),
    );
  }
}
