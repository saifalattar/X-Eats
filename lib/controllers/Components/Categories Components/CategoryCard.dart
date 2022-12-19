import 'package:flutter/material.dart';
import 'package:xeats/controllers/Components/Global%20Components/loading.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.image,
    required this.press,
    required this.category,
    required this.description,
  }) : super(key: key);

  final String image;
  final String description;
  final String category;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: width / 3,
        height: height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: width / 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: Loading(),
                          );
                        },
                        width: width / 3,
                        height: height / 3,
                        image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 255, 255, 255).withOpacity(0.15),
                      Color.fromARGB(255, 255, 255, 255).withOpacity(0.15),

                      // Color(0x0489cc).withOpacity(0.4),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: width / 15),
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                          color: Color(0x0489cc).withOpacity(1),
                        ),
                        children: [
                          TextSpan(
                            text: '$category',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: description,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
