import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imageria/src/constants/constants.dart';
import 'package:imageria/src/providers/connectivity_provider.dart';
import 'package:imageria/src/repositories/network_image_file.dart';
import 'package:imageria/src/repositories/user_repository.dart';
import 'package:imageria/src/widgets/image_card.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final imgUrl;
  DetailScreen({@required this.imgUrl});
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  UserRepository _userRepository = new UserRepository();
  ImageTofileRepository _imageTofileRepository = new ImageTofileRepository();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    final connectivityProvider = Provider.of<ConnectivityProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Detail Screen",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: Stack(
        children: [
          Container(
            width: width,
            height: height,
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width * 0.02),
                  child: ImageCard(imgUrl: widget.imgUrl),
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          //   height: height * 0.05,
                          width: width,
                          margin:
                              EdgeInsets.symmetric(horizontal: width * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("First Name"),
                              Container(
                                width: width * 0.6,
                                margin: EdgeInsets.symmetric(
                                    horizontal: width * 0.05),
                                child: TextFormField(
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    letterSpacing: 1.5,
                                  ),
                                  decoration: InputDecoration(
                                    //  prefixIcon: Icon(FontAwesomeIcons.envelope, size: 20),

                                    filled: true,
                                    fillColor: Color(0xFFF2F2F2),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6)),
                                        borderSide: BorderSide(
                                            width: 1, color: primaryBlue)),

                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: primaryBlue,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6)),
                                        borderSide: BorderSide(
                                            width: 1, color: primaryBlue)),

                                    isDense: true,
                                    contentPadding: EdgeInsets.all(10),
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFFB3B1B1),
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'First Name is required';
                                    }
                                    return null;
                                  },
                                  controller: _firstName,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Container(
                          //  height: height * 0.05,
                          width: width,
                          margin:
                              EdgeInsets.symmetric(horizontal: width * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Last Name"),
                              Container(
                                width: width * 0.6,
                                margin: EdgeInsets.symmetric(
                                    horizontal: width * 0.05),
                                child: TextFormField(
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    letterSpacing: 1.5,
                                  ),
                                  decoration: InputDecoration(
                                    //  prefixIcon: Icon(FontAwesomeIcons.envelope, size: 20),
                                    filled: true,
                                    fillColor: Color(0xFFF2F2F2),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6)),
                                        borderSide: BorderSide(
                                            width: 1, color: primaryBlue)),

                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: primaryBlue,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6)),
                                        borderSide: BorderSide(
                                            width: 1, color: primaryBlue)),

                                    isDense: true,
                                    contentPadding: EdgeInsets.all(10),
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFFB3B1B1),
                                      letterSpacing: 1.5,
                                    ),
                                    //errorText: snapshot.error,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Last Name is required';
                                    }
                                    return null;
                                  },
                                  controller: _lastName,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Container(
                          //    height: height * 0.05,
                          width: width,
                          margin:
                              EdgeInsets.symmetric(horizontal: width * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Email"),
                              Container(
                                width: width * 0.6,
                                margin: EdgeInsets.symmetric(
                                    horizontal: width * 0.05),
                                child: TextFormField(
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    letterSpacing: 1.5,
                                  ),
                                  decoration: InputDecoration(
                                    //  prefixIcon: Icon(FontAwesomeIcons.envelope, size: 20),
                                    filled: true,
                                    fillColor: Color(0xFFF2F2F2),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6)),
                                        borderSide: BorderSide(
                                            width: 1, color: primaryBlue)),

                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: primaryBlue,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6)),
                                        borderSide: BorderSide(
                                            width: 1, color: primaryBlue)),

                                    isDense: true,
                                    contentPadding: EdgeInsets.all(10),
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFFB3B1B1),
                                      letterSpacing: 1.5,
                                    ),
                                    //errorText: snapshot.error,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Email is required';
                                    } else if (!EmailValidator.validate(
                                        value)) {
                                      return "Please enter a correct email address";
                                    }
                                    return null;
                                  },
                                  controller: _email,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Container(
                          //  height: height * 0.05,
                          width: width,
                          margin:
                              EdgeInsets.symmetric(horizontal: width * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Phone"),
                              Container(
                                width: width * 0.6,
                                margin: EdgeInsets.symmetric(
                                    horizontal: width * 0.05),
                                child: TextFormField(
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    letterSpacing: 1.5,
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  decoration: InputDecoration(
                                    //  prefixIcon: Icon(FontAwesomeIcons.envelope, size: 20),
                                    filled: true,
                                    fillColor: Color(0xFFF2F2F2),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6)),
                                        borderSide: BorderSide(
                                            width: 1, color: primaryBlue)),

                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: primaryBlue,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6)),
                                        borderSide: BorderSide(
                                            width: 1, color: primaryBlue)),

                                    isDense: true,
                                    contentPadding: EdgeInsets.all(10),
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFFB3B1B1),
                                      letterSpacing: 1.5,
                                    ),
                                    //errorText: snapshot.error,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Phone Number is required';
                                    }
                                     if (value.length != 10) {
                                      return 'Please enter a correct phone number';
                                    }
                                    return null;
                                  },
                                  controller: _phone,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Container(
                          height: height * 0.1,
                          width: width,
                          margin:
                              EdgeInsets.symmetric(horizontal: width * 0.065),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    connectivityProvider
                                        .checkInternet()
                                        .then((hasInternet) {
                                      if (hasInternet) {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        _imageTofileRepository
                                            .fileFromImageUrl(
                                                imgUrl: widget.imgUrl)
                                            .then((imgFile) {
                                          print(imgFile.path);

                                         _userRepository
                                              .saveUser(
                                                  firstName: _firstName.text,
                                                  lastName: _lastName.text,
                                                  email:
                                                      _email.text.toLowerCase(),
                                                  phoneNumber: _phone.text,
                                                  image: imgFile,
                                                  imageName: imgFile.path
                                                      .split('/')
                                                      .last)
                                              .then((res) {
                                            if (res.status == "success") {
                                              setState(() {
                                                _firstName.text = "";
                                                _lastName.text = "";
                                                _email.text = "";
                                                _phone.text = "";
                                                isLoading = false;
                                              });
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                    content: Text(res.message
                                                        .toString())),
                                              );
                                            } else {
                                              setState(() {
                                                isLoading = false;
                                              });
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                    content: Text(res.message
                                                        .toString())),
                                              );
                                            }
                                          });
                                        });
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                          "No internet connectivity found",
                                        )));
                                      }
                                    });
                                  }
                                },
                                child: Container(
                                  margin:
                                      EdgeInsets.only(bottom: height * 0.05),
                                  height: 40,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.1),
                                  decoration: BoxDecoration(
                                      gradient: buttonBgGradient,
                                      borderRadius: BorderRadius.circular(25),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 3,
                                            color: Colors.grey,
                                            offset: Offset(0, 2),
                                            spreadRadius: 2)
                                      ]),
                                  child: Center(
                                      child: Text(
                                    "Submit",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
          isLoading
              ? Container(
                  width: width,
                  height: height,
                  color: Colors.grey.withOpacity(0.5),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
