import 'package:fakecall/main.dart';

class Data {
  String? appName;
  String? appIcon;
  String? splashUrl;
  String? mainColor;
  String? contact;
  String? about;
  String? privacy;
  String? terms;
  List<Intro>? intro;
  List<Content>? content;
  List<AdConfig>? adConfig;

  Data({
    this.appName,
    this.appIcon,
    this.splashUrl,
    this.mainColor,
    this.contact,
    this.about,
    this.privacy,
    this.terms,
    this.intro,
    this.content,
    this.adConfig,
  });

  Data.fromJson(Map<String, dynamic> json) {
    appName = json['app_name'];
    appIcon = json['app_icon'];
    splashUrl = json['splash_url'];
    mainColor = json['main_color'];
    contact = json['contact'];
    about = json['about'];
    privacy = json['privacy'];
    terms = json['terms'];
    if (json['ad_priority'] != null) {
      adConfig = <AdConfig>[];
      json['ad_priority'].forEach((v) {
        adConfig!.add(AdConfig.fromJson(v));
      });

      adConfig!.sort((a, b) => a.priority!.compareTo(b.priority!));

      switch (adConfig![0].network) {
        case 'AdMob':
          selectedAdNetwork = AdNetwork.admob;
          break;
        case 'UnityAds':
          selectedAdNetwork = AdNetwork.unity;
          break;
        case 'MetaAds':
          selectedAdNetwork = AdNetwork.facebook;
          break;
        case 'AppLovin':
          selectedAdNetwork = AdNetwork.applovin;
          break;
      }
    }
    if (json['intro'] != null) {
      intro = <Intro>[];
      json['intro'].forEach((v) {
        intro!.add(Intro.fromJson(v));
      });
    }
    if (json['content'] != null) {
      content = <Content>[];
      json['content'].forEach((v) {
        content!.add(Content.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['app_name'] = appName;
    data['app_icon'] = appIcon;
    data['splash_url'] = splashUrl;
    data['main_color'] = mainColor;
    data['contact'] = contact;
    data['about'] = about;
    data['privacy'] = privacy;
    data['terms'] = terms;
    if (intro != null) {
      data['intro'] = intro!.map((v) => v.toJson()).toList();
    }
    if (content != null) {
      data['content'] = content!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdConfig {
  String? network;
  int? priority;

  AdConfig({this.network, this.priority});

  AdConfig.fromJson(Map<String, dynamic> json) {
    network = json['network'];
    priority = json['priority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['network'] = network;
    data['priority'] = priority;
    return data;
  }
}

class Intro {
  String? title;
  String? description;
  String? icon;

  Intro({this.title, this.description, this.icon});

  Intro.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['icon'] = icon;
    return data;
  }
}

class Content {
  String? name;
  String? number;
  String? icon;
  String? vocal;
  String? video;

  Content({this.name, this.number, this.icon, this.vocal, this.video});

  Content.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    number = json['number'];
    icon = json['icon'];
    vocal = json['vocal'];
    video = json['video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['number'] = number;
    data['icon'] = icon;
    data['vocal'] = vocal;
    data['video'] = video;
    return data;
  }
}
