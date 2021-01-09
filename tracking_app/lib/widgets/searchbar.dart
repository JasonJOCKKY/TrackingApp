import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController textController;
  final Function(String str) onSearch;
  final String hintText;

  SearchBar({@required this.textController, this.onSearch, this.hintText});

  @override
  State<StatefulWidget> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String _currentValue = "";
  FocusNode _focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: TextField(
            onChanged: (str) => setState(() {}),
            onSubmitted: (str) => setState(() {
              _currentValue = str;
              widget.onSearch(str);
            }),
            focusNode: _focus,
            controller: widget.textController,
            textInputAction: TextInputAction.search,
            autocorrect: false,
            autofocus: false,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              fillColor: Colors.grey[100],
              filled: true,
              hintText: widget.hintText,
              prefixIcon: Icon(Icons.search),
              suffixIcon: Visibility(
                visible: widget.textController.text.isNotEmpty,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      widget.textController.clear();
                    });
                  },
                  icon: Icon(
                    Icons.cancel,
                  ),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Visibility(
          visible: _focus.hasFocus,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: InkWell(
              // Cencel
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
              onTap: () {
                setState(() {
                  if (_focus.hasFocus) {
                    _focus.unfocus();
                  }
                  widget.textController.text = _currentValue;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
