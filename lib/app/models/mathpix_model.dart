// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MathPixApiResponse {

  double? autoRotateConfidence;
  double? confidence;
  double? confidenceRate;
  bool? isHandwritten;
  bool? isPrinted;
  String? latexStyled;
  String? requestId;
  String? text;
  String? version;

  MathPixApiResponse({
    required this.autoRotateConfidence,
    required this.confidence,
    required this.confidenceRate,
    required this.isHandwritten,
    required this.isPrinted,
    required this.latexStyled,
    required this.requestId,
    required this.text,
    required this.version,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'auto_rotate_confidence': autoRotateConfidence,
      'confidence': confidence,
      'confidence_rate': confidenceRate,
      'is_handwritten': isHandwritten,
      'is_printed': isPrinted,
      'latex_styled': latexStyled,
      'request_id': requestId,
      'text': text,
      'version': version,
    };
  }

  factory MathPixApiResponse.fromMap(Map<String, dynamic> map) {
    return MathPixApiResponse(
      autoRotateConfidence: map['auto_rotate_confidence'] != null
          ? map['auto_rotate_confidence'] as double
          : null,
      confidence:
          map['confidence'] != null ? map['confidence'] as double : null,
      confidenceRate: map['confidence_rate'] != null
          ? map['confidence_rate'] as double
          : null,
      isHandwritten:
          map['is_handwritten'] != null ? map['is_handwritten'] as bool : null,
      isPrinted: map['is_printed'] != null ? map['is_printed'] as bool : null,
      latexStyled:
          map['latex_styled'] != null ? map['latex_styled'] as String : null,
      requestId: map['request_id'] != null ? map['request_id'] as String : null,
      text: map['text'] != null ? map['text'] as String : null,
      version: map['version'] != null ? map['version'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MathPixApiResponse.fromJson(String source) =>
      MathPixApiResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MathPixApiResponse(autoRotateConfidence: $autoRotateConfidence, confidence: $confidence, confidenceRate: $confidenceRate, isHandwritten: $isHandwritten, isPrinted: $isPrinted, latexStyled: $latexStyled, requestId: $requestId, text: $text, version: $version)';
  }
}
