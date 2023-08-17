import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
void main() {
 runApp(const TexttoSpeech());
}
class TexttoSpeech extends StatelessWidget {
 const TexttoSpeech({super.key});
 @override
 Widget build(BuildContext context) {
 return const MaterialApp(
 home:MyTexttoSpeech(),
 );
 }
}
class MyTexttoSpeech extends StatefulWidget {
 const MyTexttoSpeech({super.key});
 @override
 State<MyTexttoSpeech> createState() => _MyTexttoSpeechState();
}
class _MyTexttoSpeechState extends State<MyTexttoSpeech> {
 TextEditingController readText=TextEditingController();
 @override
 Widget build(BuildContext context) {
 return Scaffold(
 appBar: AppBar(
 title: Text("Text To Speech"),
 backgroundColor: Colors.green,
KEERTHANA C G 10
 ),
 body:Column(
 children:[
 TextField(
 controller:readText,
 decoration: const InputDecoration(hintText:"Enter the text"),
 ),
 ElevatedButton(onPressed:ConvertTTs, child: Text("Convert Text to
Speech",style:TextStyle(fontSize:20),),),
 ],
 ),
 );
 }
 void ConvertTTs ()
 {
 FlutterTts tts=FlutterTts();
 tts.setLanguage("en-IN");
 tts.speak(readText.text);
tts.setPitch(50);
 }
}