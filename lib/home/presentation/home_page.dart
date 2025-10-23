import 'package:flutter/material.dart';
import 'package:hair_saloon/core/service/chip_data_model.dart';
import 'package:hair_saloon/core/widgets/barberservice_tiles.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List of carousel image paths
  final List<String> images = [
    "assets/img_1.jpg",
    "assets/img_2.jpg",
    "assets/img_3.jpg",
    "assets/img_4.jpg",
    "assets/img_5.jpg",
  ];

  // Promotional messages to display below the image carousel
  final List<String> messages = [
    "Look Your Best. Book a service today and let our expert stylists craft a look that makes you shine.",
    "It's time for a transformation! Elevate your style with a personalized consultation from our award-winning experts.",
    "Experience Luxury Hair Care. Indulge yourself in a serene atmosphere and the finest bespoke treatments available.",
    "Unleash Your Style Potential. Stop dreaming and call us now to secure your breakthrough appointment.",
    "Your Hair, Our Passion. Don't wait—book online today to secure your spot for the ultimate in dedicated artistry.",
  ];

  bool _imagesLoaded =
      false; // Tracks if images are preloaded for smooth carousel

  // Custom colors used in gradient background
  static const Color primaryGreen = Color(0xFF4CAF50);
  static const Color lightGreenBackground = Color(0xFFF1FDF0);

  @override
  void initState() {
    super.initState();
    // Preload images after first frame to avoid flickering in carousel
    WidgetsBinding.instance.addPostFrameCallback((_) => _preloadImages());
  }

  // Preload all carousel images to improve performance
  void _preloadImages() async {
    if (!mounted) return;
    for (var path in images) {
      await precacheImage(AssetImage(path), context);
    }
    if (mounted) setState(() => _imagesLoaded = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // Gradient background from green to white
          gradient: LinearGradient(
            colors: [primaryGreen, lightGreenBackground],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Column(
              children: [
                // Image carousel section
                _imagesLoaded
                    ? CarouselSlider(
                        items: images
                            .map(
                              (path) => ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  12,
                                ), // Rounded corners
                                child: Image.asset(
                                  path,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            )
                            .toList(),
                        options: CarouselOptions(
                          height: 270,
                          autoPlay: true, // Auto-scroll images
                          enlargeCenterPage: true, // Highlight center image
                          viewportFraction: 0.9, // Show part of adjacent images
                          aspectRatio: 16 / 9,
                        ),
                      )
                    : SizedBox(
                        height: 270,
                        child: Center(
                          child: CircularProgressIndicator(color: primaryGreen),
                        ),
                      ),
            
                const SizedBox(height: 15),
            
                // Message carousel (promotional text)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: CarouselSlider.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index, _) => Text(
                      messages[index],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    options: CarouselOptions(
                      autoPlay: true,
                      height: 50,
                      viewportFraction: 1.0,
                    ),
                  ),
                ),
            
                const SizedBox(height: 5),
            
                // List of barber services
                /// Services List (dynamic from Chips.all)
                Expanded(
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Colors
                              .transparent, // Top: Fully transparent (fades out)
                          Colors.black, // Near top: Fully visible
                          Colors.black, // Near bottom: Fully visible
                          Colors
                              .transparent, // Bottom: Fully transparent (fades out)
                        ],
                        stops: [0.0, 0.02, 0.97, 1.0],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.dstIn,
                    // The ListView.builder is the content to be masked
                    child: ListView.builder(
                      itemCount: Chips.all.length,
                      itemBuilder: (context, index) {
                        final chip = Chips.all[index];
                        return BarberServiceTile(
                          title: chip.label,
                          description: chip.description.isNotEmpty
                              ? chip.description
                              : 'No description available',
                          price: chip.price.toInt(),
                        );
                      },
                    ),
                  ),
                ),
              SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
