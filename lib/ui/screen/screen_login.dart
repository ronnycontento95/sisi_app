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
          child: Stack(
            children : [
              Center(
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        const TitleHeader(),
                        contTextUser(),
                        contTextPassword(),
                        const WidgetButtonLogin(),
                      ],
                    ),
                  ),
                ),
              )

            ]
          ),
        ),
      ),
    );
  }

  Widget iconSocialMedia() {
    return const Row(
      children: [
        Icon(
          Icons.facebook,
          size: 20,
          color: Colors.blueAccent,
        ),
      ],
    );
  }

  Widget contTextUser() {
    return WidgetTextFormField(
      padding: const EdgeInsets.symmetric(vertical: 10),
      controller: _providerPrincipal!.editUser,
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
      controller: _providerPrincipal!.editPassword,
      labelTitle: UsefulLabel.lblPassword,
      keyboardType: TextInputType.visiblePassword,
      inputFormatters: formattersPassword(),
      colorWhenFocus: true,
      hintText: '********',
      fontSize: 16,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      suffixIcon: Icon(
        _providerPrincipal!.visiblePassword
            ? Icons.remove_red_eye_outlined
            : Icons.visibility_off_outlined,
        color: UsefulColor.colorPrimary,
      ),
      onTapSufixIcon: () {
        _providerPrincipal!.visiblePassword =
            _providerPrincipal!.visiblePassword ? false : true;
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

class TitleHeader extends StatelessWidget {
  const TitleHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WidgetViewLabelText().labelTextTitle(
                text: UsefulLabel.lblWelcome,
                fontSize: 40,
                fontWeight: FontWeight.bold,
                colortext: UsefulColor.colorPrimary,
                textAlign: TextAlign.center),
          ],
        ),
        WidgetViewLabelText().labelTextNormal(
            text: UsefulLabel.lblSubWelcome,
            fontSize: 14,
            colortext: UsefulColor.colorPrimary),
        const SizedBox(
          height: 150,
          child: Image(
            image: AssetImage("${UsefulLabel.assetsImages}background.jpg"),
          ),
        )
      ],
    );
  }
}

class WidgetButtonLogin extends StatelessWidget {
  const WidgetButtonLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prPrincipalRead = context.read<ProviderPrincipal>();
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: WidgetViewLabelText().labelTextNormal(
              text: UsefulLabel.txtTemCond,
              fontSize: 12,
              colortext: UsefulColor.colorPrimary),
        ),
        WidgetButtonView(
          text: UsefulLabel.txtLogin,
          color: UsefulColor.colorPrimary,
          onTap: () {
            prPrincipalRead.login(context);
          },
        ),

      ],
    );
  }
}
