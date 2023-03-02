import 'package:flutter/material.dart';
import 'package:sneaker_head/models/model.dart';
import 'package:sneaker_head/size_config.dart';

class ChangeProfile extends StatefulWidget {
  const ChangeProfile({
    Key? key,
    required this.p,
  }) : super(key: key);

  final PersonalDetails? p;

  @override
  State<ChangeProfile> createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: CircleAvatar(
            radius: 15.0 * SizeConfig.heightMultiplier,
            backgroundImage: NetworkImage(widget.p?.image??""),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 26.0*SizeConfig.widthMultiplier,
          child: Container(
            height: 5.0*SizeConfig.heightMultiplier,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
            child: IconButton(
              icon: const Icon(Icons.photo_camera,color: Colors.black,),
              onPressed: (){},
            ),
          ) 
          )
      ],
    );
  }
}