class FpxSendB2CBankEnquiryResponse {
  List<BankEnquiryResponse> response;

  FpxSendB2CBankEnquiryResponse({this.response});

  FpxSendB2CBankEnquiryResponse.fromJson(Map<String, dynamic> json) {
    if (json['Response'] != null) {
      response = new List<BankEnquiryResponse>();
      json['Response'].forEach((v) {
        response.add(new BankEnquiryResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['Response'] = this.response.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BankEnquiryResponse {
  String requestUrl;
  String requestData;
  String responseCode;
  String responseDescription;
  String responseData;
  String transId;
  String sessionId;
  String fpxMsgToken;
  String fpxSellerExId;
  String fpxBankList;
  String fpxCheckSum;
  String fpxMsgType;
  String finalVerifiMsg;
  String bankList;
  String signatureString;

  BankEnquiryResponse(
      {this.requestUrl,
      this.requestData,
      this.responseCode,
      this.responseDescription,
      this.responseData,
      this.transId,
      this.sessionId,
      this.fpxMsgToken,
      this.fpxSellerExId,
      this.fpxBankList,
      this.fpxCheckSum,
      this.fpxMsgType,
      this.finalVerifiMsg,
      this.bankList,
      this.signatureString});

  BankEnquiryResponse.fromJson(Map<String, dynamic> json) {
    requestUrl = json['requestUrl'];
    requestData = json['requestData'];
    responseCode = json['responseCode'];
    responseDescription = json['responseDescription'];
    responseData = json['responseData'];
    transId = json['transId'];
    sessionId = json['sessionId'];
    fpxMsgToken = json['fpx_msgToken'];
    fpxSellerExId = json['fpx_sellerExId'];
    fpxBankList = json['fpx_bankList'];
    fpxCheckSum = json['fpx_checkSum'];
    fpxMsgType = json['fpx_msgType'];
    finalVerifiMsg = json['finalVerifiMsg'];
    bankList = json['bankList'];
    signatureString = json['signatureString'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requestUrl'] = this.requestUrl;
    data['requestData'] = this.requestData;
    data['responseCode'] = this.responseCode;
    data['responseDescription'] = this.responseDescription;
    data['responseData'] = this.responseData;
    data['transId'] = this.transId;
    data['sessionId'] = this.sessionId;
    data['fpx_msgToken'] = this.fpxMsgToken;
    data['fpx_sellerExId'] = this.fpxSellerExId;
    data['fpx_bankList'] = this.fpxBankList;
    data['fpx_checkSum'] = this.fpxCheckSum;
    data['fpx_msgType'] = this.fpxMsgType;
    data['finalVerifiMsg'] = this.finalVerifiMsg;
    data['bankList'] = this.bankList;
    data['signatureString'] = this.signatureString;
    return data;
  }
}

class GetOnlinePaymentListByIcNoResponse {
  List<OnlinePayment> onlinePayment;

  GetOnlinePaymentListByIcNoResponse({this.onlinePayment});

  GetOnlinePaymentListByIcNoResponse.fromJson(Map<String, dynamic> json) {
    if (json['OnlinePayment'] != null) {
      onlinePayment = new List<OnlinePayment>();
      json['OnlinePayment'].forEach((v) {
        onlinePayment.add(new OnlinePayment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.onlinePayment != null) {
      data['OnlinePayment'] =
          this.onlinePayment.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OnlinePayment {
  String docDoc;
  String docRef;
  String paidAmt;
  String status;

  OnlinePayment({this.docDoc, this.docRef, this.paidAmt, this.status});

  OnlinePayment.fromJson(Map<String, dynamic> json) {
    docDoc = json['doc_doc'];
    docRef = json['doc_ref'];
    paidAmt = json['paid_amt'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doc_doc'] = this.docDoc;
    data['doc_ref'] = this.docRef;
    data['paid_amt'] = this.paidAmt;
    data['status'] = this.status;
    return data;
  }
}
