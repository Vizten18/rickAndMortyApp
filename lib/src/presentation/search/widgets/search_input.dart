import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/core/constants.dart';
import 'package:rick_and_morty_app/l10n/l10n.dart';
import 'package:rick_and_morty_app/src/presentation/search/search.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Constants.padding,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (value) {
                context.read<SearchBloc>().add(
                      SearchOnTextChanged(text: value),
                    );
              },
              decoration: InputDecoration(
                hintText: context.l10n.searchHintLabel,
                isDense: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(width: Constants.padding),
          IconButton(
            onPressed: () {
              context.read<SearchBloc>().add(
                    const SearchOnOpenModalFilter(),
                  );
            },
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
    );
  }
}
