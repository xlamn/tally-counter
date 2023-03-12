import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Slidable(
          key: Key(tallyGroup.title),
          endActionPane: ActionPane(
            extentRatio: 0.26,
            motion: const ScrollMotion(),
            children: [
              Builder(
                builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      Slidable.of(context)?.dismiss(
                        ResizeRequest(
                          const Duration(milliseconds: 250),
                          () => BlocProvider.of<TallyCounterCubit>(context).removeGroupFromCounters(tallyGroup),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: SizeConstants.small),
                      padding: const EdgeInsets.all(
                        SizeConstants.normalSmaller,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(context.isDarkMode ? 0.3 : 0.2),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(SizeConstants.normal),
                        child: FaIcon(
                          FontAwesomeIcons.trash,
                          size: SizeConstants.normal,
                          color: context.isDarkMode ? Colors.redAccent : Colors.red.withOpacity(0.8),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: SizeConstants.small),
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
                          tallyGroup.title.isNotEmpty ? tallyGroup.title : context.local.noName,
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
