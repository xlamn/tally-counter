import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tally_counter/enums/enums.dart';

import '../../constants/constants.dart';
import '../../cubits/cubits.dart';
import '../../extensions/extensions.dart';

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
                            Text(
                              context.local.all,
                              style: const TextStyle(
                                fontSize: 24,
                                letterSpacing: 1,
                                color: Colors.white,
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
  const _GroupSummaryContainer({Key? key, required this.child}) : super(key: key);

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
            color: Theme.of(context).shadowColor.withOpacity(0.2),
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
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: child,
    );
  }
}
