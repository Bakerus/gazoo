import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gazoo/app/core/utils/extensions.dart';
import '../../data/models/bottle_lot.dart';
import '../design/colors.dart';
import '../design/images.dart';
import '../design/theme.dart';

class BottlesList extends StatelessWidget {
  final List<BottleLot> bottlesList;
  const BottlesList({super.key, required this.bottlesList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: bottlesList.length,
          itemBuilder: ((context, index) {
            if ((index != bottlesList.length - 1) && (index != 0)) {
              // les cards du milieiu
              if ((bottlesList[index].brand.brandName ==
                      bottlesList[index + 1].brand.brandName) &&
                  ((bottlesList[index].brand.brandName !=
                      bottlesList[index - 1].brand.brandName))) {
                return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: displayCombinedCard(index: index, context: context));
              } else if ((bottlesList[index].brand.brandName !=
                      bottlesList[index + 1].brand.brandName) &&
                  ((bottlesList[index].brand.brandName !=
                      bottlesList[index - 1].brand.brandName))) {
                return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: displaySingleCard(index: index, context: context));
              } else {
                return const SizedBox.shrink();
              }
            } else if (index == 0 && bottlesList.length - 1 != 0) {
              if ((bottlesList[index].brand.brandName ==
                  bottlesList[index + 1].brand.brandName)) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: displayCombinedCard(index: index, context: context),
                );
              } else {
                return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: displaySingleCard(index: index, context: context));
              }
            } else if (index == 0 && bottlesList.length - 1 == 0) {
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: displaySingleCard(index: index, context: context));
            } else {
              if (bottlesList[index].brand.brandName !=
                  bottlesList[index - 1].brand.brandName) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: displaySingleCard(index: index, context: context),
                );
              } else {
                return const SizedBox.shrink();
              }
            }
          })),
    );
  }

  Widget displaySingleCard(
      {required int index, required BuildContext context}) {
    return Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Column(
            children: [
              ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0)),
                  child: CachedNetworkImage(
                      imageUrl: bottlesList[index].brand.bottleImage,
                      placeholder: (context, url) => const SizedBox(
                            width: 10,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColors.brown,
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                      errorWidget: (context, url, error) => const Icon(
                            Icons.error_outline_sharp,
                            color: AppColors.red,
                            size: 25,
                          ),
                      fit: BoxFit.cover,
                      width: 60.0.wp,
                      height: 22.0.hp)),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      bottlesList[index].brand.brandName,
                      style: AppTheme.ligthTheme.textTheme.titleSmall,
                    ),
                    Image.asset(AppImages.prix,
                        fit: BoxFit.cover, width: 30, height: 30),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                "${bottlesList[index].weight.toString()} kg",
                                style: AppTheme.ligthTheme.textTheme.bodyLarge,
                              ),
                              Text(bottlesList[index].price.toString(),
                                  style:
                                      AppTheme.ligthTheme.textTheme.titleLarge),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget displayCombinedCard(
      {required int index, required BuildContext context}) {
    return Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Column(
            children: [
              ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0)),
                  child: CachedNetworkImage(
                      imageUrl: bottlesList[index].brand.bottleImage,
                      placeholder: (context, url) => const SizedBox(
                            width: 10,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColors.brown,
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                      errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            color: AppColors.red,
                            size: 25,
                          ),
                      fit: BoxFit.cover,
                      width: 60.0.wp,
                      height: 22.0.hp)),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      bottlesList[index].brand.brandName,
                      style: AppTheme.ligthTheme.textTheme.titleSmall,
                    ),
                    Image.asset(AppImages.prix,
                        fit: BoxFit.cover, width: 30, height: 30),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                "${bottlesList[index].weight.toString()} kg",
                                style: AppTheme.ligthTheme.textTheme.bodyLarge,
                              ),
                              Text(bottlesList[index].price.toString(),
                                  style:
                                      AppTheme.ligthTheme.textTheme.titleLarge),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "${bottlesList[index + 1].weight.toString()} kg",
                                style: AppTheme.ligthTheme.textTheme.bodyLarge,
                              ),
                              Text(
                                bottlesList[index + 1].price.toString(),
                                style: AppTheme.ligthTheme.textTheme.titleLarge,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
