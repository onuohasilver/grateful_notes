abstract class GratitudeService {
  createGratitude(
      {required List<String> text,
      required List<String> images,
      required String type,
      required String userid});

  getGratitudes({
    required String userid,
  });
}
