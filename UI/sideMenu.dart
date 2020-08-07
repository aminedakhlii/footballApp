import 'package:flutter/material.dart';
import 'constants.dart';
import 'dart:ui';
import 'favorites.dart';

class NavDrawer extends StatelessWidget {

  bool isSwitched = false ;

  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: ListView(

        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(

            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/darkwallpaper.jpg'))
            ),


            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.grey.withOpacity(0.0),
                  child: Text('الاعدادات' , style : titleTextWhite),
                ),
              ),
            ),
          ),

          ListTile(
            leading: Icon(Icons.input),
            title: Text('Welcome'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('فرقي المفضلة'),
            onTap: () => {Navigator.of(context).push(MaterialPageRoute(builder: (context) => Favorites()))},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                Switch(

                  value: isSwitched,
                  onChanged: (value){

                },),

                Icon(Icons.wb_incandescent , color: Colors.grey,),

                Text('الوضع الليلي' , style: menuTextGrey,),
              ],
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}