import 'package:example/group_demo_widget.dart';
import 'package:fl_form/formfield/fl_avatar_form_field.dart';
import 'package:fl_form/formfield/fl_raw_avatar_form_field.dart';
import 'package:flutter/material.dart';

class AvatarFormFieldPage extends StatelessWidget {
  const AvatarFormFieldPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GroupDemoWidget(
              title: 'Default',
              children: [
                FlAvatarFormField(label: "Choose your avatar"),
                const SizedBox(height: 32),
                FlAvatarFormField(label: "Choose your avatar", radius: 56),
                const SizedBox(height: 32),
                FlAvatarFormField(
                  label: "Choose your avatar",
                  radius: 64,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) {
                    if (value == null) {
                      return 'Need update your avatar';
                    }
                    return null;
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            GroupDemoWidget(
              title: 'Customize',
              children: [
                Center(
                  child: FlRawAvatarFormField(
                    builder: ({required context, data, required didChange, error}) {
                      if (data == null) {
                        return GestureDetector(
                          onTap: () {
                            FlRawAvatarFormField.pickFile().then((value) {
                              if (value != null) {
                                didChange(value);
                              }
                            });
                          },
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(12)),
                          ),
                        );
                      } else {
                        if (data.file != null) {
                          return Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(fit: BoxFit.cover, image: FileImage(data.file!)),
                            ),
                          );
                        } else {
                          return Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(data.link!)),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
