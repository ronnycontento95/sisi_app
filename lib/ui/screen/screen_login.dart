///Import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///Provider
import '../provider/provider_principal.dart';
import '../useful/useful_formatters.dart';
import '../useful/useful_label.dart';
import '../useful/useful_palette.dart';
///Useful

///Widgets
import '../widgets/widget_button_view.dart';
import '../widgets/widget_label_text.dart';
import '../widgets/widget_text_form_field.dart';


final _formKey = GlobalKey<FormState>();

class ScreenLogin extends StatelessWidget {
  ScreenLogin({Key? key}) : super(key: key);
  static const routePage = UsefulLabel.routeScreenLogin;
  ProviderPrincipal? _providerPrincipal;

  @override
  Widget build(BuildContext context) {
    _providerPrincipal ??= Provider.of<ProviderPrincipal>(context);
    return AnnotatedRegion(
      value: UsefulColor.colorWhite,
      child: Scaffold(
        backgroundColor: UsefulColor.colorWhite,
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WidgetViewLabelText().labelTextTitle(
                          text: UsefulLabel.lblWelcome,
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          colortext: UsefulColor.colorPrimary,
                          textAlign: TextAlign.center),
                    ],
                  ),
                  WidgetViewLabelText().labelTextNormal(text: UsefulLabel.lblSubWelcome, fontSize: 14, colortext: UsefulColor.colorPrimary),
                  const SizedBox(
                    height: 25,
                  ),
                  contTextUser(),
                  contTextPassword(),
                  const SizedBox(height: 10),
                  if (_providerPrincipal!.errorMessage != null) ...[Text(_providerPrincipal!.errorMessage!)],
                  widgetButonLogin(context),
                  WidgetViewLabelText().labelTextNormal(text: "Terminos y condiciones", fontSize: 14, colortext: UsefulColor.colorPrimary),
                  // iconSocialMedia(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget iconSocialMedia(){
    return const Row(
      children: [
        Icon(Icons.facebook, size: 20, color: Colors.blueAccent,),
      ],
    );
  }

  Widget widgetButonLogin(BuildContext context) {
    return WidgetButtonView(
      text: "Ingresar",
      color: UsefulColor.colorPrimary,
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
      labelTitle: UsefulLabel.lblUser,
      keyboardType: TextInputType.emailAddress,
      inputFormatters: formattersUser(),
      hintText: 'Ingrese su usuario',
      fontSize: 16,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      colorWhenFocus: true,
      validator: (val) {
        String text = val!.trim();
        if (text.isEmpty) {
          return UsefulLabel.lblTextEnterUser;
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
      labelTitle: UsefulLabel.lblPassword,
      keyboardType: TextInputType.visiblePassword,
      inputFormatters: formattersPassword(),
      colorWhenFocus: true,
      hintText: '********',
      fontSize: 16,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      suffixIcon: Icon(
        _providerPrincipal!.visiblePassword ? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined,
        color: UsefulColor.colorPrimary,
      ),
      onTapSufixIcon: () {
        _providerPrincipal!.visiblePassword = _providerPrincipal!.visiblePassword ? false : true;
      },
      validator: (val) {
        String text = val!.trim();
        if (text.isEmpty) {
          return UsefulLabel.lblTextEnterPassword;
        }
        return null;
      },
    );
  }
}
