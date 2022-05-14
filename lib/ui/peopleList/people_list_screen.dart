import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popular_people/cubits/peopleListCubit/people_cubit.dart';
import 'package:popular_people/widgets/person_card.dart';

class PeopleListScreen extends StatelessWidget {
  const PeopleListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final circularProgress = CircularProgressIndicator.adaptive(
      backgroundColor: Theme.of(context).colorScheme.background,
    );
    return Scaffold(
      backgroundColor: const Color(0xFF324A6E),
      appBar: AppBar(
        title: const Text('Popular People'),
      ),
      body: BlocConsumer<PeopleCubit, PeopleState>(
        listener: (context, state) {},
        builder: (context, state) {
          final peopleCubit = PeopleCubit.get(context);
          final results = peopleCubit.results;
          if (state is FetchPeopleError) {
            return Center(child: Text(state.errorMessage));
          } else if (state is FetchPeopleLoading && results.isEmpty) {
            return Center(child: circularProgress);
          }
          return ListView.builder(
            controller: peopleCubit.scrollController,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (ctx, index) {
              final person = results[index];
              return Column(
                children: [
                  PersonCard(person),
                  if (index == results.length - 1) circularProgress,
                ],
              );
            },
            itemCount: results.length,
          );
        },
      ),
    );
  }
}
