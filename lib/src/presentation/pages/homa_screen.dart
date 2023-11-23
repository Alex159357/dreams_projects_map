import 'package:dreams_projects_map/src/config/ext/context.dart';
import 'package:dreams_projects_map/src/presentation/manager/home_screen/home_screen_bloc.dart';
import 'package:dreams_projects_map/src/presentation/manager/home_screen/home_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WebViewController controller = WebViewController();

  late final PlatformWebViewControllerCreationParams params;


  @override
  void initState() {
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: context.homeScreenBloc.onLoadingPercentChanged,
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) { //campaign__banner
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   return NavigationDecision.prevent;
            // }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://maps.bmby.com/?lang=he&force=1'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //TODO Check if can go back? show app bar back button else hide app bar
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: BlocListener<HomeScreenBloc, HomeScreenState>(
              listener: _homeListener,
              child: Stack(
                children: [WebViewWidget(controller: controller), _getLoadingView],
              )),
        ),
      ),
    );
  }

  Widget get _getLoadingView =>
      BlocBuilder<HomeScreenBloc, HomeScreenState>(builder: _loadingBuilder);

  void _homeListener(BuildContext context, HomeScreenState state) {}

  Widget _loadingBuilder(BuildContext context, HomeScreenState state) {
    if (state.loading) {
      return Positioned.fill(
          child: Container(
        color: Color(0xFF333333),
        child: Center(
          child: SizedBox(
            height: 200,
            width: 200,
            child: LiquidLinearProgressIndicator(
              value: state.percent / 100,
              valueColor: const AlwaysStoppedAnimation(Colors.blueAccent),
              backgroundColor: Colors.white,
              borderColor: Colors.transparent,
              borderWidth: 5.0,
              borderRadius: 9000,
              direction: Axis.vertical,
              center: Text("${state.percent} %", style: const TextStyle(color: Color(0xFF333333), fontSize: 24),),
            ),
          ),
        ),
      ));
    }else{
      controller.runJavaScript("var elements = document.getElementsByClassName('campaign__banner'); if (elements.length > 0) { elements[0].style.display = 'none'; }");
    }
    return const SizedBox(
      width: 0,
      height: 0,
    );
  }
}
