class Api {
  final Environment env;
  Api({this.env = Environment.prod});

  baseUrl(String url) {
    switch (env) {
      case Environment.dev:
        return "dev_$url";
      case Environment.prod:
        return url;
      default:
    }
  }

  get users => baseUrl("users");
  get notes => baseUrl("notes");
  get closeCircle => baseUrl("close_circle");
  get config => "config";
}

enum Environment { dev, staging, prod }
