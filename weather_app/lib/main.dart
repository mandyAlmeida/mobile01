import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData.dark(),
      home: const WeatherHomePage(),
    );
  }
}

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _location = "No location selected"; // Default text before searching

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// 📌 Updates the displayed location when searching for a city
  void _updateWithSearch(String city) {
    setState(() {
      _location = city;
    });
  }

  /// 📌 Updates the displayed location when clicking geolocation
  void _updateWithGeolocation() {
    setState(() {
      _location = "Geolocation";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: _buildSearchBar(),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on),
            onPressed: _updateWithGeolocation,
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTabContent("Currently"),
          _buildTabContent("Today"),
          _buildTabContent("Weekly"),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  /// 📌 Search bar inside the AppBar
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search location...",
          border: InputBorder.none,
          prefixIcon: const Icon(Icons.search),
        ),
        onSubmitted: _updateWithSearch, // Updates when the user presses Enter
      ),
    );
  }

  /// 📌 Tab content dynamically displaying the searched location
  Widget _buildTabContent(String tabName) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            tabName,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(_location, style: const TextStyle(fontSize: 26)),
        ],
      ),
    );
  }

  /// 📌 Bottom Navigation Bar with 3 tabs
  Widget _buildBottomNavigationBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: TabBar(
        controller: _tabController,
        indicatorColor: Colors.orange,
        labelColor: Colors.orange,
        unselectedLabelColor: Colors.white,
        tabs: const [
          Tab(icon: Icon(Icons.wb_sunny), text: "Currently"),
          Tab(icon: Icon(Icons.today), text: "Today"),
          Tab(icon: Icon(Icons.calendar_view_week), text: "Weekly"),
        ],
      ),
    );
  }
}
