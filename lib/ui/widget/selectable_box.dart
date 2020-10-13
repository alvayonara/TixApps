part of 'widgets.dart';

class SelectableBox extends StatelessWidget {
  // Is selected or not?
  final bool isSelected;
  // Can be selected or not? (Used in Choose Date and Choose Seats Page)
  final bool isEnabled;
  // Box width
  final double width;
  // Box height
  final double height;
  // Text inside Box
  final String text;
  // Define event when tap the Box
  final Function onTap;
  // Style of text inside Box
  final TextStyle textStyle;

  // All data set to OPTIONAL ({} syntax) EXCEPT text data
  SelectableBox(this.text,
      {this.isSelected = false,
      this.isEnabled = true,
      this.width = 144,
      this.height = 60,
      this.onTap,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: (!isEnabled)
              ? Color(0xFFE4E4E4)
              : isSelected
                  ? accentColor2
                  : Colors.transparent,
          border: Border.all(
            color: (!isEnabled)
                ? Color(0xFFE4E4E4)
                : isSelected
                    ? Colors.transparent
                    : Color(0xFFE4E4E4),
          ),
        ),
        child: Center(
          child: Text(
            text ?? "None",
            style: (textStyle ??
                blackTextFont.copyWith(
                    fontSize: 16, fontWeight: FontWeight.w400)),
          ),
        ),
      ),
    );
  }
}
