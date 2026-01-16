import 'dart:ui';

class InfoProgressCard {
  final String title;
  final String icons;
  final String mainValue;

  /// optional
  final String? caption;
  final double? progress;
  final List<ProgressSegment>? segments;

  /// UI control flags
  final bool showSlashWithCaption ; // /100
  final bool showCaptionBelow;     // 5000 below main value
  final bool showProgressPercent;  // % text on progress

  InfoProgressCard({
    required this.title,
    required this.icons,
    required this.mainValue,
    this.caption,
    this.progress,
    this.segments,
    this.showSlashWithCaption = false,
    this.showCaptionBelow = false,
    this.showProgressPercent = false,
  });
}

class ProgressSegment {
  final int flex;
  final Color color;

  const ProgressSegment({required this.flex, required this.color});
}

