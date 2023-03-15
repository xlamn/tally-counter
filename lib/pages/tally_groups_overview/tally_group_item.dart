import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tally_counter/enums/enums.dart';

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
        width: MediaQuery.of(context).size.width * 0.85,
        child: _DeleteSlide(
          onTap: (context) => Slidable.of(context)?.dismiss(
            ResizeRequest(
              const Duration(milliseconds: 250),
              () => BlocProvider.of<TallyCounterCubit>(context).removeGroupFromCounters(tallyGroup),
            ),
          ),
          child: _GroupContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _GroupInfo(tallyGroup: tallyGroup),
                const FaIcon(FontAwesomeIcons.arrowRightLong),
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
      Pages.tallyCountersOverviewPage.value,
      duration: const Duration(milliseconds: 250),
      curve: Curves.linear,
    );
  }
}

class _GroupContainer extends StatelessWidget {
  final Widget child;

  const _GroupContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: SizeConstants.small),
        padding: const EdgeInsets.all(SizeConstants.large),
        decoration: BoxDecoration(
          color: context.isDarkMode ? Colors.grey[600] : Colors.grey[100],
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(
                0,
                SizeConstants.small,
              ),
            ),
          ],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: child);
  }
}

class _GroupInfo extends StatelessWidget {
  final TallyGroup tallyGroup;
  const _GroupInfo({Key? key, required this.tallyGroup}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tallyCounterCubit = BlocProvider.of<TallyCounterCubit>(context);

    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textTheme.headlineMedium!.color!,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: SizeConstants.xxSmall,
              horizontal: SizeConstants.small,
            ),
            child: Text(
              "${context.local.counters}: ${tallyCounterCubit.getCountersFromGroup(tallyGroup: tallyGroup).length}",
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).textTheme.headlineSmall!.color!.withOpacity(0.8),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _DeleteSlide extends StatelessWidget {
  final Widget child;
  final Function(BuildContext) onTap;
  const _DeleteSlide({Key? key, required this.child, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(child.hashCode.toString()),
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const ScrollMotion(),
        children: [
          Builder(
            builder: (context) {
              return GestureDetector(
                onTap: () => onTap(context),
                child: Container(
                  margin: const EdgeInsets.only(left: SizeConstants.small),
                  padding: const EdgeInsets.symmetric(
                    horizontal: SizeConstants.normalSmaller,
                    vertical: SizeConstants.large,
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
      child: child,
    );
  }
}
