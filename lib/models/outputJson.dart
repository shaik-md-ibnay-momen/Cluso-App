// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

OutputJson welcomeFromJson(String str) => OutputJson.fromJson(json.decode(str));

String welcomeToJson(OutputJson data) => json.encode(data.toJson());

class OutputJson {
  int respond;
  Paging paging;
  String message;
  List<Result> result;

  OutputJson({
    this.respond,
    this.paging,
    this.message,
    this.result,
  });

  factory OutputJson.fromJson(Map<String, dynamic> json) => OutputJson(
    respond: json["respond"],
    paging: Paging.fromJson(json["paging"]),
    message: json["message"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "respond": respond,
    "paging": paging.toJson(),
    "message": message,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Paging {
  int stillmore;
  int perpage;
  int callpage;
  int next;
  int previous;
  int pages;
  int result;

  Paging({
    this.stillmore,
    this.perpage,
    this.callpage,
    this.next,
    this.previous,
    this.pages,
    this.result,
  });

  factory Paging.fromJson(Map<String, dynamic> json) => Paging(
    stillmore: json["stillmore"],
    perpage: json["perpage"],
    callpage: json["callpage"],
    next: json["next"],
    previous: json["previous"],
    pages: json["pages"],
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "stillmore": stillmore,
    "perpage": perpage,
    "callpage": callpage,
    "next": next,
    "previous": previous,
    "pages": pages,
    "result": result,
  };
}

class Result {
  String id;
  String userLogin;
  String userNicename;
  String userEmail;
  String userUrl;
  String userRegistered;
  String displayName;
  String metaValue;
  String sessionId;
  Role role;
  String firstName;
  String lastName;
  String nickname;
  String description;
  String aim;
  String jabber;
  String yim;
  List<dynamic> customFields;
  Authormeta authormeta;
  String avatar;

  Result({
    this.id,
    this.userLogin,
    this.userNicename,
    this.userEmail,
    this.userUrl,
    this.userRegistered,
    this.displayName,
    this.metaValue,
    this.sessionId,
    this.role,
    this.firstName,
    this.lastName,
    this.nickname,
    this.description,
    this.aim,
    this.jabber,
    this.yim,
    this.customFields,
    this.authormeta,
    this.avatar,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["ID"],
    userLogin: json["user_login"],
    userNicename: json["user_nicename"],
    userEmail: json["user_email"],
    userUrl: json["user_url"],
    userRegistered: json["user_registered"],
    displayName: json["display_name"],
    metaValue: json["meta_value"],
    sessionId: json["session_id"],
    role: Role.fromJson(json["role"]),
    firstName: json["first_name"],
    lastName: json["last_name"],
    nickname: json["nickname"],
    description: json["description"],
    aim: json["aim"],
    jabber: json["jabber"],
    yim: json["yim"],
    customFields: List<dynamic>.from(json["custom_fields"].map((x) => x)),
    authormeta: Authormeta.fromJson(json["authormeta"]),
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "user_login": userLogin,
    "user_nicename": userNicename,
    "user_email": userEmail,
    "user_url": userUrl,
    "user_registered": userRegistered,
    "display_name": displayName,
    "meta_value": metaValue,
    "session_id": sessionId,
    "role": role.toJson(),
    "first_name": firstName,
    "last_name": lastName,
    "nickname": nickname,
    "description": description,
    "aim": aim,
    "jabber": jabber,
    "yim": yim,
    "custom_fields": List<dynamic>.from(customFields.map((x) => x)),
    "authormeta": authormeta.toJson(),
    "avatar": avatar,
  };
}

class Authormeta {
  String nickname;
  String firstName;
  String lastName;
  String description;
  String richEditing;
  String syntaxHighlighting;
  String commentShortcuts;
  String adminColor;
  String useSsl;
  String showAdminBarFront;
  String locale;
  Role mod905Capabilities;
  String mod905UserLevel;
  String syncedGravatarHashedId;
  Map<String, SessionToken> sessionTokens;
  String wcLastActive;
  String umLastLogin;
  List<dynamic> yithWrvpProductsList;
  String wflsLastLogin;
  String woocommerceLoadSavedCartAfterLogin;
  int smioFollowers;
  int smioFollowed;

  Authormeta({
    this.nickname,
    this.firstName,
    this.lastName,
    this.description,
    this.richEditing,
    this.syntaxHighlighting,
    this.commentShortcuts,
    this.adminColor,
    this.useSsl,
    this.showAdminBarFront,
    this.locale,
    this.mod905Capabilities,
    this.mod905UserLevel,
    this.syncedGravatarHashedId,
    this.sessionTokens,
    this.wcLastActive,
    this.umLastLogin,
    this.yithWrvpProductsList,
    this.wflsLastLogin,
    this.woocommerceLoadSavedCartAfterLogin,
    this.smioFollowers,
    this.smioFollowed,
  });

  factory Authormeta.fromJson(Map<String, dynamic> json) => Authormeta(
    nickname: json["nickname"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    description: json["description"],
    richEditing: json["rich_editing"],
    syntaxHighlighting: json["syntax_highlighting"],
    commentShortcuts: json["comment_shortcuts"],
    adminColor: json["admin_color"],
    useSsl: json["use_ssl"],
    showAdminBarFront: json["show_admin_bar_front"],
    locale: json["locale"],
    mod905Capabilities: Role.fromJson(json["mod905_capabilities"]),
    mod905UserLevel: json["mod905_user_level"],
    syncedGravatarHashedId: json["synced_gravatar_hashed_id"],
    sessionTokens: Map.from(json["session_tokens"]).map((k, v) => MapEntry<String, SessionToken>(k, SessionToken.fromJson(v))),
    wcLastActive: json["wc_last_active"],
    umLastLogin: json["_um_last_login"],
    yithWrvpProductsList: List<dynamic>.from(json["yith_wrvp_products_list"].map((x) => x)),
    wflsLastLogin: json["wfls-last-login"],
    woocommerceLoadSavedCartAfterLogin: json["_woocommerce_load_saved_cart_after_login"],
    smioFollowers: json["smio_followers"],
    smioFollowed: json["smio_followed"],
  );

  Map<String, dynamic> toJson() => {
    "nickname": nickname,
    "first_name": firstName,
    "last_name": lastName,
    "description": description,
    "rich_editing": richEditing,
    "syntax_highlighting": syntaxHighlighting,
    "comment_shortcuts": commentShortcuts,
    "admin_color": adminColor,
    "use_ssl": useSsl,
    "show_admin_bar_front": showAdminBarFront,
    "locale": locale,
    "mod905_capabilities": mod905Capabilities.toJson(),
    "mod905_user_level": mod905UserLevel,
    "synced_gravatar_hashed_id": syncedGravatarHashedId,
    "session_tokens": Map.from(sessionTokens).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "wc_last_active": wcLastActive,
    "_um_last_login": umLastLogin,
    "yith_wrvp_products_list": List<dynamic>.from(yithWrvpProductsList.map((x) => x)),
    "wfls-last-login": wflsLastLogin,
    "_woocommerce_load_saved_cart_after_login": woocommerceLoadSavedCartAfterLogin,
    "smio_followers": smioFollowers,
    "smio_followed": smioFollowed,
  };
}

class Role {
  bool subscriber;

  Role({
    this.subscriber,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    subscriber: json["subscriber"],
  );

  Map<String, dynamic> toJson() => {
    "subscriber": subscriber,
  };
}

class SessionToken {
  int expiration;
  String ip;
  String ua;
  int login;

  SessionToken({
    this.expiration,
    this.ip,
    this.ua,
    this.login,
  });

  factory SessionToken.fromJson(Map<String, dynamic> json) => SessionToken(
    expiration: json["expiration"],
    ip: json["ip"],
    ua: json["ua"],
    login: json["login"],
  );

  Map<String, dynamic> toJson() => {
    "expiration": expiration,
    "ip": ip,
    "ua": ua,
    "login": login,
  };
}
