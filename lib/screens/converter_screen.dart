import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/converter_provider.dart';

class ConverterScreen extends StatelessWidget {
  const ConverterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final converter = context.watch<ConverterProvider>();
    const blue = Color(0xFF3179DC);
    const labelColor = Color(0xFF7D8DA6);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Unit Converter',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => SystemNavigator.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Length, Weight and Temperature tabs.
              Container(
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F8FB),
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: const Color(0xFFE3E7EE)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x170A2D64),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: converter.categories.map((category) {
                    bool isSelected = converter.category == category;
                    return Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(7),
                        onTap: () => converter.changeCategory(category),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected ? blue : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            category == 'Temperature' ? 'Temp' : category,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF33425B),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'Enter Value',
                style: TextStyle(
                  color: labelColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: _fieldShadow(),
                child: TextFormField(
                  initialValue: '25',
                  keyboardType: const TextInputType.numberWithOptions(
                    signed: true,
                    decimal: true,
                  ),
                  onChanged: converter.changeInput,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2B354A),
                  ),
                  decoration: _inputDecoration(),
                ),
              ),
              const SizedBox(height: 23),
              const Divider(color: Color(0xFFE6E9EF)),
              const SizedBox(height: 17),
              const Text(
                'From',
                style: TextStyle(
                  color: labelColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              _buildDropdown(
                value: converter.fromUnit,
                units: converter.units,
                onChanged: converter.changeFromUnit,
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  const Expanded(child: Divider(color: Color(0xFFE5E8EF))),
                  const SizedBox(width: 12),
                  Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      color: blue,
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x453179DC),
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: IconButton(
                      tooltip: 'Swap units',
                      icon: const Icon(
                        Icons.swap_horiz_rounded,
                        color: Colors.white,
                        size: 31,
                      ),
                      onPressed: converter.swapUnits,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(child: Divider(color: Color(0xFFE5E8EF))),
                ],
              ),
              const SizedBox(height: 2),
              const Text(
                'To',
                style: TextStyle(
                  color: labelColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              _buildDropdown(
                value: converter.toUnit,
                units: converter.units,
                onChanged: converter.changeToUnit,
              ),
              const SizedBox(height: 23),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE9ECF2)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x260A2D64),
                      blurRadius: 9,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Result:',
                      style: TextStyle(
                        color: labelColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 7),
                    const Divider(height: 1, color: Color(0xFFE4E8F0)),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          converter.resultText,
                          style: const TextStyle(
                            color: blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> units,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: _fieldShadow(),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Color(0xFF52647E),
          ),
          style: const TextStyle(
            color: Color(0xFF2B354A),
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          items: units.map((unit) {
            return DropdownMenuItem<String>(
              value: unit,
              child: Text(unit),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  BoxDecoration _fieldShadow() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(9),
      border: Border.all(color: const Color(0xFFE7EAF0)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x1B183A72),
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration() {
    return const InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
    );
  }
}
