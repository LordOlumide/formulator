import 'package:flutter/material.dart';
import 'package:formulator/src/entities/db_manager/db_manager.dart';
import 'package:formulator/src/entities/models/formula.dart';
import 'package:formulator/src/features/formula_screen/views/formula_display_section.dart';
import 'package:formulator/src/features/formula_screen/views/section_body.dart';
import 'package:formulator/src/features/formula_screen/views/section_headers.dart';
import 'package:formulator/src/utils/extensions/number_extension.dart';
import 'package:provider/provider.dart';

class FormulaScreen extends StatefulWidget {
  final String formulaName;

  const FormulaScreen({super.key, required this.formulaName});

  @override
  State<FormulaScreen> createState() => _FormulaScreenState();
}

class _FormulaScreenState extends State<FormulaScreen> {
  final ScrollController horizFormulaController = ScrollController();
  final ScrollController vertController = ScrollController();
  final ValueNotifier<String?> selectedSectionNotifier = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    resetSelectedNotifier();
  }

  void resetSelectedNotifier([String? nameOfSectionAboutToBeDeleted]) {
    Formula initialFormula =
        context.read<DBManager>().formulasMap[widget.formulaName]!;
    final List<String> availableSections = initialFormula.sectionNames;

    if (nameOfSectionAboutToBeDeleted == null) {
      if (availableSections.isNotEmpty) {
        selectedSectionNotifier.value = availableSections[0];
      } else {
        selectedSectionNotifier.value = null;
      }
      return;
    }

    final int indexToBeDeleted =
        availableSections.indexOf(nameOfSectionAboutToBeDeleted);
    if (availableSections.isEmpty || availableSections.length == 1) {
      selectedSectionNotifier.value = null;
    } else {
      if (indexToBeDeleted > 0) {
        selectedSectionNotifier.value = availableSections[indexToBeDeleted - 1];
      } else if (availableSections.length - 1 > indexToBeDeleted) {
        selectedSectionNotifier.value = availableSections[indexToBeDeleted + 1];
      } else {
        selectedSectionNotifier.value = null;
      }
    }
  }

  @override
  void dispose() {
    horizFormulaController.dispose();
    vertController.dispose();
    selectedSectionNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 20),
            Text(
              widget.formulaName,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 20),
            Container(
              padding: const EdgeInsets.fromLTRB(6, 1, 6, 5),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Consumer<DBManager>(
                builder: (context, manager, child) {
                  return Text(
                    '(${manager.formulasMap[widget.formulaName]!.totalSectionWeight.formatToString})',
                    style: const TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: Scrollbar(
        controller: vertController,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: vertController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TODO: Display total section weight
              FormulaDisplaySection(
                controller: horizFormulaController,
                formulaName: widget.formulaName,
              ),
              const SizedBox(height: 4),
              SectionHeaders(
                formulaName: widget.formulaName,
                selectedSectionNotifier: selectedSectionNotifier,
                resetSelectedNotifier: resetSelectedNotifier,
              ),
              const SizedBox(height: 8),
              SectionBody(
                formulaName: widget.formulaName,
                selectedSectionNotifier: selectedSectionNotifier,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
