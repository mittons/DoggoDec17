import 'package:doggo_dec_17/helpers/ui_helper.dart';
import 'package:doggo_dec_17/models/doggo_service/doggo_breed.dart';
import 'package:doggo_dec_17/services/doggo_service/doggo_service.dart';
import 'package:doggo_dec_17/services/service_result.dart';
import 'package:flutter/material.dart';

class DoggoScreen extends StatefulWidget {
  final DoggoService doggoService;

  const DoggoScreen({super.key, required this.doggoService});

  @override
  State<StatefulWidget> createState() => _DoggoScreenState();
}

class _DoggoScreenState extends State<DoggoScreen> {
  bool dogsLoaded = false;
  late List<DoggoBreed> doggoBreeds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doggo diversity display app ^-^"),
        backgroundColor: Colors.deepPurpleAccent.shade100,
      ),
      body: Column(
        children: [
          _buildButtonContainer(),
          if (dogsLoaded) Expanded(child: _buildDoggoList()),
        ],
      ),
    );
  }

  Widget _buildButtonContainer() {
    return Container(
        child: ElevatedButton(
            onPressed: _handleButtonPressed,
            child: const Text("Get List of Doggo Diversity!")));
  }

  void _handleButtonPressed() async {
    // Fetch data from service (await)
    ServiceResult doggoBreedsResult =
        await widget.doggoService.getDoggoBreeds();

    // Check if context is still mounted, else return
    if (!context.mounted) return;

    // Check response, verify service was successful. Otherwise be graceful to user and show snackbar, then return
    if (!doggoBreedsResult.success) {
      // Display user snackbar
      UiHelper.displaySnackbar(context,
          "There was an error fetching the requested data from the web service. Please try again later.");
    }

    // If everything checks out -> Set state:
    //  - Set the dogbreed data in state to what we just receieved
    //  - And ensure the app knows the dog data is loaded
    setState(() {
      doggoBreeds = doggoBreedsResult.data!;
      dogsLoaded = true;
    });
  }

  Widget _buildDoggoList() {
    return ListView.builder(
        itemBuilder: _doggoBreedItemBuilder, itemCount: doggoBreeds.length);
  }

  Widget _doggoBreedItemBuilder(context, index) {
    return Card(
      child: ListTile(
        title: Text(doggoBreeds[index].name),
        subtitle: (doggoBreeds[index].temperament == null)
            ? null
            : Text(doggoBreeds[index].temperament!),
      ),
    );
  }
}
