import 'package:flutter/material.dart';
import 'package:toot_mart/core/utiles/size_config.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';

class AccountItem extends StatelessWidget {
  const AccountItem({Key? key,required this.text,required this.icon,required this.onTap})
      : super(key: key);
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon,size: SizeConfig.defaultSize!*3.5,),
              const HorizontalSpace(value: 1),
              Text(text,style: TextStyle(fontSize:SizeConfig.defaultSize!*1.5),),
            ],
          ),
          const Divider(thickness:1,color: Colors.grey,)

        ],
      ),
    );
  }
}
