import 'dart:io';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

class Classifier{
  Classifier();

  classifyImage(var image)async{
    var inputImage = File(image.path);

    ImageProcessor imageProcessor = ImageProcessorBuilder()
                                    .add(ResizeOp(300,300, ResizeMethod.BILINEAR))
                                    .add(NormalizeOp(0, 255))
                                    .build();

    TensorImage tensorImage = TensorImage.fromFile(inputImage);
    tensorImage = imageProcessor.process(tensorImage);
    
    TensorBuffer probablityBuffer = TensorBuffer.createFixedSize(<int>[1,6], TfLiteType.float32);


    try {
      Interpreter interpreter = await Interpreter.fromAsset("model.tflite");
      interpreter.run(tensorImage.buffer, probablityBuffer.buffer);
    }
    catch(e){
      print("Error loading or running model");
    }

    List<String> labels = await FileUtil.loadLabels("assets/models/labels.txt");
    SequentialProcessor<TensorBuffer> probabilityProcessor =
                TensorProcessorBuilder().build();
    TensorLabel tensorLabel = TensorLabel.fromList(
      labels, probabilityProcessor.process(probablityBuffer));

    Map labledProb = tensorLabel.getMapWithFloatValue();
    double highestProb = 0;
    String shoeName="";

    labledProb.forEach((Name, probability) { 
      if(probability*100 > highestProb){
        highestProb = probability*100;
        shoeName = Name;
      }
    });

    var outputProb = highestProb.toStringAsFixed(1);
    return [shoeName, outputProb];
  }

}