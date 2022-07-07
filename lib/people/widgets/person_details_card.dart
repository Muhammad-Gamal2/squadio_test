import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people_repository/people_repository.dart';
import 'package:squadio_test/helpers/helpers.dart';
import 'package:squadio_test/people/people.dart';

class PersonDetailsCard extends StatelessWidget {
  const PersonDetailsCard({Key? key, required this.person}) : super(key: key);

  final Person person;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: person.profilePath != null
                  ? NetworkImage(
                      ImageWrap(imageUrl: person.profilePath).wrapImage(),
                    )
                  : null,
              backgroundColor: Colors.grey,
              radius: 50,
            ),
            const SizedBox(height: 8),
            Text(
              person.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              person.birthday ?? '',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              person.biography ?? '',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            BlocBuilder<PersonImagesCubit, PersonImagesState>(
              builder: (context, state) {
                if (state is PersonImagesLoadSuccess) {
                  return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    childAspectRatio: 1.0,
                    children: state.images.map((image) {
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImageView(image: image)),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: Hero(
                            tag: image,
                            child: Image.network(
                              ImageWrap(imageUrl: image).wrapImage(),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                } else if (state is PersonImagesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
