import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../provider/provider_principal.dart';
import '../useful/useful_formatters.dart';
import '../useful/useful_label.dart';
import '../useful/useful_palette.dart';

import '../widgets/widget_button_view.dart';
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
          child: Stack(children: [
            Center(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: const Column(
                    children: [
                      TitleHeader(),
                      ContentUser(),
                      ContTextPassword(),
                      WidgetButtonLogin(),
                    ],
                  ),
                ),
              ),
            )
          ]),
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
}

class ContTextPassword extends StatelessWidget {
  const ContTextPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final providerPrincipal = context.watch<ProviderPrincipal>();

    return WidgetTextFormField(
      padding: const EdgeInsets.symmetric(vertical: 10),
      obscureText: providerPrincipal.visiblePassword,
      controller: providerPrincipal.editPassword,
      labelTitle: UsefulLabel.lblPassword,
      keyboardType: TextInputType.visiblePassword,
      inputFormatters: formattersPassword(),
      colorWhenFocus: true,
      hintText: '********',
      fontSize: 16,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      suffixIcon: Icon(
        providerPrincipal.visiblePassword
            ? Icons.remove_red_eye_outlined
            : Icons.visibility_off_outlined,
        color: UsefulColor.colorPrimary,
      ),
      onTapSufixIcon: () {
        providerPrincipal.visiblePassword =
            providerPrincipal.visiblePassword ? false : true;
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

class ContentUser extends StatelessWidget {
  const ContentUser({super.key});

  @override
  Widget build(BuildContext context) {
    final providerPrincipal = context.read<ProviderPrincipal>();
    return WidgetTextFormField(
      padding: const EdgeInsets.symmetric(vertical: 10),
      controller: providerPrincipal.editUser,
      labelTitle: UsefulLabel.lblUser,
      keyboardType: TextInputType.emailAddress,
      // inputFormatters: formattersUser(),
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
    ;
  }
}

class TitleHeader extends StatelessWidget {
  const TitleHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Image(image: AssetImage("${UsefulLabel.assetsImages}login.png")),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Text( UsefulLabel.lblWelcome, style: TextStyle(fontSize: 25))],
        ),
        Text( UsefulLabel.lblSubWelcome,),
        SizedBox(
          height: 10,
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
        InkWell(
          onTap: () {
            launchUrl(Uri.parse('http://34.122.67.202/terminos/'),
                mode: LaunchMode.externalApplication);
          },
          child: Align(
            alignment: Alignment.centerRight,
            child: Text( UsefulLabel.txtTemCond),
          ),
        ),
        const SizedBox(
          height: 10,
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
