import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/widgets.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadSelectedTabIndex();
  }

  void _saveSelectedTabIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('selectedSTabIndex', _selectedTabIndex);
  }

  void _loadSelectedTabIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedTabIndex = prefs.getInt('selectedSTabIndex') ?? 0;
    });
  }

  void info() {
    showModal(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text(
            'Take Note',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Text(_selectedTabIndex == 0
                ? '1. Arithmetic Mean: The arithmetic mean, often referred to as the average, is calculated by summing all the values in a dataset and dividing the sum by the total number of values. It represents the typical value of the dataset by taking into account the magnitude and frequency of each value.\n\n2. Geometric Mean: The geometric mean is calculated by taking the nth root of the product of n values, where n is the total number of values in the dataset. It is commonly used to find the average growth rate or to calculate the average value of quantities that change exponentially over time.\n\n3. Harmonic Mean: The harmonic mean is calculated by taking the reciprocal of the arithmetic mean of the reciprocals of the values in the dataset. It is particularly useful when dealing with rates or ratios, as it gives equal weight to each value in the dataset and emphasizes the impact of small values.\n\n4. Quadratic Mean (Root Mean Square): The quadratic mean, also known as the root mean square, is calculated by taking the square root of the average of the squared values in the dataset. It is commonly used to calculate the average magnitude or to measure the dispersion of values around the mean.\n\n5. Generalized Mean: The generalized mean is a family of means that includes the arithmetic, geometric, and harmonic means as special cases. It is calculated by taking the nth root of the average of the nth powers of the values in the dataset. The value of the parameter determines the emphasis placed on different parts of the dataset.\n\n6. Mode: The mode is the value or values that occur most frequently in a dataset. It represents the peak or peaks of the distribution and is particularly useful when dealing with categorical or discrete data.\n\n7. Median: The median is the middle value in an ordered dataset. It represents the value that divides the dataset into two equal halves, with 50% of the values below it and 50% above it. It is robust to outliers and provides a measure of the central tendency that is less affected by extreme values.'
                : _selectedTabIndex == 1
                    ? '1. Expected Value: The expected value, also known as the mean or average, represents the theoretical average outcome of a random variable. It is calculated by summing the product of each possible value and its corresponding probability. The expected value provides an indication of the central tendency of a random variable.\n\n2. Interquartile Range: The interquartile range (IQR) is a measure of statistical dispersion that represents the spread of the middle 50% of the dataset. It is calculated as the difference between the upper quartile (Q3) and the lower quartile (Q1). The IQR provides insights into the variability within the central portion of the dataset.\n\n3. Standard Deviation: The standard deviation is a widely used measure of dispersion that quantifies the average deviation of values from the mean. It is calculated as the square root of the variance. A higher standard deviation indicates a greater spread or variability in the dataset.\n\n4. Sample Standard Deviation: The sample standard deviation is an estimator of the population standard deviation based on a sample of data. It is calculated similarly to the standard deviation but uses a correction factor (n-1) in the denominator, where n is the sample size. The sample standard deviation is used when the dataset represents a sample from a larger population.\n\n5. Variance: The variance measures the average squared deviation of values from the mean. It is calculated by taking the average of the squared differences between each value and the mean. A higher variance indicates a greater spread or dispersion in the dataset.\n\n6. Sample Variance: The sample variance is an estimator of the population variance based on a sample of data. It is calculated similarly to the variance but uses a correction factor (n-1) in the denominator, where n is the sample size. The sample variance is used when the dataset represents a sample from a larger population.'
                    : _selectedTabIndex == 2
                        ? '1. Moment: In probability theory, moments are numerical values that summarize the properties of a probability distribution. The nth moment of a random variable X is calculated by taking the expected value of X raised to the power of n. The first moment is the mean or expected value, the second moment is the variance, and the third and fourth moments are related to skewness and kurtosis, respectively.\n\n2. Skewness: Skewness measures the asymmetry or lack of symmetry in the distribution of a random variable. It indicates the extent to which the distribution deviates from being perfectly symmetric. A positive skewness value indicates a longer or fatter tail on the right side of the distribution, while a negative skewness value indicates a longer or fatter tail on the left side. A skewness value of zero indicates perfect symmetry.\n\n3. Kurtosis: Kurtosis measures the shape of the probability distribution by quantifying the thickness of the tails and the peakedness of the distribution\'s center. It compares the distribution to the shape of a normal distribution. A positive kurtosis value indicates heavier tails and a sharper peak compared to a normal distribution, while a negative kurtosis value indicates lighter tails and a flatter peak.\n\n4. Kurtosis Excess: Kurtosis excess is a measure of how much the kurtosis of a distribution deviates from that of a normal distribution. It is calculated by subtracting 3 from the kurtosis value. Kurtosis excess is useful because a normal distribution has a kurtosis value of 3. Positive excess kurtosis indicates a distribution with heavier tails and a sharper peak compared to a normal distribution, while negative excess kurtosis indicates a distribution with lighter tails and a flatter peak.'
                        : '1. All Quartiles: The quartiles divide a dataset into four equal parts, each containing approximately 25% of the data. The three quartiles are denoted as Q1, Q2, and Q3. Q1 represents the first quartile, Q2 represents the second quartile (also known as the median), and Q3 represents the third quartile.\n\n2. First Quartile (Q1): The first quartile, denoted as Q1, is the value below which 25% of the data falls. It separates the lowest 25% of the dataset from the remaining 75%. Mathematically, it represents the 25th percentile.\n\n3. Second Quartile (Q2): The second quartile, denoted as Q2, is the value that divides the dataset into two equal halves. It represents the median of the dataset and is the 50th percentile. Half of the data values fall below Q2, and half fall above it.\n\n4. Third Quartile (Q3): The third quartile, denoted as Q3, is the value below which 75% of the data falls. It separates the lowest 75% of the dataset from the remaining 25%. Mathematically, it represents the 75th percentile.\n\n5. Ordinal Rank: The ordinal rank is the position or index of a value within an ordered dataset. It indicates the relative position of a value compared to other values in the dataset. For example, if a value has an ordinal rank of 10, it means it is the 10th value in the ordered dataset.\n\n6. Value: In the context of quantiles, the value refers to the specific data point that corresponds to a particular quantile or percentile. For example, the first quartile (Q1) represents the value below which 25% of the data falls. The second quartile (Q2) represents the median, which is the value that divides the dataset into two equal halves.'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Statistics',
          style: TextStyle(
            fontFamily: 'Berlin',
            fontSize: 30,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.warning_rounded),
            onPressed: () => info(),
          )
        ],
      ),
      body: PageTransitionSwitcher(
        duration: const Duration(milliseconds: 500),
        reverse: _selectedTabIndex == 3,
        transitionBuilder: (
          Widget child,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return SharedAxisTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
            fillColor: Colors.white,
            child: child,
          );
        },
        child: _selectedTabIndex == 0
            ? const CentralTendencyWidget()
            : _selectedTabIndex == 1
                ? const DispersionWidget()
                : _selectedTabIndex == 2
                    ? const ShapeOfProbabilityDistributionWidget()
                    : const QuartilesWidget(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            _selectedTabIndex = index;
            _saveSelectedTabIndex();
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.functions_rounded, size: 0),
            label: 'Central Tendency',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.functions_rounded, size: 0),
            label: 'Dispersion',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.functions_rounded, size: 0),
            label: 'Shape of probability distributions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.functions_rounded, size: 0),
            label: 'Quantiles',
          ),
        ],
      ),
    );
  }
}
