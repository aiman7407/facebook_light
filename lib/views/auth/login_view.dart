import 'package:conditional_builder/conditional_builder.dart';
import 'package:facebook_light/blocs/login/login_cubit.dart';
import 'package:facebook_light/components/buttons.dart';
import 'package:facebook_light/components/custom_toast.dart';
import 'package:facebook_light/components/text_field.dart';
import 'package:facebook_light/service/cache/cache_helper.dart';
import 'package:facebook_light/service/cache/cache_keys.dart';
import 'package:facebook_light/src/constants.dart';
import 'package:facebook_light/views/auth/register_view.dart';
import 'package:facebook_light/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginErrorState)
          showToast(
              toastStates: ToastStates.ERROR, msg: state.error.toString());

        if(state is LoginSuccessState) {
          CacheHelper.saveData(key: CACHE_KEY_USER_ID, value: state.userId).then((value) {
            navigateAndFinish(screen: HomeView(),context:context );
          });
        }

      },
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: Colors.black),
                      ),
                      Text(
                        'Login now to Connect With Your Friends',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'please enter you email';
                            }
                          },
                          label: 'Email',
                          prefixIcon: Icons.email_outlined),
                      SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                        obscureText: cubit.isPasswordShown,
                        controller: passwordController,
                        textInputType: TextInputType.visiblePassword,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'please enter you password';
                          }
                        },
                        label: 'Password',
                        prefixIcon: Icons.lock_outline,
                        suffix: cubit.suffix,
                        suffixAction: () {
                          cubit.changePasswordVisibility();
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => DefaultButton(
                                fontSize: 20.0,
                                text: 'Login'.toUpperCase(),
                                action: () {
                                  if (formKey.currentState.validate()) {
                                    LoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                              ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator())),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account ?'),
                          DefaultTextButton(
                            text: 'register'.toUpperCase(),
                            action: () {
                              navigateTo(
                                  context: context, screen: RegisterView());
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
