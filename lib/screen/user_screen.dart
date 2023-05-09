import 'package:cached_network_image/cached_network_image.dart';
import 'package:challenge/model/exhibit.dart';
import 'package:challenge/provider/exhibits_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ExhibitsLoader>().fetchData;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<ExhibitsLoader>().fetchData;
        },
        child: Center(
          child: Consumer<ExhibitsLoader>(
            builder: (context, value, child) {
              return value.list.isEmpty && !value.error
                  ? const CircularProgressIndicator()
                  : value.error
                      ? Text(
                          "Oops , something went wrong ${value.errorMessage}",
                          textAlign: TextAlign.center,
                        )
                      : ListView.builder(
                          itemCount: value.list.length,
                          itemBuilder: (context, index) {
                            return PhoneCard(phone: value.list[index]);
                          },
                        );
            },
          ),
        ),
      ),
    );
  }
}

class PhoneCard extends StatelessWidget {
  const PhoneCard({Key? key, required this.phone}) : super(key: key);
  final Exhibit phone;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(phone.title),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  itemCount: phone.images.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                      _buildImage(image: phone.images[index]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage({required String image}) => CachedNetworkImage(
        imageUrl: image,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(image), fit: BoxFit.cover)),
          margin: const EdgeInsets.all(12),
          height: 100,
          width: image ==
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5cv-olMz3XKQNhQP4SpwiwqtiDreaBlpESHdCDc6Jm5GjHzRsHcxXrqAI"
              ? 50 : 200,
        ),
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
}
