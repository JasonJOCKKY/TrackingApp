import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController textController;
  final Function(String str) onSearch;
  final String hintText;

  SearchBar({this.textController, this.onSearch, this.hintText});

  @override
  State<StatefulWidget> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool _isTyping = false;
  String _currentValue = "";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: TextField(
            onTap: () => setState(() {
              _isTyping = true;
            }),
            onChanged: (str) => setState(() {}),
            onSubmitted: (str) => setState(() {
              _isTyping = false;
              FocusScope.of(context).unfocus();
              _currentValue = str;
              widget.onSearch(str);
            }),
            controller: widget.textController,
            textInputAction: TextInputAction.search,
            autocorrect: false,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              fillColor: Colors.grey[100],
              filled: true,
              hintText: widget.hintText,
              prefixIcon: Icon(Icons.search),
              suffixIcon: Visibility(
                visible: widget.textController.text.isNotEmpty,
                child: IconButton(
                  onPressed: () => widget.textController.clear(),
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
            visible: _isTyping,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: InkWell(
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
                onTap: () {
                  _cancel();
                },
              ),
            )),
      ],
    );
  }

  // Helper Method
  void _cancel() {
    FocusScope.of(context).unfocus();
    _isTyping = false;
    widget.textController.text = _currentValue;
  }
}
