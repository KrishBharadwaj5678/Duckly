import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:random_duck/constants/home_constant.dart';
import 'package:random_duck/widgets/custom_app_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<String> _imageUrl;
  final AudioPlayer _player = AudioPlayer();

  Future<String> getDuck() async {
    final url = Uri.parse("https://random-d.uk/api/v2/random");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["url"] ?? "";
      } else {
        throw Exception("Failed to load duck.");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<void> playSound() async {
    await _player.play(AssetSource("audio/quack.mp3"));
  }

  void refreshDuck() {
    setState(() {
      _imageUrl = getDuck();
    });
  }

  @override
  void initState() {
    super.initState();
    _imageUrl = getDuck();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          playSound();
          refreshDuck();
        },
        color: Color(0xFF42A5F5),
        child: Center(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: FutureBuilder(
                future: _imageUrl,
                builder: (context, snapshot) {
                  // Null Saftey Check
                  final data = snapshot.data;
                  final imageUrlSafe = data != null && data.isNotEmpty
                      ? data
                      : null;

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Image Container
                      Skeletonizer(
                        enabled:
                            snapshot.connectionState == ConnectionState.waiting,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: imageUrlSafe != null
                              ? Image.network(
                                  imageUrlSafe,
                                  width: double.infinity,
                                  height: 500,
                                  fit: BoxFit.fill,
                                )
                              : Container(
                                  width: double.infinity,
                                  height: 500,
                                  color: Colors.grey.shade500,
                                ),
                        ),
                      ),

                      // Spacing
                      SizedBox(height: 35),

                      // Generate Button
                      SizedBox(
                        width: double.infinity,
                        height: 70,

                        child: ElevatedButton(
                          style: HomeConstant.buttonStyle,
                          onPressed: () {
                            playSound();
                            refreshDuck();
                          },
                          child: Text(
                            "Another Duck",
                            style: HomeConstant.buttonTextStyle,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
