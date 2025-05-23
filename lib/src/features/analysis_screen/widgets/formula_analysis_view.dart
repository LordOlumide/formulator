import 'package:flutter/material.dart';
import 'package:formulator/src/entities/models/formula.dart';
import 'package:formulator/src/entities/models/section.dart';
import 'package:formulator/src/features/analysis_screen/widgets/formula_section_headers.dart';
import 'package:formulator/src/features/analysis_screen/widgets/section_body_2.dart';

class FormulaAnalysisView extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Formula formula;
  final ScrollController scrollController;
  final ValueNotifier<String?> selectedSectionNotifier;

  const FormulaAnalysisView({
    super.key,
    required this.title,
    required this.backgroundColor,
    required this.formula,
    required this.scrollController,
    required this.selectedSectionNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 6, right: 2, left: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                width: 150,
                // padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                margin: const EdgeInsets.only(right: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 4),
                ),
                child: Center(
                  child: FittedBox(
                    child: Text(
                      '=${(formula.answer * 100).toStringAsFixed(4)}%',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          FormulaSectionHeaders(
            formula: formula,
            selectedSectionNotifier: selectedSectionNotifier,
          ),
          const SizedBox(height: 2),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(3),
              ),
              child: ValueListenableBuilder(
                valueListenable: selectedSectionNotifier,
                builder: (context, selectedSectionName, child) {
                  return Scrollbar(
                    controller: scrollController,
                    thumbVisibility: true,
                    thickness: 20,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 50, right: 20),
                      controller: scrollController,
                      child: SectionBody2(
                        selectedSection: formula.sections.firstWhere(
                          (Section e) => e.name == selectedSectionName,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
