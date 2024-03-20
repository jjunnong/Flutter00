import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'CatService.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('좋아요한 사진들'),
      ),
      body: Consumer<CatService>(
        builder: (context, catService, child) {
          // 좋아요한 사진들이 없는 경우
          if (catService.favoriteCatImages.isEmpty) {
            return Center(
              child: Text('좋아요한 사진이 없습니다.'),
            );
          }

          // 좋아요한 사진들을 그리드 형태로 표시
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            padding: EdgeInsets.all(8),
            itemCount: catService.favoriteCatImages.length,
            itemBuilder: (context, index) {
              String catImage = catService.favoriteCatImages[index];
              return GestureDetector(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        catImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
                onTap: () {
                  // 이미지 클릭시 아무 동작하지 않음
                },
              );
            },
          );
        },
      ),
    );
  }
}
