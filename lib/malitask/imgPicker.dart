import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//  image_picker: ^0.6.7+4


class ImageViewer extends StatefulWidget {
  @override
  _ImageViewerState createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  //global list img_list
  List<File> img_list=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(icon: Icon(Icons.menu), onPressed: (){
                _showDialog(context);
          }),
        
      ),
      body:_imgPicker(context),
            
          );
        }
        _showDialog(context){
          showDialog(context: context,builder: (BuildContext context){
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              title: Text("Select from",style: TextStyle(color: Colors.grey,fontSize: 20,fontWeight:FontWeight.bold ),),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title:Text("Camera",style: TextStyle(color: Colors.grey,fontSize: 18,fontWeight:FontWeight.bold ),),
                    trailing: Icon(Icons.camera,color: Colors.grey,size: 20,),
                    onTap: (){
                      _pickImage(ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title:Text("Gallery",style: TextStyle(color: Colors.grey,fontSize: 18,fontWeight:FontWeight.bold ),),
                    trailing: Icon(Icons.photo_album,color: Colors.grey,size: 20,),
                    onTap: (){
                      _pickImage(ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            );
          });
        }
       
        Widget _viewImgList(){
          if(img_list.length>0){
          return Container(
            margin: EdgeInsets.all(10),
              child:GridView.builder(scrollDirection: Axis.vertical,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),itemCount: img_list.length,
               itemBuilder: (context,index){
                return InkWell(onDoubleTap: (){
                  setState(() {
                    img_list.removeAt(index);
                  });
                },child: Container(child: Image(image: FileImage(img_list[index]),fit: BoxFit.fill,),),);
              }) ,
            );}else{
              return Center(child:Text("no data",style: TextStyle(fontSize: 15),) ,);
            }
        }
        
        _pickImage(ImageSource source)  async {
          var _picked= await ImagePicker.pickImage(source: source);
          if(_picked!=null)
          setState(() {
             img_list.add(_picked);
          });
         
      
        }
      
       Widget _imgPicker(BuildContext context) {
         return Column(
           children: [
             Container(
               height: 40,
               width: MediaQuery.of(context).size.width,
               child:RaisedButton(onPressed: (){
                 _showDialog(context);
               },color: Colors.white,elevation: 5,
               child: Text("أختر صوره",style: TextStyle(fontSize: 15),),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),),
             ),
             _viewImgList()
           ],
         );
       }
  
}
