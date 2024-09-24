import 'package:flutter/material.dart';
import 'package:foods_app/common/theme.dart';
import 'package:foods_app/features/food_search/food_search.dart';
import 'package:foods_app/widgets/reusable_text.dart';

/// A custom [SliverAppBar] that can display either a [titleString] or a
/// [ReusableTextField] for searching, in the title property
/// of the [SliverAppBar].
///
/// This widget enforces that either a [titleString] is provided, or both
/// [onClearSearch] and [textFieldKey] are provided. Providing a [titleString]
/// will display the title in the app bar. Otherwise, a [ReusableTextField]
/// will be displayed, along with a clear button and a  [FoodResultsCountBadge].
class CustomSliverAppBar extends StatelessWidget {
  /// Creates a [CustomSliverAppBar].
  ///
  /// Provide either a [titleString] or [textFieldKey] and [onClearSearch].
  const CustomSliverAppBar({
    this.onClearSearch,
    this.textFieldKey,
    this.titleString,
    super.key,
  }) : assert(
          (titleString != null &&
                  onClearSearch == null &&
                  textFieldKey == null) ||
              (titleString == null &&
                  onClearSearch != null &&
                  textFieldKey != null),
          '''
                Either titleString must be provided, or both onClearSearch and
                  textFieldKey must be provided.
          ''',
        );

  /// The global key of the [ReusableTextField] used for searching.
  ///
  /// This is only used if no [titleString] is provided.
  final GlobalKey<ReusableTextFieldState>? textFieldKey;

  /// A callback that is called when the clear button is pressed.
  ///
  /// This is only used if no [titleString] is provided.
  final VoidCallback? onClearSearch;

  /// The title to display in the app bar.
  ///
  /// If this is provided, [onClearSearch] and [textFieldKey] must be null.
  final String? titleString;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      surfaceTintColor: AppColorsExtension.of(context).surfaceTint,
      actions: titleString == null
          ? [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconButton(
                  onPressed: onClearSearch,
                  icon: const Icon(Icons.clear_outlined),
                ),
              ),
              const FoodResultsCountBadge(),
            ]
          : null,
      floating: true,
      title: titleString != null
          ? Text(titleString!)
          : ReusableTextField(
              key: textFieldKey,
            ),
      pinned: true,
    );
  }
}


// class MySliverAppBar extends StatefulWidget {
//   // ... (rest of your existing properties)

//   @override
//   _MySliverAppBarState createState() => _MySliverAppBarState();
// }

// class _MySliverAppBarState extends State<MySliverAppBar> {
//   final ScrollController _scrollController = ScrollController();
//   bool _showHiddenText = false;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_scrollListener);
//   }

//   @override
//   void dispose() {
//     _scrollController.removeListener(_scrollListener);
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _scrollListener() {
//     // Check if ReusableTextField is visible AND we're scrolling down
//     if (widget.titleString == null &&
//         _scrollController.position.userScrollDirection == ScrollDirection.reverse &&
//         !_showHiddenText) {
//       setState(() => _showHiddenText = true);
//     } else if (_showHiddenText) {
//       setState(() => _showHiddenText = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SliverAppBar(
//       // ... (rest of your existing SliverAppBar properties)

//       flexibleSpace: LayoutBuilder(
//         builder: (context, constraints) {
//           final expandRatio = (constraints.maxHeight - kToolbarHeight) / (150 - kToolbarHeight);
//           return FlexibleSpaceBar(
//             collapseMode: CollapseMode.pin,
//             background: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 widget.titleString != null
//                     ? Text(widget.titleString!)
//                     : ReusableTextField(
//                         key: widget.textFieldKey,
//                       ),
//                 Visibility(
//                   visible: _showHiddenText && widget.titleString == null, // Only show if ReusableTextField is visible
//                   child: Opacity(
//                     opacity: expandRatio,
//                     child: const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }