import 'package:flutter/material.dart';

import '../../data/models/bottle_lot.dart';
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5.0,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0)),
              child: Image.network(
                bottlesList[index].brand.bottleImage,
                fit: BoxFit.cover,
                width: 236,
                height: 156,
              ),
            ),
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
                              bottlesList[index].weight.toString(),
                              style: AppTheme.ligthTheme.textTheme.bodyLarge,
                            ),
                            Text(bottlesList[index].price.toString(),
                                style: AppTheme.ligthTheme.textTheme.titleLarge),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget displayCombinedCard(
      {required int index, required BuildContext context}) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5.0,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0)),
              child: Image.network(
                bottlesList[index].brand.bottleImage,
                fit: BoxFit.cover,
                width: 236,
                height: 156,
              ),
            ),
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
                              bottlesList[index].weight.toString(),
                              style: AppTheme.ligthTheme.textTheme.bodyLarge,
                            ),
                            Text(bottlesList[index].price.toString(),
                                style: AppTheme.ligthTheme.textTheme.titleLarge),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              bottlesList[index + 1].weight.toString(),
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
        ));
  }
}
