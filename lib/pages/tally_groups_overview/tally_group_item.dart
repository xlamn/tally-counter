import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import '../../cubits/cubits.dart';
import '../../extensions/extensions.dart';
import '../../models/models.dart';

class TallyGroupItem extends StatelessWidget {
  final TallyGroup tallyGroup;

  const TallyGroupItem({
    Key? key,
    required this.tallyGroup,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.all(SizeConstants.small),
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.all(SizeConstants.large),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: SizeConstants.xxSmall,
                      horizontal: SizeConstants.small,
                    ),
                    child: Text(
                      tallyGroup.title?.isNotEmpty ?? false ? tallyGroup.title! : context.local.noName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).textTheme.headlineMedium!.color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () => _onTallyGroupTap(context),
    );
  }

  void _onTallyGroupTap(BuildContext context) {
    BlocProvider.of<TallyGroupCubit>(context).switchGroup(selected: tallyGroup);
    PageConstants.pageController.animateToPage(
      PageConstants.tallyCountersOverviewPage,
      duration: const Duration(milliseconds: 250),
      curve: Curves.linear,
    );
  }
}
