class ImageAssets {
  const ImageAssets();
  _png(file) => "assets/images/$file.png";
  _svg(file) => "assets/images/$file.svg";

  get flower => _png("flower");
  get blackWoman => _png("black_woman");

  get shape1 => _png("shape1");
  get shape2 => _png("shape2");
  get shape3 => _png("shape3");
  get blob1 => _png("blob1");
}

class IconAssets {
  const IconAssets();
  _png(file) => "assets/icons/$file.png";
  _svg(file) => "assets/icons/$file.svg";
  get target => _svg("Group 2");
  get people => _svg("people");
  get person => _svg("person");
  get around => _svg("around");
  get text => _svg("text");
  get gallery => _svg("gallery");
  get confetti => _png('confeti');
}
