import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';
import '../controllers/location_controller.dart';

class PlaceSuggestion {
  const PlaceSuggestion({
    required this.placeId,
    required this.fullText,
    required this.mainText,
    required this.secondaryText,
  });

  final String placeId;
  final String fullText;
  final String mainText;
  final String secondaryText;
}

/// Address text field that shows Google Places suggestions while typing.
/// Calls [onPlaceSelected] with the full address and coordinates when the
/// user picks a suggestion, and [onManualEdit] whenever the user types, so
/// coordinates from an earlier pick are not kept for hand-typed text.
class AddressAutocompleteField extends StatefulWidget {
  const AddressAutocompleteField({
    super.key,
    required this.controller,
    required this.onPlaceSelected,
    required this.onManualEdit,
    this.hint = 'Address',
  });

  final TextEditingController controller;
  final void Function(String address, double lat, double lng) onPlaceSelected;
  final VoidCallback onManualEdit;
  final String hint;

  @override
  State<AddressAutocompleteField> createState() =>
      _AddressAutocompleteFieldState();
}

class _AddressAutocompleteFieldState extends State<AddressAutocompleteField> {
  static const _debounce = Duration(milliseconds: 300);

  final _focusNode = FocusNode();
  int _requestId = 0;
  String? _lastSelected;

  // Groups autocomplete + details calls into one billed session.
  String _sessionToken = _newSessionToken();

  static String _newSessionToken() {
    final rnd = Random.secure();
    return List.generate(32, (_) => rnd.nextInt(16).toRadixString(16)).join();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Future<Iterable<PlaceSuggestion>> _search(TextEditingValue value) async {
    final query = value.text.trim();
    final requestId = ++_requestId;
    if (query.length < 3 || query == _lastSelected) return const [];

    await Future.delayed(_debounce);
    if (requestId != _requestId) return const []; // user kept typing

    try {
      final response = await http.get(
        Uri.https('maps.googleapis.com', '/maps/api/place/autocomplete/json', {
          'input': query,
          'sessiontoken': _sessionToken,
          'key': LocationController.googleApiKey,
        }),
      );
      if (requestId != _requestId) return const [];

      final data = jsonDecode(response.body);
      if (data['status'] != 'OK') {
        if (data['status'] != 'ZERO_RESULTS') {
          debugPrint('Places autocomplete failed: ${response.body}');
        }
        return const [];
      }

      return (data['predictions'] as List)
          .map((p) => PlaceSuggestion(
                placeId: p['place_id'],
                fullText: p['description'] ?? '',
                mainText: p['structured_formatting']?['main_text'] ??
                    p['description'] ??
                    '',
                secondaryText:
                    p['structured_formatting']?['secondary_text'] ?? '',
              ))
          .toList();
    } catch (e) {
      debugPrint('Places autocomplete error: $e');
      return const [];
    }
  }

  Future<void> _onSelected(PlaceSuggestion suggestion) async {
    _lastSelected = suggestion.fullText;
    _focusNode.unfocus();

    try {
      final response = await http.get(
        Uri.https('maps.googleapis.com', '/maps/api/place/details/json', {
          'place_id': suggestion.placeId,
          'fields': 'geometry/location',
          'sessiontoken': _sessionToken,
          'key': LocationController.googleApiKey,
        }),
      );

      final data = jsonDecode(response.body);
      if (data['status'] != 'OK') {
        debugPrint('Place details failed: ${response.body}');
        return;
      }

      // Keep the suggestion text (it includes place names like
      // "Times Square", which formatted_address drops).
      final location = data['result']['geometry']['location'];
      widget.onPlaceSelected(
        suggestion.fullText,
        (location['lat'] as num).toDouble(),
        (location['lng'] as num).toDouble(),
      );
    } catch (e) {
      debugPrint('Place details error: $e');
    } finally {
      _sessionToken = _newSessionToken();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => RawAutocomplete<PlaceSuggestion>(
        textEditingController: widget.controller,
        focusNode: _focusNode,
        displayStringForOption: (s) => s.fullText,
        optionsBuilder: _search,
        onSelected: _onSelected,
        fieldViewBuilder: (context, controller, focusNode, onSubmitted) =>
            TextField(
          controller: controller,
          focusNode: focusNode,
          // Fires only for user typing, not for text set by a selection.
          onChanged: (_) => widget.onManualEdit(),
          cursorColor: greenColor,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: TextInputType.streetAddress,
          decoration: InputDecoration(
            hintText: widget.hint,
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.zero,
            hintStyle: TextStyle(
              fontFamily: 'WorkSans',
              fontWeight: FontWeight.w400,
              fontSize: 15.sp,
            ),
          ),
          style: TextStyle(
            fontFamily: 'WorkSans',
            fontWeight: FontWeight.w400,
            fontSize: 15.sp,
          ),
        ),
        optionsViewBuilder: (context, onSelected, options) => Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(top: 1.h),
            child: Material(
              color: whiteColor,
              elevation: 6,
              shadowColor: Colors.black26,
              borderRadius: BorderRadius.circular(12.sp),
              clipBehavior: Clip.antiAlias,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: constraints.maxWidth,
                  maxHeight: 35.h,
                ),
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 0.5.h),
                  shrinkWrap: true,
                  itemCount: options.length,
                  separatorBuilder: (_, __) => Divider(
                    height: 1,
                    indent: 12.w,
                    color: friendTextfieldColor,
                  ),
                  itemBuilder: (context, index) {
                    final s = options.elementAt(index);
                    return InkWell(
                      onTap: () => onSelected(s),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.w,
                          vertical: 1.2.h,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.place_outlined,
                              size: 17.sp,
                              color: greenColor,
                            ),
                            SizedBox(width: 3.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customText(
                                    text: s.mainText,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: lightBlackColor,
                                    maxLines: 1,
                                    overFlow: TextOverflow.ellipsis,
                                  ),
                                  if (s.secondaryText.isNotEmpty)
                                    customText(
                                      text: s.secondaryText,
                                      fontSize: 12.sp,
                                      color: greyTextColor,
                                      maxLines: 1,
                                      overFlow: TextOverflow.ellipsis,
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
