import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:pingolearn/core/theme/app_pallete.dart';
import 'package:pingolearn/features/news/presentation/provider/news_provider.dart';
import 'package:pingolearn/features/news/presentation/widgets/news_listtile.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _remoteConfig = FirebaseRemoteConfig.instance;
  bool isLoading = false;

  @override
  void initState() {
    initRemoteConfig();

    super.initState();
  }

  initRemoteConfig() async {
    setState(() {
      isLoading = true;
    });
    await _remoteConfig.setDefaults({"countryCode": "in"});
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(seconds: 10)));
    await _remoteConfig.fetchAndActivate();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<NewsProvider>()
        .fetchNews(countryCode: _remoteConfig.getString("countryCode"));
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Transform.rotate(
                  angle: 5.5,
                  child: GestureDetector(
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                    },
                    child: const Icon(
                      Icons.send,
                      color: AppPallete.white,
                      size: 18,
                    ),
                  )),
            ),
            const SizedBox(
              width: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                " ${_remoteConfig.getString("countryCode").toUpperCase()}",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: AppPallete.white),
              ),
            ),
            const SizedBox(
              width: 25,
            )
          ],
          automaticallyImplyLeading: false,
          backgroundColor: AppPallete.primaryColor,
          title: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              "MyNews",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppPallete.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Consumer<NewsProvider>(builder: (context, newsProvider, child) {
              if (newsProvider.state == NewsState.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (newsProvider.state == NewsState.failure) {
                return Center(
                    child: Text('Error: ${newsProvider.errorMessage}'));
              } else if (newsProvider.state == NewsState.success) {
                return Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Row(
                        children: [
                          Text(
                            "Top Headlines",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: newsProvider.news?.length ?? 0,
                        itemBuilder: (context, index) {
                          final article = newsProvider.news?[index];
                          return NewsListtile(
                              newsSource: article!.source!.name ?? '',
                              title: article.title ?? '',
                              image: article.urlToImage ??
                                  'https://img.freepik.com/premium-vector/top-headlines-news-background-concept_1017-12631.jpg',
                              dateTime: article.publishedAt ?? '',
                              onTap: () async {
                                final url = Uri.parse(article.url.toString());
                                await launchUrl(url);
                              });
                        },
                      ),
                    )
                  ],
                );
              } else {
                return const Center(child: Text('No news available.'));
              }
            }),
    );
  }
}
