import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfg_flutter_app/providers/exercises_provider.dart';

import '../models/models.dart';
import '../widgets/exercise_dialog.dart';

class ExerciseSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => "Search Exercise";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = "", icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text("buildResults");
  }

  Widget _emptyContainer() {
    return Container(
      child: const Center(
        child: Icon(Icons.fitness_center, color: Colors.black38, size: 130),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) _emptyContainer;

    final moviesProvider =
        Provider.of<ExerciseProvider>(context, listen: false);
    moviesProvider.getSuggestionsByQuery(query);

    return StreamBuilder(
      stream: moviesProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List<Exercise>> snapshot) {
        if (!snapshot.hasData) return _emptyContainer();

        final exercises = snapshot.data!;

        return ListView.builder(
            itemCount: exercises.length,
            itemBuilder: (_, int index) => _ExerciseItem(exercises[index]));
      },
    );
  }
}

class _ExerciseItem extends StatelessWidget {
  final Exercise exercise;

  const _ExerciseItem(this.exercise);
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(exercise.name.capitalize()),
        onTap: (() {
          showDialog(
              context: context,
              builder: (context) => ExerciseDialog(exercise: exercise));
        }));
  }
}
