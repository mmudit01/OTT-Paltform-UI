

class sub1 {
  List<Pay> pay;
  List<Currency> currency;
  List<Company> company;

  sub1({this.pay, this.currency, this.company});

  sub1.fromJson(Map<String, dynamic> json) {
    if (json['pay'] != null) {
      pay = new List<Pay>();
      json['pay'].forEach((v) {
        pay.add(new Pay.fromJson(v));
      });
    }
    if (json['currency'] != null) {
      currency = new List<Currency>();
      json['currency'].forEach((v) {
        currency.add(new Currency.fromJson(v));
      });
    }
    if (json['company'] != null) {
      company = new List<Company>();
      json['company'].forEach((v) {
        company.add(new Company.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pay != null) {
      data['pay'] = this.pay.map((v) => v.toJson()).toList();
    }
    if (this.currency != null) {
      data['currency'] = this.currency.map((v) => v.toJson()).toList();
    }
    if (this.company != null) {
      data['company'] = this.company.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pay {
  String sId;
  String oneMonthprice;
  String oneYearprice;
  String sixMonthprice;
  String threeMonthprice;

  Pay(
      {this.sId,
        this.oneMonthprice,
        this.oneYearprice,
        this.sixMonthprice,
        this.threeMonthprice});

  Pay.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    oneMonthprice = json['one_monthprice'].toString();
    oneYearprice = json['one_yearprice'].toString();
    sixMonthprice = json['six_monthprice'].toString();
    threeMonthprice = json['three_monthprice'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['_id'] = this.sId;
    data['one_monthprice'] = this.oneMonthprice;
    data['one_yearprice'] = this.oneYearprice;
    data['six_monthprice'] = this.sixMonthprice;
    data['three_monthprice'] = this.threeMonthprice;
    return data;
  }
}

class Currency {
  String sId;
  String currency;
  int iV;

  Currency({this.sId, this.currency, this.iV});

  Currency.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    currency = json['currency'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['currency'] = this.currency;
    data['__v'] = this.iV;
    return data;
  }
}

class Company {
  String sId;
  String logo;
  String companyname;
  String address;
  String city;
  String state;
  String country;
  String pincode;
  String contactpersonname;
  int mobile;
  String email;
  String facebookpageURL;
  String twitter;
  String linkedin;
  String insta;
  int iV;
  String copyrightMessage;
  String androidappstoreURL;
  String gstnumber;
  String mobileAppPagetext;
  String iOSAppStoreURL;

  Company(
      {this.sId,
        this.logo,
        this.companyname,
        this.address,
        this.city,
        this.state,
        this.country,
        this.pincode,
        this.contactpersonname,
        this.mobile,
        this.email,
        this.facebookpageURL,
        this.twitter,
        this.linkedin,
        this.insta,
        this.iV,
        this.copyrightMessage,
        this.androidappstoreURL,
        this.gstnumber,
        this.mobileAppPagetext,
        this.iOSAppStoreURL});

  Company.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    logo = json['logo'];
    companyname = json['companyname'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    pincode = json['pincode'];
    contactpersonname = json['contactpersonname'];
    mobile = json['mobile'];
    email = json['email'];
    facebookpageURL = json['facebookpageURL'];
    twitter = json['twitter'];
    linkedin = json['linkedin'];
    insta = json['insta'];
    iV = json['__v'];
    copyrightMessage = json['CopyrightMessage'];
    androidappstoreURL = json['androidappstoreURL'];
    gstnumber = json['gstnumber'];
    mobileAppPagetext = json['MobileAppPagetext'];
    iOSAppStoreURL = json['iOSAppStoreURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['logo'] = this.logo;
    data['companyname'] = this.companyname;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pincode'] = this.pincode;
    data['contactpersonname'] = this.contactpersonname;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['facebookpageURL'] = this.facebookpageURL;
    data['twitter'] = this.twitter;
    data['linkedin'] = this.linkedin;
    data['insta'] = this.insta;
    data['__v'] = this.iV;
    data['CopyrightMessage'] = this.copyrightMessage;
    data['androidappstoreURL'] = this.androidappstoreURL;
    data['gstnumber'] = this.gstnumber;
    data['MobileAppPagetext'] = this.mobileAppPagetext;
    data['iOSAppStoreURL'] = this.iOSAppStoreURL;
    return data;
  }
}



