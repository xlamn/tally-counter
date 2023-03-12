import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import '../../cubits/cubits.dart';

class TallyGroupSummaryItem extends StatelessWidget {
  const TallyGroupSummaryItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Container(
            margin: const EdgeInsets.only(
              top: SizeConstants.small,
              bottom: SizeConstants.xLarge,
            ),
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.all(SizeConstants.normal),
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
                        child: Center(
                          child: Text(
                            "ALL",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).textTheme.headlineMedium!.color,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          onTap: () => _onSummaryListItemTap(context),
        ),
      ],
    );
  }

  void _onSummaryListItemTap(BuildContext context) {
    BlocProvider.of<TallyGroupCubit>(context).switchGroup();
    PageConstants.pageController.animateToPage(
      PageConstants.tallyCountersOverviewPage,
      duration: const Duration(milliseconds: 250),
      curve: Curves.linear,
    );
  }
}
