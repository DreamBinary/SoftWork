import 'package:account/app/theme/app_sizes.dart';
import 'package:account/res/assets_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTopBar extends StatefulWidget implements PreferredSizeWidget {
  final ImageProvider? backgroundImage;
  final Widget? leading;
  final Widget? middle;
  final Widget? trailing;
  final Color? backgroundColor;

  const MyTopBar({
    super.key,
    this.leading,
    this.middle,
    this.trailing,
    this.backgroundColor,
    this.backgroundImage,
  });

  @override
  State<MyTopBar> createState() => _MyTopBarState();

  @override
  Size get preferredSize => Size(double.infinity, 56.h);
}

class _MyTopBarState extends State<MyTopBar> {
  @override
  Widget build(BuildContext context) {
    var parentRoute = ModalRoute.of(context);
    var haveParent = (parentRoute?.canPop ?? false) ||
        (parentRoute?.impliesAppBarDismissal ?? false);
    return Container(
      decoration: BoxDecoration(
          color: widget.backgroundColor,
          image: widget.backgroundImage == null
              ? null
              : DecorationImage(
              image: widget.backgroundImage!, fit: BoxFit.fill)),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: NavigationToolbar(
              leading:
              widget.leading ?? (haveParent ? const MyBackButton() : null),
              middle: widget.middle,
              trailing: widget.trailing),
        ),
      ),
    );
  }
}

class MyBackButton extends StatelessWidget {
  const MyBackButton({super.key, this.color, this.onPressed});

  final Color? color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Material(
        color: Colors.white,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: IconButton(
          padding: const EdgeInsets.all(5),
          icon: Image.asset(AssetsRes.BACK,
              width: AppSizes.iconBtn, height: AppSizes.iconBtn),
          color: color ?? Colors.transparent,
          onPressed: () {
            if (onPressed != null) {
              onPressed!();
            } else {
              Navigator.maybePop(context);
            }
          },
        ),
      ),
    );
  }
}
