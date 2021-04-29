import 'package:flutterrestaurant/api/psk_apis.dart';
import 'package:flutterrestaurant/config/ps_colors.dart';
import 'package:flutterrestaurant/constant/ps_dimens.dart';
import 'package:flutterrestaurant/utils/utils.dart';
import 'package:flutter/material.dart';

class OurServicesTileView extends StatefulWidget {
  @override
  _OurServicesTileViewState createState() => _OurServicesTileViewState();
}

class _OurServicesTileViewState extends State<OurServicesTileView> {
  List<String> ourServices = [
    'Birthday Parties',
    'Corporate Events',
    'Kitty Parties',
    'Marriage Catering',
    'Tiffin Services'
  ];
  String _selectedService = 'Birthday Parties';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Widget _expansionTileTitleWidget = Text(
        Utils.getString(context, 'home__menu_drawer_our_services'),
        style: Theme.of(context).textTheme.subtitle1);

    return Container(
      margin: const EdgeInsets.only(
          left: PsDimens.space12,
          right: PsDimens.space12,
          bottom: PsDimens.space12),
      decoration: BoxDecoration(
        color: PsColors.backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(PsDimens.space8)),
      ),
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  getSizedBox15Height(),
                  getTitleText('Birthday Parties'),
                  getSizedBox15Height(),
                  Container(
                    height: 240,
                    child: ListView(
                      shrinkWrap: true,
                      // This next line does the trick.
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Image.asset('assets/images/services/birthday1.jpg'),
                        getSizedBox15Width(),
                        Image.asset('assets/images/services/birthday2.jpg'),
                        getSizedBox15Width(),
                        Image.asset('assets/images/services/birthday3.jpg'),
                        getSizedBox15Width(),
                        Image.asset('assets/images/services/birthday4.jpg'),
                        getSizedBox15Width(),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  getSizedBox15Height(),
                  getTitleText('Corporate Events'),
                  getSizedBox15Height(),
                  Container(
                    height: 240,
                    child: ListView(
                      shrinkWrap: true,
                      // This next line does the trick.
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Image.asset('assets/images/services/corporate1.jpg'),
                        getSizedBox15Width(),
                        Image.asset('assets/images/services/corporate2.jpg'),
                        getSizedBox15Width(),
                        Image.asset('assets/images/services/corporate3.jpg'),
                        getSizedBox15Width(),
                        Image.asset('assets/images/services/corporate4.jpg'),
                        getSizedBox15Width(),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  getSizedBox15Height(),
                  getTitleText('Kitty Parties'),
                  getSizedBox15Height(),
                  Container(
                    height: 240,
                    child: ListView(
                      shrinkWrap: true,
                      // This next line does the trick.
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Image.asset('assets/images/services/kitty1.jpg'),
                        getSizedBox15Width(),
                        Image.asset('assets/images/services/kitty2.jpg'),
                        getSizedBox15Width(),
                        Image.asset('assets/images/services/kitty3.jpg'),
                        getSizedBox15Width(),
                        Image.asset('assets/images/services/kitty4.jpg'),
                        getSizedBox15Width(),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  getSizedBox15Height(),
                  getTitleText('Marriage Catering'),
                  getSizedBox15Height(),
                  Container(
                    height: 240,
                    child: ListView(
                      shrinkWrap: true,
                      // This next line does the trick.
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Image.asset('assets/images/services/marriage1.jpg'),
                        getSizedBox15Width(),
                        Image.asset('assets/images/services/marriage2.jpg'),
                        getSizedBox15Width(),
                        Image.asset('assets/images/services/marriage3.jpg'),
                        getSizedBox15Width(),
                        Image.asset('assets/images/services/marriage4.jpg'),
                        getSizedBox15Width(),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  getSizedBox15Height(),
                  getTitleText('Tiffin Services'),
                  getSizedBox15Height(),
                  Container(
                    height: 240,
                    child: ListView(
                      shrinkWrap: true,
                      // This next line does the trick.
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Image.asset('assets/images/services/tiffin1.jpg'),
                        getSizedBox15Width(),
                        Image.asset('assets/images/services/tiffin2.jpeg'),
                        getSizedBox15Width(),
                        Image.asset('assets/images/services/tiffin3.jpg'),
                        getSizedBox15Width(),
                        Image.asset('assets/images/services/tiffin4.jpg'),
                        getSizedBox15Width(),
                      ],
                    ),
                  ),
                ],
              ),
              getSizedBox15Height(),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: RaisedButton(
                  onPressed: () {
                    _showDialog();
                  },
                  child: Text(
                    'Enquiry',
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                          fontWeight: FontWeight.bold,
                          color: PsColors.textPrimaryDarkColor,
                        ),
                  ),
                ),
              ),
              getSizedBox15Height(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getTitleText(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline6.copyWith(
          fontWeight: FontWeight.bold, color: PsColors.textPrimaryDarkColor),
    );
  }

  Widget getSizedBox15Width() {
    return const SizedBox(
      width: 15,
    );
  }

  Widget getSizedBox15Height() {
    return const SizedBox(
      height: 15,
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Column(
            children: <Widget>[
              Icon(
                Icons.info_outline,
                size: 40,
              ),
              const Text(
                'Enquiry Now',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width / 1.2,
              margin: MediaQuery.of(context).viewInsets,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // ignore: always_specify_types
                children: [
                  Container(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 1.5,
                            style: BorderStyle.solid,
                            color: Colors.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                      ),
                    ),
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: _selectedService,
                      items: ourServices
                          .map((String label) => DropdownMenuItem<String>(
                                child: Text(label),
                                value: label,
                              ))
                          .toList(),
                      decoration: InputDecoration(
                          labelText: 'Our Services',
                          labelStyle: const TextStyle(fontSize: 18),
                          filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none),
                      hint: const Text(''),
                      onChanged: (String value) {
                        setState(() {
                          print('new value : $value');
                          _selectedService = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                        hintText: 'Please enter name',
                        border: OutlineInputBorder(),
                        labelText: 'Name'),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _mobileController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                        hintText: 'Please enter mobile',
                        border: OutlineInputBorder(),
                        labelText: 'Mobile'),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                        hintText: 'Please enter email',
                        border: OutlineInputBorder(),
                        labelText: 'Email'),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _messageController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    maxLines: 3,
                    decoration: const InputDecoration(
                        hintText: 'Please enter message',
                        border: OutlineInputBorder(),
                        labelText: 'Message'),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            Row(
              children: <Widget>[
                FlatButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                    onPressed: () async {
                      if (_nameController.text == null &&
                          _nameController.text.isEmpty) {
                        Utils.showToast('Please enter name');
                        return;
                      }

                      if (_mobileController.text == null &&
                          _mobileController.text.isEmpty) {
                        Utils.showToast('Please enter mobile number');
                        return;
                      }

                      if (_emailController.text == null &&
                          _emailController.text.isEmpty) {
                        Utils.showToast('Please enter email');
                        return;
                      }

                      if (_messageController.text == null &&
                          _messageController.text.isEmpty) {
                        Utils.showToast('Please enter email');
                        return;
                      }

                      final Future<bool> enquiryOurServices =
                          PskApiUtils.enquiryOurServices(
                              service: _selectedService.toString().trim(),
                              name: _nameController.text.toString().trim(),
                              mobile: _mobileController.text.toString().trim(),
                              email: _emailController.text.toString().trim(),
                              message:
                                  _messageController.text.toString().trim());

                      enquiryOurServices.then((bool response) {
                        if (response) {
                          setState(() {
                            _nameController.text = '';
                            _mobileController.text = '';
                            _emailController.text = '';
                            _messageController.text = '';
                          });

                          Utils.showToast('Enquiry save successfully');
                        } else {
                          Utils.showToast('Error occurred');
                        }
                      });

                      Navigator.of(context).pop();
                    },
                    child: const Text('SUBMIT'))
              ],
            ),
          ],
        );
      },
    );
  }
}
