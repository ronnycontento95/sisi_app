///Import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../global/global.dart';
import '../global/global_formatters.dart';
import '../global/global_label.dart';
import '../global/global_palette.dart';
///Provider
import '../provider/provider_principal.dart';
///Utils

///Widgets
import '../widgets/widget_button_view.dart';
import '../widgets/widget_label_text.dart';
import '../widgets/widget_text_form_field.dart';


final _formKey = GlobalKey<FormState>();

class ScreenLogin extends StatelessWidget {
  ScreenLogin({Key? key}) : super(key: key);
  static const routePage = Global.routeScreenLogin;
  ProviderPrincipal? _providerPrincipal;

  @override
  Widget build(BuildContext context) {
    _providerPrincipal ??= Provider.of<ProviderPrincipal>(context);
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
                    ///TODO agregar icono return
                    // Align(
                    //   alignment: Alignment.topLeft,
                    //   child: WidgetBlackArrow(
                    //     callback: () {},
                    //   ),
                    // ),
                    const Image(
                      image: AssetImage("${Global.assetsLogo}logo-estandar.png"),
                      height: 40,
                      width: 200,
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        WidgetViewLabelText().labelTextTitle(
                            text: GlobalLabel.lblWelcome,
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            colortext: ColorsPalette.colorPrimary,
                            textAlign: TextAlign.center),
                      ],
                    ),
                    WidgetViewLabelText().labelTextNormal(text: GlobalLabel.lblSubWelcome, fontSize: 14, colortext: ColorsPalette.colorPrimary),
                    const SizedBox(
                      height: 25,
                    ),
                    contTextUser(),
                    contTextPassword(),
                    const SizedBox(height: 10),
                    if (_providerPrincipal!.errorMessage != null) ...[Text(_providerPrincipal!.errorMessage!)],
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
    return WidgetButtonView(
      text: "Ingresar",
      color: ColorsPalette.colorPrimary,
      onTap: () {
        // if (_formKey.currentState!.validate()) {
        _providerPrincipal!.login();
        // } else {
        // alertSimpleMessage(context, "¡Aviso!", "Revise que la información ingresada sea correcta e intente nuevamente.", textAccept: "Entendido");
        // }
      },
    );
  }

  Widget contTextUser() {
    return WidgetTextFormField(
      padding: const EdgeInsets.symmetric(vertical: 10),
      controller: _providerPrincipal!.controllerUser,
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
      obscureText: _providerPrincipal!.visiblePassword,
      controller: _providerPrincipal!.controllerPassword,
      labelTitle: GlobalLabel.lblPassword,
      keyboardType: TextInputType.visiblePassword,
      inputFormatters: formattersPassword(),
      colorWhenFocus: true,
      hintText: '********',
      fontSize: 16,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      suffixIcon: Icon(
        _providerPrincipal!.visiblePassword ? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined,
        color: ColorsPalette.colorPrimary,
      ),
      onTapSufixIcon: () {
        _providerPrincipal!.visiblePassword = _providerPrincipal!.visiblePassword ? false : true;
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
