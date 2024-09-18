import 'package:flutter/material.dart';

abstract class BaseCardWidget extends StatelessWidget {
  const BaseCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onCardTap(context);
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context)
                  .colorScheme
                  .onInverseSurface
                  .withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildImage(context),
            buildTitle(context),
            buildDescription(context),
            buildPrice(context),
            Spacer(),
            buildActions(context),
          ],
        ),
      ),
    );
  }

  void onCardTap(BuildContext context);

  Widget buildImage(BuildContext context);

  Widget buildTitle(BuildContext context);

  Widget buildDescription(BuildContext context);

  Widget buildPrice(BuildContext context);

  Widget buildActions(BuildContext context);
}
