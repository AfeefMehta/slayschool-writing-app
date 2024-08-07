import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      title: 'SlaySchool',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();

  bool _giveTextParaphrased = true;
  bool _isResultVisible = false;


  void _toggleResultsVisibility() {
    setState(() {
      _isResultVisible = !_isResultVisible;
    });
  }

  void _toggleParaphraseOption() {
    setState(() {
      _giveTextParaphrased = !_giveTextParaphrased;
    });
  }

  @override
  void initState() {
    super.initState();
    _inputController.addListener(_updateTextInfo);
    _outputController.addListener(_updateTextInfo);
  }

  @override
  void dispose() {
    _inputController.removeListener(_updateTextInfo);
    _inputController.dispose();

    _outputController.removeListener(_updateTextInfo);
    _outputController.dispose();

    super.dispose();
  }

  void _updateTextInfo() {
    setState(() {});
  }

  void _generateResult() {
    final charCount = _inputController.text.length;
    if (charCount >= 600) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color.fromRGBO(0, 78, 232, 1), width: 4.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: const Text('Character Limit Reached'),
          content: const Text('You have reached the character limit of 600. Please reduce the text before submitting.'),
          actions: <Widget>[
            Center(
              child: Column(
                children: [
                  const UpgradeButton(),
                  const SizedBox(height: 10),
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      _outputController.text = _inputController.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    final inputText = _inputController.text;
    final inputWordCount = inputText.isEmpty ? 0 : inputText.trim().split(RegExp(r'\s+')).length;
    final inputCharCount = inputText.length;

    final outputText = _outputController.text;
    final outputWordCount = outputText.isEmpty ? 0 : outputText.trim().split(RegExp(r'\s+')).length;
    final outputCharCount = outputText.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SLAY',
          style: TextStyle(color: Colors.white)
        ),
        backgroundColor: const Color.fromRGBO(0, 78, 232, 1),
        actions: const [
          AppBarIconButton(icon: Icons.create_rounded, tooltip: 'Writing'),
          AppBarIconButton(icon: Icons.add, tooltip: 'Upload'),
          AppBarIconButton(icon: Icons.people_alt_rounded, tooltip: 'Invite Friends'),
          UpgradeButton(),
        ],
      ),


      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      'Writing Assistant',
                      style: TextStyle(fontSize: 30,  fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(0, 78, 232, 1),
                      ),
                      child: const Text(
                        'Upload File',
                        style: TextStyle(
                          color: Colors.white,
                        )
                      )
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (!_giveTextParaphrased) {
                          _toggleParaphraseOption();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _giveTextParaphrased ? const Color.fromRGBO(0, 78, 232, 1) : const Color.fromRGBO(215, 217, 221, 1),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0),
                            topRight: Radius.zero,
                            bottomRight: Radius.zero,
                          ),
                          side: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          )
                        ),
                      ),
                      child: Text(
                        'Paraphrase it',
                        style: TextStyle(
                          color: _giveTextParaphrased ? const Color.fromRGBO(215, 217, 221, 1) : const Color.fromRGBO(0, 78, 232, 1),
                          fontWeight: FontWeight.bold
                        )
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_giveTextParaphrased) {
                          _toggleParaphraseOption();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _giveTextParaphrased ? const Color.fromRGBO(215, 217, 221, 1) : const Color.fromRGBO(0, 78, 232, 1),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.zero,
                            bottomLeft: Radius.zero,
                            topRight: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0),
                          ),
                          side: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          )
                        ),
                      ),
                      child: Text(
                        'Keep it Professional',
                        style: TextStyle(
                          color: _giveTextParaphrased ? const Color.fromRGBO(0, 78, 232, 1) : const Color.fromRGBO(215, 217, 221, 1),
                          fontWeight: FontWeight.bold
                        )
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: _generateResult,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(0, 78, 232, 1),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                        )
                      ),
                      child: const Text(
                        'SLAY IT!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )
                      )
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: _toggleResultsVisibility,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0, 78, 232, 1),
                  ),
                  child: Text(
                    _isResultVisible ? 'Hide Results' : 'Show Results',
                    style: const TextStyle(
                      color: Colors.white,
                    )
                  )
                ),
              ],
            ),
          ),



          Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.only(right: _isResultVisible ? MediaQuery.of(context).size.width / 2 : 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              width: MediaQuery.of(context).size.width * 0.9 > 650 
                                ? 650 
                                : MediaQuery.of(context).size.width * 0.9,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: const Text(
                                'Transform the Text below by pressing SLAY IT!',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9 > 650
                                ? 650 
                                : MediaQuery.of(context).size.width * 0.9,
                              padding: const EdgeInsets.only(top: 50),
                              height: MediaQuery.of(context).size.height * 0.70,
                              child: TextField(
                                controller: _inputController,
                                maxLines: null,
                                textAlignVertical: TextAlignVertical.top,
                                decoration: const InputDecoration(
                                  hintText: 'Enter text here...',
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9 > 650 
                                ? 650 
                                : MediaQuery.of(context).size.width * 0.9,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Words: $inputWordCount'), 
                                  Text(
                                    'Characters: $inputCharCount',
                                    style: TextStyle(
                                      color: inputCharCount >= 600 ? Colors.red : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),


              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                right: _isResultVisible ? 0 : -MediaQuery.of(context).size.width / 2,
                top: 0,
                bottom: 0,
                child: Container(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  width: MediaQuery.of(context).size.width / 2,
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width * 0.9 > 650 
                          ? 650 
                          : MediaQuery.of(context).size.width * 0.9,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: const Text(
                          'View your results here!',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 50),
                        width: MediaQuery.of(context).size.width * 0.9 > 650 
                          ? 650 
                          : MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.70,
                        child: TextField(
                          controller: _outputController,
                          maxLines: null,
                          textAlignVertical: TextAlignVertical.top,
                          decoration: const InputDecoration(
                            hintText: 'Enter text here...',
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9 > 650 
                          ? 650 
                          : MediaQuery.of(context).size.width * 0.9,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Words: $outputWordCount'),
                            Text(
                              'Characters: $outputCharCount',
                              style: TextStyle(
                                color: outputCharCount >= 600 ? Colors.red : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AppBarIconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;

  const AppBarIconButton({
    required this.icon,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: IconButton(
        onPressed: () {},
        icon: Icon(icon, color: Colors.white),
        tooltip: tooltip,
      ),
    );
  }
}

class UpgradeButton extends StatelessWidget {
  const UpgradeButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
      child: const Text(
        'Upgrade',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}



