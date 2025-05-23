import 'package:equatable/equatable.dart';

class DetailedEntry extends Equatable {
  final String name;
  final double value;
  final double referenceValue;
  final double weight;
  final double costPerUnit;
  final double answer;
  final String subSectionName;
  final String sectionName;

  /// impactOnFormula =
  ///   ((Entry weight / total weight of entries in subsection)
  ///     / total weight of subsections in section)
  ///       / total weight of sections in formula
  final double impactOnFormula;

  const DetailedEntry({
    required this.name,
    required this.value,
    required this.referenceValue,
    required this.weight,
    required this.costPerUnit,
    required this.answer,
    required this.subSectionName,
    required this.sectionName,
    required this.impactOnFormula,
  });

  DetailedEntry copyWith({required double newValue}) {
    final double newAnswer = newValue / referenceValue;
    return DetailedEntry(
      name: name,
      value: newValue,
      referenceValue: referenceValue,
      weight: weight,
      costPerUnit: costPerUnit,
      answer: newAnswer,
      subSectionName: subSectionName,
      sectionName: sectionName,
      impactOnFormula: impactOnFormula,
    );
  }

  @override
  String toString() {
    return 'DetailedEntry: {name: $name, value: $value, referenceValue: $referenceValue, '
        'weight: $weight, costPerUnit: $costPerUnit, answer: $answer, '
        'subSectionName: $subSectionName, sectionName: $sectionName, '
        'impactOnFormula: $impactOnFormula}';
  }

  @override
  List<Object?> get props => [
        name,
        value,
        referenceValue,
        weight,
        costPerUnit,
        answer,
        subSectionName,
        sectionName,
        impactOnFormula,
      ];
}
