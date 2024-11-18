import 'package:flutter/material.dart';

void main() {
  runApp(const BMICalculator());
}

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF0A0E21),
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
      ),
      home: const InputPage(),
    );
  }
}

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  double height = 170;
  double weight = 60;

  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    heightController.text = height.toStringAsFixed(1);
    weightController.text = weight.toStringAsFixed(1);
  }

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  double calculateBMI() {
    return weight / ((height / 100) * (height / 100));
  }

  String getResult() {
    double bmi = calculateBMI();
    if (bmi >= 25) {
      return 'Thừa cân';
    } else if (bmi > 18.5) {
      return 'Bình thường';
    } else {
      return 'Thiếu cân';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI CALCULATOR'),
        backgroundColor: const Color(0xFF0A0E21),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'CHIỀU CAO (cm)',
                    style: TextStyle(fontSize: 18),
                  ),
                  Slider(
                    value: height,
                    min: 120,
                    max: 220,
                    onChanged: (value) {
                      setState(() {
                        height = value;
                        heightController.text = value.toStringAsFixed(1);
                      });
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Nhập chiều cao'),
                          content: TextField(
                            controller: heightController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              suffix: Text('cm'),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Hủy'),
                            ),
                            TextButton(
                              onPressed: () {
                                double? newHeight =
                                    double.tryParse(heightController.text);
                                if (newHeight != null &&
                                    newHeight >= 120 &&
                                    newHeight <= 220) {
                                  setState(() {
                                    height = newHeight;
                                  });
                                  Navigator.pop(context);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Vui lòng nhập chiều cao từ 120cm đến 220cm'),
                                    ),
                                  );
                                }
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text(
                      height.toStringAsFixed(1),
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'CÂN NẶNG (kg)',
                    style: TextStyle(fontSize: 18),
                  ),
                  Slider(
                    value: weight,
                    min: 30,
                    max: 150,
                    onChanged: (value) {
                      setState(() {
                        weight = value;
                        weightController.text = value.toStringAsFixed(1);
                      });
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Nhập cân nặng'),
                          content: TextField(
                            controller: weightController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              suffix: Text('kg'),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Hủy'),
                            ),
                            TextButton(
                              onPressed: () {
                                double? newWeight =
                                    double.tryParse(weightController.text);
                                if (newWeight != null &&
                                    newWeight >= 30 &&
                                    newWeight <= 150) {
                                  setState(() {
                                    weight = newWeight;
                                  });
                                  Navigator.pop(context);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Vui lòng nhập cân nặng từ 30kg đến 150kg'),
                                    ),
                                  );
                                }
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text(
                      weight.toStringAsFixed(1),
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: const Color(0xFFEB1555),
            margin: const EdgeInsets.only(top: 10),
            width: double.infinity,
            height: 80,
            child: Center(
              child: Text(
                'CHỈ SỐ BMI CỦA BẠN: ${calculateBMI().toStringAsFixed(1)}\n${getResult()}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
