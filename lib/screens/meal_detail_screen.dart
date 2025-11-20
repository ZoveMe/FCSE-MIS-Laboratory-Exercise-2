import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/meal_detail.dart';
import '../services/api_service.dart';

class MealDetailScreen extends StatefulWidget {
  final String? mealId;
  final MealDetail? mealDetail;

  const MealDetailScreen({Key? key, this.mealId, this.mealDetail})
      : super(key: key);

  @override
  _MealDetailScreenState createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  final ApiService _apiService = ApiService();
  MealDetail? _meal;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    if (widget.mealDetail != null) {
      _meal = widget.mealDetail;
      _loading = false;
    } else if (widget.mealId != null) {
      _loadMealDetail(widget.mealId!);
    } else {
      _loading = false;
    }
  }

  Future<void> _loadMealDetail(String id) async {
    try {
      final detail = await _apiService.fetchMealDetail(id);
      setState(() {
        _meal = detail;
        _loading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _launchYoutube(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open the link')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // important with gradient
      appBar: AppBar(
        title: Text(
          _meal?.strMeal ?? 'Loading...',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black.withOpacity(0.3),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
      ),

      body: _loading
          ? Center(child: CircularProgressIndicator(color: Colors.white))
          : _meal == null
          ? Center(
        child: Text(
          'No data',
          style: TextStyle(color: Colors.white),
        ),
      )
          : SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // IMAGE
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(_meal!.strMealThumb),
              ),
              SizedBox(height: 16),


              Text(
                _meal!.strMeal,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black54,
                      blurRadius: 4,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6),


              Text(
                "Category: ${_meal!.strCategory}",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),

              SizedBox(height: 20),


              Text(
                "Instructions:",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6),


              Text(
                _meal!.strInstructions,
                style: TextStyle(
                  color: Colors.white,
                  height: 1.5,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20),


              Text(
                "Ingredients:",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),


              ..._meal!.ingredients.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    "• ${entry.key} — ${entry.value}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                );
              }).toList(),

              SizedBox(height: 20),


              if (_meal!.strYoutube != null &&
                  _meal!.strYoutube!.isNotEmpty)
                Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      Colors.redAccent.withOpacity(0.9),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    icon: Icon(Icons.play_circle_outline),
                    label: Text("Watch on YouTube"),
                    onPressed: () =>
                        _launchYoutube(_meal!.strYoutube!),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
