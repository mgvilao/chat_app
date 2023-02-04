import 'package:chat_app/models/image_model.dart';
import 'package:chat_app/repository/image_repository.dart';
import 'package:flutter/material.dart';

class ImagePickerBody extends StatelessWidget {
  ImagePickerBody({
    super.key,
  });

  final _imageRepository = ImageRepository();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ImageModel>>(
        future: _imageRepository.getNetworkImages(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ImageModel>> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                itemCount: snapshot.data!.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
                ),
                itemBuilder: (context, index) {
                  return Image.network(snapshot.data![index].urlSmallSize);
                });
            //return Image.network(snapshot.data![0].urlSmallSize);
          }
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
