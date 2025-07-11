import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tally_counter/enums/enums.dart';

import '../../constants/constants.dart';
import '../../cubits/cubits.dart';
import '../../extensions/extensions.dart';

class TallyGroupSummaryItem extends StatelessWidget {

  const TallyGroupSummaryItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: _GroupSummaryContainer(
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: SizeConstants.xSmall,
                              ),
                              child: Text(
                                "${context.local.all} ${context.local.counters}".toCapitalized(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const FaIcon(
                              FontAwesomeIcons.globe,
                              color: Colors.white,
                            ),
                          ],
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
      Pages.tallyCountersOverviewPage.value,
      duration: const Duration(milliseconds: 250),
      curve: Curves.linear,
    );
  }
}

class _GroupSummaryContainer extends StatelessWidget {
  
  final Widget child;

  const _GroupSummaryContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: SizeConstants.small,
        bottom: SizeConstants.normal,
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.all(SizeConstants.normal),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.1),
            blurRadius: 5,
            offset: const Offset(
              0,
              SizeConstants.small,
            ),
          ),
        ],
        gradient: const LinearGradient(
          colors: [
            Color(0xFFfc506e),
            Color(0xFFee821a),
          ],
        ),
        borderRadius: BorderRadius.circular(
          RadiusConstants.large,
        ),
      ),
      child: child,
    );
  }
}
