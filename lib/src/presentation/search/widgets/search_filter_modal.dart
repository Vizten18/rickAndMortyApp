import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/core/constants.dart';
import 'package:rick_and_morty_app/core/extensions.dart';
import 'package:rick_and_morty_app/l10n/l10n.dart';
import 'package:rick_and_morty_app/src/domain/entities/entities.dart';
import 'package:rick_and_morty_app/src/presentation/search/search.dart';
import 'package:rick_and_morty_app/src/widgets/widgets.dart';

class SearchFilterModal extends StatelessWidget {
  const SearchFilterModal({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return ModalContainer(
          height: context.mediaQuery.size.height * 0.45,
          child: Padding(
            padding: const EdgeInsets.all(Constants.margin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.filterLabel,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: Constants.padding),
                Text(
                  context.l10n.statusLabel,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: Constants.padding),
                FilterListBuilder<CharacterStatus>(
                  items: CharacterStatus.valuesList,
                  selectedItem: state.statusSelected,
                  onTap: (status) {
                    context.read<SearchBloc>().add(
                          SearchOnFilterChanged(characterStatus: status),
                        );
                  },
                  itemText: (status) => status.name,
                ),
                const SizedBox(height: Constants.padding),
                Text(
                  context.l10n.gendersLabel,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: Constants.padding),
                FilterListBuilder<GenderType>(
                  items: GenderType.valuesList,
                  selectedItem: state.genderSelected,
                  onTap: (gender) {
                    context.read<SearchBloc>().add(
                          SearchOnFilterChanged(genderTypes: gender),
                        );
                  },
                  itemText: (gender) => gender.name,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class FilterListBuilder<T> extends StatelessWidget {
  const FilterListBuilder({
    required this.items,
    required this.selectedItem,
    required this.onTap,
    required this.itemText,
    super.key,
  });

  final List<T> items;
  final T selectedItem;
  final void Function(T) onTap;
  final String Function(T) itemText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return GestureDetector(
            onTap: () => onTap(item),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: selectedItem == item ? Colors.blue : Colors.grey[200],
                borderRadius: BorderRadius.circular(Constants.defaultRadius),
              ),
              width: 100,
              padding: const EdgeInsets.all(Constants.padding),
              margin: const EdgeInsets.only(right: Constants.padding),
              child: Center(
                child: Text(
                  itemText(item),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
