import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfg_flutter_app/providers/exercises_provider.dart';
import 'package:tfg_flutter_app/search/search_delegate.dart';
import 'package:tfg_flutter_app/theme/app_theme.dart';
import 'package:tfg_flutter_app/widgets/exercise_dialog.dart';
import '../models/models.dart';
import 'package:flutter/material.dart';

class MuscleListScreen extends StatelessWidget {
  const MuscleListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Muscle muscle = ModalRoute.of(context)!.settings.arguments as Muscle;
    final exerciseProvider =
        Provider.of<ExerciseProvider>(context, listen: false);
    return FutureBuilder(
        future: exerciseProvider.getExercisesByMuscle(muscle.name),
        builder: (context, AsyncSnapshot<List<Exercise>> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              constraints: const BoxConstraints(maxWidth: 150),
              height: 180,
              child: const CupertinoActivityIndicator(),
            );
          }

          //TODO STAR ICON FUNCTION

          final List<Exercise> exercises = snapshot.data!;
          return Scaffold(
              appBar: AppBar(
                backgroundColor: AppTheme.primary,
                title: Text("${muscle.name.capitalize()} exercises"),
                // actions: [
                //   IconButton(
                //       onPressed: (() => showSearch(
                //           context: context,
                //           delegate: ExerciseSearchDelegate())),
                //       icon: const Icon(Icons.search_outlined))
                // ],
              ),
              body: ListView.separated(
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) => ListTile(
                    title: Text(exercises[index].name.capitalize()),
                    leading: Text("${index + 1}"),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.star_border_outlined),
                    ),
                    onTap: (() {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              ExerciseDialog(exercise: exercises[index]));
                    })),
                itemCount: exercises.length,
              ));
        });
  }
}

// class _CastCard extends StatelessWidget {
//   const _CastCard({super.key, required this.exercise});

//   final Exercise exercise;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 10),
//       width: 200,
//       height: 200,
//       child: Column(
//         children: [
//           // ClipRRect(
//           //   borderRadius: BorderRadius.circular(20),
//           //   child: FadeInImage(
//           //     placeholder: const AssetImage("assets/loading.gif"),
//           //     image: NetworkImage(exercise.gifUrl),
//           //     height: 140,
//           //     width: 100,
//           //     fit: BoxFit.cover,
//           //   ),
//           // ),
//           // const SizedBox(
//           //   height: 5,
//           // ),
//           Text(
//             exercise.name,
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//             textAlign: TextAlign.center,
//           )
//         ],
//       ),
//     );
//   }
// }
