import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sisi_iot_app/ui/provider/provider_login.dart';
import 'package:sisi_iot_app/ui/utils/global.dart';
import 'package:sisi_iot_app/ui/utils/global_palette.dart';
import 'package:sisi_iot_app/ui/utils/global_formatters.dart';
import 'package:sisi_iot_app/ui/utils/global_label.dart';
import 'package:sisi_iot_app/ui/widgets/widget_black_arrow.dart';
import 'package:sisi_iot_app/ui/widgets/widget_button.dart';
import 'package:sisi_iot_app/ui/widgets/widget_label_text.dart';
import 'package:sisi_iot_app/ui/widgets/widget_text_form_field.dart';

final _formKey = GlobalKey<FormState>();

class PageLogin extends StatelessWidget {
  PageLogin({Key? key}) : super(key: key);
  static const routePage = Global.routePageLogin;
  ProviderLogin? providerLogin;

  @override
  Widget build(BuildContext context) {
    providerLogin ??= Provider.of<ProviderLogin>(context);
    return AnnotatedRegion(
      value: ColorsPalette.colorWhite,
      child: Scaffold(
        backgroundColor: ColorsPalette.colorWhite,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: WidgetBlackArrow(
                        callback: () {},
                      ),
                    ),
                    const Image(
                      image: AssetImage("${Global.assetsLogo}logo-estandar.png"),
                      height: 40,
                      width: 200,
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        WidgetLabelText().labelTextTitle(
                            text: GlobalLabel.lblWelcome,
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            colortext: ColorsPalette.colorPrimary,
                            textAlign: TextAlign.center),
                      ],
                    ),
                    WidgetLabelText().labelTextNormal(text: GlobalLabel.lblSubWelcome, fontSize: 14, colortext: ColorsPalette.colorPrimary),
                    const SizedBox(
                      height: 25,
                    ),
                    contTextUser(),
                    contTextPassword(),
                    const SizedBox(height: 10),
                    if (providerLogin!.errorMessage != null) ...[Text(providerLogin!.errorMessage!)],
                    widgetButonLogin(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget widgetButonLogin(BuildContext context) {
    return WidgetButton(
      text: "Ingresar",
      color: ColorsPalette.colorPrimary,
      onTap: () {
        // if (_formKey.currentState!.validate()) {
        providerLogin!.login();
        // } else {
        // alertSimpleMessage(context, "¡Aviso!", "Revise que la información ingresada sea correcta e intente nuevamente.", textAccept: "Entendido");
        // }
      },
    );
  }

  Widget contTextUser() {
    return WidgetTextFormField(
      padding: const EdgeInsets.symmetric(vertical: 10),
      controller: providerLogin!.controllerUser,
      labelTitle: GlobalLabel.lblUser,
      keyboardType: TextInputType.emailAddress,
      inputFormatters: formattersUser(),
      hintText: 'Ingrese su usuario',
      fontSize: 16,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      colorWhenFocus: true,
      validator: (val) {
        String text = val!.trim();
        if (text.isEmpty) {
          return GlobalLabel.lblTextEnterUser;
        }
        return null;
      },
    );
  }

  Widget contTextPassword() {
    return WidgetTextFormField(
      padding: const EdgeInsets.symmetric(vertical: 10),
      obscureText: providerLogin!.visiblePassword,
      controller: providerLogin!.controllerPassword,
      labelTitle: GlobalLabel.lblPassword,
      keyboardType: TextInputType.visiblePassword,
      inputFormatters: formattersPassword(),
      colorWhenFocus: true,
      hintText: '********',
      fontSize: 16,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      suffixIcon: Icon(
        providerLogin!.visiblePassword ? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined,
        color: ColorsPalette.colorPrimary,
      ),
      onTapSufixIcon: () {
        providerLogin!.visiblePassword = providerLogin!.visiblePassword ? false : true;
      },
      validator: (val) {
        String text = val!.trim();
        if (text.isEmpty) {
          return GlobalLabel.lblTextEnterPassword;
        }
        return null;
      },
    );
  }
}
