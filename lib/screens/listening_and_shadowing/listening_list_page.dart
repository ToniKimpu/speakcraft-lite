import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/listening/listening_bloc.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';

import '../../l10n/generated/l10n.dart';
import 'sheets/actions_bottom_sheet.dart';

class ListeningListPage extends StatefulWidget {
  const ListeningListPage({super.key});

  @override
  State<ListeningListPage> createState() => _ListeningListPageState();
}

class _ListeningListPageState extends State<ListeningListPage> {
  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocProvider(
      create: (context) =>
          ListeningBloc()..add(const ListeningEvent.loadListenings()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Listening And Shadowing'),
        ),
        body: BlocBuilder<ListeningBloc, ListeningState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(
                child: SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(),
                ),
              ),
              loaded: (listenings) {
                if (listenings.isEmpty) {
                  return Center(
                    child: Text(
                      AppLocalizations.of(context).txtWillUploadSoon,
                      style: PmpTextStyles.body2Semi
                          .copyWith(color: colorScheme.onSurface),
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: listenings.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final listening = listenings[index];
                    return Material(
                      color: colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext context) {
                              return ActionsBottomSheet(
                                listening: listening,
                              );
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(color: colorScheme.outlineVariant),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: listening.thumbnail,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    width: 60,
                                    height: 60,
                                    color: colorScheme.surface,
                                    child: const Center(
                                      child: SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    width: 60,
                                    height: 60,
                                    color: colorScheme.surface,
                                    child: Icon(
                                      Icons.broken_image,
                                      size: 20,
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  listening.title,
                                  style: PmpTextStyles.body2Semi
                                      .copyWith(color: colorScheme.onSurface),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              orElse: () => Container(),
            );
          },
        ),
      ),
    );
  }
}
