import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_woocommerce/util/dimensions.dart';
import 'package:flutter_woocommerce/view/base/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/view/base/no_data_screen.dart';
import 'package:flutter_woocommerce/view/screens/html/controller/webview_controller.dart';
import 'package:get/get.dart';

enum HtmlType {
  TERMS_AND_CONDITION,
  PRIVACY_POLICY,
  ABOUT_US,
  CANCELLATION_POLICY,
  REFUND_POLICY
}


class HtmlViewerScreen extends StatefulWidget {
  final HtmlType htmlType;
  HtmlViewerScreen({@required this.htmlType});

  @override
  State<HtmlViewerScreen> createState() => _HtmlViewerScreenState();


}

class _HtmlViewerScreenState extends State<HtmlViewerScreen> {
  @override
  initState() {
    super.initState();
    Get.find<HtmlViewController>().getPagesContent();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.htmlType == HtmlType.TERMS_AND_CONDITION ? 'terms_conditions'.tr :
      widget.htmlType == HtmlType.ABOUT_US ? 'about_us'.tr :
      widget.htmlType == HtmlType.PRIVACY_POLICY ? 'privacy_policy'.tr :
      widget.htmlType == HtmlType.CANCELLATION_POLICY ? 'cancellation_policy'.tr :
      widget.htmlType == HtmlType.REFUND_POLICY ? 'refund_policy'.tr :
      'no_data_found'.tr,
        isBackButtonExist: true,
      ),


      body: GetBuilder<HtmlViewController>(
        builder: (htmlViewController){
          String _data;
          if(htmlViewController.pagesContent != null){
            _data = widget.htmlType == HtmlType.TERMS_AND_CONDITION ? htmlViewController.pagesContent.termsConditions
                : widget.htmlType == HtmlType.ABOUT_US ? htmlViewController.pagesContent.aboutUs
                : widget.htmlType == HtmlType.PRIVACY_POLICY ? htmlViewController.pagesContent.privacyPolicy
                // : htmlType == HtmlType.REFUND_POLICY ? htmlViewController.pagesContent.refundPolicy
                // : htmlType == HtmlType.CANCELLATION_POLICY ? htmlViewController.pagesContent.cancellationPolicy.liveValues
                : null;

            if(_data != null) {
              _data = _data.replaceAll('href=', 'target="_blank" href=');

              return  (_data =='' || _data == null)  ? NoDataScreen( text: 'no_data_found'.tr, type: NoDataType.PAGES ) :Container(
                  width: Dimensions.WEB_MAX_WIDTH,
                  height: Get.height,
                  color: GetPlatform.isWeb ? Colors.black12 : Theme.of(context).colorScheme.background,
                  child:SingleChildScrollView(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL,
                    ),
                    physics: BouncingScrollPhysics(),
                    child: Html( data: _data ),
                  ),
              );
            }else{
              return SizedBox();
            }
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

// class HtmlViewerScreen extends StatefulWidget {
//   final HtmlType htmlType;
//   HtmlViewerScreen({@required this.htmlType});
//
//   @override
//   State<HtmlViewerScreen> createState() => _HtmlViewerScreenState();
// }
//
// class _HtmlViewerScreenState extends State<HtmlViewerScreen> {
//
//   @override
//   Widget build(BuildContext context) {
//     print('====ttttt=======>${widget.htmlType}');
//     return Scaffold(
//       appBar: CustomAppBar(title: widget.htmlType == HtmlType.TERMS_AND_CONDITION ? 'terms_conditions'.tr
//           : widget.htmlType == HtmlType.ABOUT_US ? 'about_us'.tr : widget.htmlType == HtmlType.PRIVACY_POLICY
//           ? 'privacy_policy'.tr : 'no_data_found'.tr),
//       backgroundColor: Theme.of(context).cardColor,
//       body: GetBuilder<ConfigController>(builder: (configController) {
//         String _htmlText = '';
//         if(configController.config != null) {
//           if(widget.htmlType == HtmlType.TERMS_AND_CONDITION) {
//             _htmlText = configController.config.termsAndConditions;
//           }else if(widget.htmlType == HtmlType.PRIVACY_POLICY) {
//             _htmlText = configController.config.privacyPolicy;
//           }else {
//             _htmlText = configController.config.privacyPolicy;
//           }
//         }
//         return Align(
//           alignment: Alignment.topCenter,
//           child: configController.config != null ? SingleChildScrollView(
//             physics: BouncingScrollPhysics(),
//             child: Ink(
//               width: Dimensions.WEB_MAX_WIDTH,
//               color: Theme.of(context).cardColor,
//               padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
//               child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//
//                 ResponsiveHelper.isDesktop(context) ? Container(
//                   height: 50, alignment: Alignment.center, color: Theme.of(context).cardColor, width: Dimensions.WEB_MAX_WIDTH,
//                   child: SelectableText(widget.htmlType == HtmlType.TERMS_AND_CONDITION ? 'terms_conditions'.tr
//                       : widget.htmlType == HtmlType.ABOUT_US ? 'about_us'.tr : widget.htmlType == HtmlType.PRIVACY_POLICY
//                       ? 'privacy_policy'.tr : 'no_data_found'.tr,
//                     style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge, color: Colors.black),
//                   ),
//                 ) : SizedBox(),
//
//                 (_htmlText.contains('<ol>') || _htmlText.contains('<ul>')) ? HtmlWidget(
//                   _htmlText ?? '',
//                   key: Key(widget.htmlType.toString()),
//                   isSelectable: true,
//                   onTapUrl: (String url) {
//                     return launchUrlString(url, mode: LaunchMode.externalApplication);
//                   },
//                 ) : SelectableHtml(
//                   data: _htmlText, shrinkWrap: true,
//                   onLinkTap: (String url, RenderContext context, Map<String, String> attributes, element) {
//                     if(url.startsWith('www.')) {
//                       url = 'https://' + url;
//                     }
//                     print('Redirect to url: $url');
//                     html.window.open(url, "_blank");
//                   },
//                 ),
//
//               ]),
//             ),
//           ) : CircularProgressIndicator(),
//         );
//       }),
//     );
//   }
// }