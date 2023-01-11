abstract class AudioService {
  initialise();
  record();
  stop();
  pause();
  play({required String source,required String url});
  uploadToDB(String audio);
}
