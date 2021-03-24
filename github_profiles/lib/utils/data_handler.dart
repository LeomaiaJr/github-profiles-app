import 'package:github_profiles/models/user.dart';
import 'package:github_profiles/utils/networking.dart';

class DataHandler {
  final dynamic userData;

  DataHandler(this.userData);

  Future<User> getUserData() async {
    User user = User();
    var data = this.userData;
    if (data["message"] != "Not Found") {
      //If user exist
      NetworkHelper networkHelper = NetworkHelper();
      //Get Repos Data
      var repos = await networkHelper.get(data["login"] + "/repos");
      var repo = []; //"index" of repos is stored here
      Map<int, Map<String, String>> topRepos = {};
      for (var i = 0; i < repos.length; i++) {
        repo.add(
          repos[i]["forks"] + repos[i]["stargazers_count"],
        );
      }
      var r = [...repo]; //List with the best to worse repos
      r.sort((b, a) => a.compareTo(b));
      for (var i = 0; i < repo.length; i++) { //.length thinking about a user with less than 4 repos
        if (i == 4) { //Only the top 4 Repos
          break;
        } else {
          int index = repo.indexOf(r[i]);
          topRepos[i] = {
            "name": repos[index]["name"],
            "description": repos[index]["description"] == "null"
                ? ""
                : repos[index]["description"],
            "stargazers_count": (repos[index]["stargazers_count"]).toString(),
            "forks_count": (repos[index]["forks_count"]).toString()
          };
          repo[index] = "";//"deletes" the element in the list that was already used
        }
      }
      user
        ..valid = true
        ..username = data["login"]
        ..avatar = data["avatar_url"]
        ..followersCount = data["followers"]
        ..reposCount = data["public_repos"]
        ..topRepos = topRepos;
      return user;
    } else {
      //If user doesn't exist
      return user;
    }
  }
}
