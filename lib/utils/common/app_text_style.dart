import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_font.dart';

ButtonStyle getButtonStyle(context)=>ElevatedButton.styleFrom(primary: Color(0xff4889FD),shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(18)),);
ButtonStyle AppointmentbuttonStyle(context)=>ElevatedButton.styleFrom(primary: Color(0xff4889FD),shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(5)),);
ButtonStyle CancelbuttonStyle(context)=>ElevatedButton.styleFrom(primary: Colors.white,shape: RoundedRectangleBorder(side: BorderSide(
    color: Theme.of(context).primaryColor
),borderRadius:BorderRadius.circular(5),),);

TextStyle TextHeadingStyle(context)=>(GoogleFonts.roboto(
    textStyle: const TextStyle(
        fontWeight: AppFont.fontWeightMedium,
        color: Color(0xff4889fd),
        fontSize: 25)
));
TextStyle TextParaStyle(context)=>(GoogleFonts.roboto(
    textStyle: TextStyle(
        fontWeight: AppFont.fontWeightRegular,
        fontSize: 13,
        color: Colors.black.withOpacity(0.6),

    )));
TextStyle TextButtonStyle(context)=> (GoogleFonts.roboto(textStyle:TextStyle(fontSize: 20,color:Colors.white)));
TextStyle TextCancelButtonStyle(context)=> (GoogleFonts.roboto(textStyle:TextStyle(fontSize: 20),color: Color(0xffFF6464)));
TextStyle TextFieldStyle(context)=> (GoogleFonts.quicksand(textStyle:TextStyle(fontSize: 20),color: Colors.grey,fontWeight: AppFont.fontWeightMedium));
TextStyle TextResendStyle(context)=>(TextStyle(fontSize: 16,fontWeight: AppFont.fontWeightMedium,color: Color(0xff4889FD)));
TextStyle TextMainHeading(context)=>(GoogleFonts.rubik(textStyle:TextStyle(fontWeight: AppFont.fontWeightMedium,fontSize: 25,color: Colors.white),));
TextStyle TextMainsubtitle(context)=>(GoogleFonts.quicksand(textStyle:  TextStyle(color: Color(0xff5B5B5B),fontSize:  25,fontWeight:AppFont.fontWeightBold),));
TextStyle TextForgetStyle(context)=>( GoogleFonts.quicksand(textStyle: const TextStyle(color: Colors.grey,fontSize: 15)));
TextStyle RichtextStyle(context)=>( GoogleFonts.quicksand(textStyle:  TextStyle(color: Colors.blueAccent,fontSize: 15)));
TextStyle NameStyle(context)=>(GoogleFonts.roboto(textStyle: TextStyle(fontWeight: AppFont.fontWeightRegular,fontSize: 22),color: Color(0xffF6F6F6)));
TextStyle SpecialistStyle(context)=>(GoogleFonts.roboto(textStyle: TextStyle(fontWeight: AppFont.fontWeightRegular,fontSize: 13),color: Color(0xffF6F6F6)));
TextStyle ExpStyle(context)=>(GoogleFonts.roboto(textStyle: TextStyle(fontWeight: AppFont.fontWeightExtraBold,fontSize: 13),color: Color(0xffF6F6F6)));
TextStyle BiographyStyle(context)=>(GoogleFonts.roboto(textStyle: TextStyle(fontWeight: AppFont.fontWeightBold,fontSize: 15),color: Color(0xff4889FD)));
TextStyle BioParaStyle(context)=>(GoogleFonts.roboto(textStyle:TextStyle(fontWeight: AppFont.fontWeightMedium,fontSize: 13),));
TextStyle DateTitleStyle(context)=>(GoogleFonts.roboto(textStyle: TextStyle(fontWeight: AppFont.fontWeightRegular,fontSize: 22),));
TextStyle monthStyle(context)=>(GoogleFonts.roboto(textStyle: TextStyle(fontWeight: AppFont.fontWeightRegular,fontSize: 14)));
TextStyle PrescriptionSpecialist(context)=>(GoogleFonts.roboto(textStyle: TextStyle(fontWeight: AppFont.fontWeightRegular,fontSize: 14,color: Color(0xff6B779A))));
TextStyle TimeStyle(context)=>(GoogleFonts.roboto(textStyle: TextStyle(fontWeight: AppFont.fontWeightRegular,fontSize: 13)));
TextStyle DateContainerStyle(context)=>(GoogleFonts.roboto(textStyle: TextStyle(fontWeight: AppFont.fontWeightSemiBold,fontSize: 14),color:Colors.black.withOpacity(0.5)));
TextStyle DateContainer1Style(context)=>(GoogleFonts.roboto(textStyle: TextStyle(fontWeight: AppFont.fontWeightMedium,fontSize: 14),color:Colors.black));
TextStyle AddressStyle(context)=>(GoogleFonts.roboto(textStyle: TextStyle(fontWeight: AppFont.fontWeightRegular,fontSize: 15),color:Colors.black.withOpacity(0.7)));
TextStyle AttentionStyle(context)=>(GoogleFonts.roboto(textStyle: TextStyle(fontWeight: AppFont.fontWeightRegular,fontSize: 14),color:Colors.blueAccent));
TextStyle GetdirectionStyle(context)=>(GoogleFonts.roboto(textStyle: TextStyle(fontWeight: AppFont.fontWeightRegular,fontSize: 14),color:Color(0xff4889FD)));
TextStyle ViewMoreStyle(context)=>(GoogleFonts.roboto(textStyle: TextStyle(fontWeight: AppFont.fontWeightSemiBold,fontSize: 15),color:Colors.white));
TextStyle Dr_nameinMy_doctor(context)=>(GoogleFonts.roboto(textStyle: TextStyle(fontWeight: AppFont.fontWeightSemiBold,fontSize: 25),color:Colors.black));
TextStyle SpecialistStylenew(context)=>(GoogleFonts.roboto(textStyle: TextStyle(fontWeight: AppFont.fontWeightRegular,fontSize: 17),color:Colors.grey));
TextStyle ProfileStyle(context)=>(GoogleFonts.roboto(textStyle: TextStyle(fontSize: 25,color: Colors.white)));
TextStyle PrescriptionStyle(context)=>(GoogleFonts.roboto(fontWeight: FontWeight.w300,fontSize: 28));
TextStyle DoctorByName(context)=>(GoogleFonts.roboto(fontWeight: FontWeight.w300,fontSize: 20));
TextStyle GoodmornTitle(context)=>(GoogleFonts.lato(fontSize: 28,fontWeight: FontWeight.w900,color: Colors.white));
TextStyle Tempstyle(context)=>(GoogleFonts.lato(fontWeight: FontWeight.w900,fontSize: 30));
TextStyle Fahrenheitestyle(context)=>(GoogleFonts.lato(fontWeight: FontWeight.w900,fontSize: 20));
TextStyle Heartbeatstyle(context)=>(GoogleFonts.lato(fontWeight: FontWeight.w400,fontSize: 14,color: Color(0xff102A43)));
TextStyle Bpmstyle(context)=>(GoogleFonts.lato(fontWeight: FontWeight.w400,fontSize: 17));
TextStyle YoudailyMedicationstyle(context)=>(GoogleFonts.lato(fontSize: 15,fontWeight: FontWeight.w700,color: Color(0xff486581)));
TextStyle bloodpressureTimestyle(context)=>(GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 15,color: Color(0xff486581)));
TextStyle bloodpressureTitlestyle(context)=>(GoogleFonts.lato(fontSize: 15,fontWeight: FontWeight.w700,color: Color(0xff102A43)));
TextStyle healthRecordstyle(context)=>(GoogleFonts.lato(fontSize: 17,fontWeight: FontWeight.w700,color: Color(0xff102A43)));
TextStyle? getStyleDisplay3(context) => Theme.of(context).textTheme.headline3;