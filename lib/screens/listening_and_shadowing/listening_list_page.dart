import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/listening/listening_bloc.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/shared_widgets/main_scaffold.dart';

import '../../config/pmp_routes.dart';
import '../../l10n/generated/l10n.dart';

class ListeningListPage extends StatefulWidget {
  const ListeningListPage({super.key});

  @override
  State<ListeningListPage> createState() => _ListeningListPageState();
}

class _ListeningListPageState extends State<ListeningListPage> {
  final _listeningBloc = ListeningBloc();
  int? expandedIndex; // Track which card is expanded

  @override
  void initState() {
    super.initState();
    _listeningBloc.add(const ListeningEvent.loadListenings());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _listeningBloc,
      child: MainScaffold(
        appBar: AppBar(
          title: const Text('Listening List'),
        ),
        body: BlocBuilder<ListeningBloc, ListeningState>(
          bloc: _listeningBloc,
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
                      style:
                          PmpTextStyles.body2Semi.copyWith(color: Colors.white),
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
                      color: const Color.fromARGB(255, 30, 71, 86),
                      borderRadius: BorderRadius.circular(12),
                      shadowColor: Colors.black.withValues(alpha: 0.4),
                      elevation: 6,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            PmpRoutes.youtubeVideoPage,
                            arguments: {
                              "listening": listening,
                              "enableMMSub": false,
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Row(
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
                                        color: const Color(0xFF203A43),
                                        child: const Center(
                                          child: SizedBox(
                                            width: 18,
                                            height: 18,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                        width: 60,
                                        height: 60,
                                        color: const Color(0xFF203A43),
                                        child: const Icon(
                                          Icons.broken_image,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      listening.title,
                                      style: PmpTextStyles.body2Semi
                                          .copyWith(color: Colors.white),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const Icon(
                                    // isExpanded
                                    //     ? Icons.keyboard_arrow_up
                                    //     : Icons.keyboard_arrow_down,
                                    Icons.chevron_right,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              // if (isExpanded)
                              //   Column(
                              //     children: [
                              //       const SizedBox(height: 8),
                              //       Row(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.start,
                              //         children: [
                              //           ElevatedButton(
                              //             style: ElevatedButton.styleFrom(
                              //               backgroundColor: Colors.white,
                              //             ),
                              //             onPressed: () {
                              //               Navigator.pushNamed(
                              //                 context,
                              //                 PmpRoutes.youtubeVideoPage,
                              //                 arguments: {
                              //                   "listening": listening,
                              //                   "enableMMSub": false,
                              //                 },
                              //               );
                              //             },
                              //             child: Text(
                              //               'Open',
                              //               style: PmpTextStyles.body2Semi
                              //                   .copyWith(
                              //                       color: Colors.black87),
                              //             ),
                              //           ),
                              //           const SizedBox(width: 6),
                              //           if (listening.hasMMSubtitle)
                              //             ElevatedButton(
                              //               style: ElevatedButton.styleFrom(
                              //                 // backgroundColor:
                              //                 //     const Color(0xFF2C5364)),
                              //                 backgroundColor: Colors.white,
                              //               ),
                              //               onPressed: () {
                              //                 Navigator.pushNamed(
                              //                   context,
                              //                   PmpRoutes.youtubeVideoPage,
                              //                   arguments: {
                              //                     "listening": listening,
                              //                     "enableMMSub": true,
                              //                   },
                              //                 );
                              //               },
                              //               child: Text(
                              //                 'Open with mm sub',
                              //                 style: PmpTextStyles.body2Semi
                              //                     .copyWith(
                              //                         color: Colors.black87),
                              //               ),
                              //             ),
                              //         ],
                              //       ),
                              //     ],
                              //   )
                              //       .animate(
                              //           target: isExpanded
                              //               ? 1
                              //               : 0) // Control animation
                              //       .fade(duration: 500.ms) // Fade effect
                              //       .slideY(
                              //           begin: -0.1,
                              //           duration: 500.ms), // Slide down
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
