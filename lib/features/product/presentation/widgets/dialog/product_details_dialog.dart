import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pcnc/core/application_manager/dialog_manager.dart';
import 'package:pcnc/core/extension/sized_box_ext.dart';
import 'package:pcnc/features/product/domain/entity/product.dart';
import 'package:pcnc/generated/assets.dart';
import 'package:pcnc/presentation/dialog/base_dialog.dart';
import 'package:pcnc/presentation/dialog/image_dialog.dart';
import 'package:pcnc/presentation/style/color_palette.dart';
import 'package:pcnc/presentation/style/font_sizes.dart';
import 'package:pcnc/presentation/widget/images/card_image.dart';
import 'package:pcnc/presentation/widget/text_widget/custom_text.dart';

class ProductDetailsDialog extends BaseDialog {
  final Product product;

  const ProductDetailsDialog({
    required this.product,
  });

  @override
  Widget buildContent(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9.w,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.6.h,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.images.isNotEmpty)
              GestureDetector(
                onTap: () {
                  DialogManager.showDialogWidget(
                    context,
                    ImageDialog(imageUrl: product.images.first),
                  );
                },
                child: CardImage(
                  imageUrl: product.images.first,
                  width: double.infinity,
                  height: 200.h,
                  errorImage: Assets.imageNotAvailable,
                  isCircular: false,
                ),
              ),
            10.height,
            CustomText(
              text: product.title,
              fontSize: textXExtraLarge.sp,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.visible,
            ),
            10.height,
            CustomText(
              text: product.description,
              fontSize: textmMedium.sp,
              overflow: TextOverflow.visible,
            ),
            10.height,
            CustomText(
              text: '\$${product.price}',
              fontSize: textXExtraLarge.sp,
              fontWeight: FontWeight.bold,
              color: klightblueColor,
            ),
          ],
        ),
      ),
    );
  }
}
