class FpxSendB2CBankEnquiryResponse {
  List<BankEnquiryResponse>? response;

  FpxSendB2CBankEnquiryResponse({this.response});

  FpxSendB2CBankEnquiryResponse.fromJson(Map<String, dynamic> json) {
    if (json['Response'] != null) {
      response = new List<BankEnquiryResponse>.empty(growable: true);
      json['Response'].forEach((v) {
        response!.add(new BankEnquiryResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['Response'] = this.response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BankEnquiryResponse {
  String? requestUrl;
  String? requestData;
  String? responseCode;
  String? responseDescription;
  String? responseData;
  String? transId;
  String? sessionId;
  String? fpxMsgToken;
  String? fpxSellerExId;
  String? fpxBankList;
  String? fpxCheckSum;
  String? fpxMsgType;
  String? finalVerifiMsg;
  String? bankList;
  String? signatureString;

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
  List<OnlinePayment>? onlinePayment;

  GetOnlinePaymentListByIcNoResponse({this.onlinePayment});

  GetOnlinePaymentListByIcNoResponse.fromJson(Map<String, dynamic> json) {
    if (json['OnlinePayment'] != null) {
      onlinePayment = new List<OnlinePayment>.empty(growable: true);
      json['OnlinePayment'].forEach((v) {
        onlinePayment!.add(new OnlinePayment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.onlinePayment != null) {
      data['OnlinePayment'] =
          this.onlinePayment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OnlinePayment {
  String? docDoc;
  String? docRef;
  String? paidAmt;
  String? status;

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

class CreateOrderRequest {
  String? wsCodeCrypt;
  String? caUid;
  String? caPwd;
  String? diCode;
  String? userId;
  String? icNo;
  String? packageCode;

  CreateOrderRequest(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
      this.diCode,
      this.userId,
      this.icNo,
      this.packageCode});

  CreateOrderRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    diCode = json['diCode'];
    userId = json['userId'];
    icNo = json['icNo'];
    packageCode = json['packageCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
    data['diCode'] = this.diCode;
    data['userId'] = this.userId;
    data['icNo'] = this.icNo;
    data['packageCode'] = this.packageCode;
    return data;
  }
}

class CreateOrderWithAmtRequest {
  String? wsCodeCrypt;
  String? caUid;
  String? caPwd;
  String? diCode;
  String? userId;
  String? icNo;
  String? packageCode;
  String? amountString;

  CreateOrderWithAmtRequest(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
      this.diCode,
      this.userId,
      this.icNo,
      this.packageCode,
      this.amountString});

  CreateOrderWithAmtRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    diCode = json['diCode'];
    userId = json['userId'];
    icNo = json['icNo'];
    packageCode = json['packageCode'];
    amountString = json['amountString'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
    data['diCode'] = this.diCode;
    data['userId'] = this.userId;
    data['icNo'] = this.icNo;
    data['packageCode'] = this.packageCode;
    data['amountString'] = this.amountString;
    return data;
  }
}

class CreateOrderResponse {
  List<SlsTrn>? slsTrn;

  CreateOrderResponse({this.slsTrn});

  CreateOrderResponse.fromJson(Map<String, dynamic> json) {
    if (json['SlsTrn'] != null) {
      slsTrn = new List<SlsTrn>.empty(growable: true);
      json['SlsTrn'].forEach((v) {
        slsTrn!.add(new SlsTrn.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.slsTrn != null) {
      data['SlsTrn'] = this.slsTrn!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SlsTrn {
  String? iD;
  String? merchantNo;
  String? docDoc;
  String? docRef;
  String? slsDoc;
  String? slsRef;
  String? revNo;
  String? ordDate;
  String? ordTime;
  String? wfStatus;
  String? refNo;
  String? subject;
  String? validity;
  String? leadTime;
  String? dbcode;
  String? icNo;
  String? name;
  String? branch;
  String? locCode;
  String? areaCode;
  String? currency;
  String? rate;
  String? terms;
  String? salesPer;
  String? projCode;
  String? orderBy;
  String? custPoNo;
  String? custPoDate;
  String? shipmentTerm;
  String? shipmentTermDetl;
  String? shipMode;
  String? shipCode;
  String? shipTo;
  String? shipName;
  String? shipAdd;
  String? shipAdd1;
  String? shipAdd2;
  String? shipAdd3;
  String? shipAdd4;
  String? shipArea;
  String? shipPhone;
  String? shipFax;
  String? shipPtc;
  String? shipRemark;
  String? misc1;
  String? misc2;
  String? misc3;
  String? misc4;
  String? misc5;
  String? misc6;
  String? misc13;
  String? misc14;
  String? misc15;
  String? misc16;
  String? misc17;
  String? misc18;
  String? tlOrdQty;
  String? tlOrdAmt;
  String? tlNettDetlAmt;
  String? tlLocDetlAmt;
  String? tlNettOrdAmt;
  String? tlLocOrdAmt;
  String? tlDiscAmt;
  String? tlLocDiscAmt;
  String? tlSlsTax;
  String? tlLocSlsTax;
  String? tlSerTax;
  String? tlLocSerTax;
  String? bdiscRate;
  String? bdiscAmt;
  String? transChrg;
  String? transRate;
  String? mfgCurrency;
  String? mfgRate;
  String? mfgTlNettOrdAmt;
  String? mfgTlLocOrdAmt;
  String? hold;
  String? cj5No;
  String? dbAcct;
  String? dbDept;
  String? tlDlvQty;
  String? doDoc;
  String? doRef;
  String? invDoc;
  String? invRef;
  String? title1;
  String? title2;
  String? title3;
  String? remark;
  String? remark1;
  String? remark2;
  String? prnCount;
  String? printLog;
  String? trnStatus;
  String? creditBlockReason;
  String? creditBlockInfo;
  String? creditReqApprv;
  String? creditApprvUser;
  String? creditApprvDate;
  String? creditApprvAmt;
  String? creditApprvLog;
  String? pending;
  String? cancel;
  String? cancelDate;
  String? posted;
  String? complete;
  String? clear;
  String? fullyBilled;
  String? tlBilledAmt;
  String? tlPaidAmt;
  String? readOnly;
  String? createUser;
  String? createDate;
  String? editUser;
  String? editDate;
  String? deleted;
  String? compCode;
  String? branchCode;
  String? rowKey;
  String? lastupload;
  String? duplicateKey;
  String? validateFailed;
  String? validateRemark;
  String? lastValidate;
  String? transtamp;
  String? packageCode;
  String? packageDesc;

  SlsTrn(
      {this.iD,
      this.merchantNo,
      this.docDoc,
      this.docRef,
      this.slsDoc,
      this.slsRef,
      this.revNo,
      this.ordDate,
      this.ordTime,
      this.wfStatus,
      this.refNo,
      this.subject,
      this.validity,
      this.leadTime,
      this.dbcode,
      this.icNo,
      this.name,
      this.branch,
      this.locCode,
      this.areaCode,
      this.currency,
      this.rate,
      this.terms,
      this.salesPer,
      this.projCode,
      this.orderBy,
      this.custPoNo,
      this.custPoDate,
      this.shipmentTerm,
      this.shipmentTermDetl,
      this.shipMode,
      this.shipCode,
      this.shipTo,
      this.shipName,
      this.shipAdd,
      this.shipAdd1,
      this.shipAdd2,
      this.shipAdd3,
      this.shipAdd4,
      this.shipArea,
      this.shipPhone,
      this.shipFax,
      this.shipPtc,
      this.shipRemark,
      this.misc1,
      this.misc2,
      this.misc3,
      this.misc4,
      this.misc5,
      this.misc6,
      this.misc13,
      this.misc14,
      this.misc15,
      this.misc16,
      this.misc17,
      this.misc18,
      this.tlOrdQty,
      this.tlOrdAmt,
      this.tlNettDetlAmt,
      this.tlLocDetlAmt,
      this.tlNettOrdAmt,
      this.tlLocOrdAmt,
      this.tlDiscAmt,
      this.tlLocDiscAmt,
      this.tlSlsTax,
      this.tlLocSlsTax,
      this.tlSerTax,
      this.tlLocSerTax,
      this.bdiscRate,
      this.bdiscAmt,
      this.transChrg,
      this.transRate,
      this.mfgCurrency,
      this.mfgRate,
      this.mfgTlNettOrdAmt,
      this.mfgTlLocOrdAmt,
      this.hold,
      this.cj5No,
      this.dbAcct,
      this.dbDept,
      this.tlDlvQty,
      this.doDoc,
      this.doRef,
      this.invDoc,
      this.invRef,
      this.title1,
      this.title2,
      this.title3,
      this.remark,
      this.remark1,
      this.remark2,
      this.prnCount,
      this.printLog,
      this.trnStatus,
      this.creditBlockReason,
      this.creditBlockInfo,
      this.creditReqApprv,
      this.creditApprvUser,
      this.creditApprvDate,
      this.creditApprvAmt,
      this.creditApprvLog,
      this.pending,
      this.cancel,
      this.cancelDate,
      this.posted,
      this.complete,
      this.clear,
      this.fullyBilled,
      this.tlBilledAmt,
      this.tlPaidAmt,
      this.readOnly,
      this.createUser,
      this.createDate,
      this.editUser,
      this.editDate,
      this.deleted,
      this.compCode,
      this.branchCode,
      this.rowKey,
      this.lastupload,
      this.duplicateKey,
      this.validateFailed,
      this.validateRemark,
      this.lastValidate,
      this.transtamp,
      this.packageCode,
      this.packageDesc});

  SlsTrn.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    merchantNo = json['merchant_no'];
    docDoc = json['doc_doc'];
    docRef = json['doc_ref'];
    slsDoc = json['sls_doc'];
    slsRef = json['sls_ref'];
    revNo = json['rev_no'];
    ordDate = json['ord_date'];
    ordTime = json['ord_time'];
    wfStatus = json['wf_status'];
    refNo = json['ref_no'];
    subject = json['subject'];
    validity = json['validity'];
    leadTime = json['lead_time'];
    dbcode = json['dbcode'];
    icNo = json['ic_no'];
    name = json['name'];
    branch = json['branch'];
    locCode = json['loc_code'];
    areaCode = json['area_code'];
    currency = json['currency'];
    rate = json['rate'];
    terms = json['terms'];
    salesPer = json['sales_per'];
    projCode = json['proj_code'];
    orderBy = json['order_by'];
    custPoNo = json['cust_po_no'];
    custPoDate = json['cust_po_date'];
    shipmentTerm = json['shipment_term'];
    shipmentTermDetl = json['shipment_term_detl'];
    shipMode = json['ship_mode'];
    shipCode = json['ship_code'];
    shipTo = json['ship_to'];
    shipName = json['ship_name'];
    shipAdd = json['ship_add'];
    shipAdd1 = json['ship_add1'];
    shipAdd2 = json['ship_add2'];
    shipAdd3 = json['ship_add3'];
    shipAdd4 = json['ship_add4'];
    shipArea = json['ship_area'];
    shipPhone = json['ship_phone'];
    shipFax = json['ship_fax'];
    shipPtc = json['ship_ptc'];
    shipRemark = json['ship_remark'];
    misc1 = json['misc1'];
    misc2 = json['misc2'];
    misc3 = json['misc3'];
    misc4 = json['misc4'];
    misc5 = json['misc5'];
    misc6 = json['misc6'];
    misc13 = json['misc13'];
    misc14 = json['misc14'];
    misc15 = json['misc15'];
    misc16 = json['misc16'];
    misc17 = json['misc17'];
    misc18 = json['misc18'];
    tlOrdQty = json['tl_ord_qty'];
    tlOrdAmt = json['tl_ord_amt'];
    tlNettDetlAmt = json['tl_nett_detl_amt'];
    tlLocDetlAmt = json['tl_loc_detl_amt'];
    tlNettOrdAmt = json['tl_nett_ord_amt'];
    tlLocOrdAmt = json['tl_loc_ord_amt'];
    tlDiscAmt = json['tl_disc_amt'];
    tlLocDiscAmt = json['tl_loc_disc_amt'];
    tlSlsTax = json['tl_sls_tax'];
    tlLocSlsTax = json['tl_loc_sls_tax'];
    tlSerTax = json['tl_ser_tax'];
    tlLocSerTax = json['tl_loc_ser_tax'];
    bdiscRate = json['bdisc_rate'];
    bdiscAmt = json['bdisc_amt'];
    transChrg = json['trans_chrg'];
    transRate = json['trans_rate'];
    mfgCurrency = json['mfg_currency'];
    mfgRate = json['mfg_rate'];
    mfgTlNettOrdAmt = json['mfg_tl_nett_ord_amt'];
    mfgTlLocOrdAmt = json['mfg_tl_loc_ord_amt'];
    hold = json['hold'];
    cj5No = json['cj5_no'];
    dbAcct = json['db_acct'];
    dbDept = json['db_dept'];
    tlDlvQty = json['tl_dlv_qty'];
    doDoc = json['do_doc'];
    doRef = json['do_ref'];
    invDoc = json['inv_doc'];
    invRef = json['inv_ref'];
    title1 = json['title1'];
    title2 = json['title2'];
    title3 = json['title3'];
    remark = json['remark'];
    remark1 = json['remark1'];
    remark2 = json['remark2'];
    prnCount = json['prn_count'];
    printLog = json['print_log'];
    trnStatus = json['trn_status'];
    creditBlockReason = json['credit_block_reason'];
    creditBlockInfo = json['credit_block_info'];
    creditReqApprv = json['credit_req_apprv'];
    creditApprvUser = json['credit_apprv_user'];
    creditApprvDate = json['credit_apprv_date'];
    creditApprvAmt = json['credit_apprv_amt'];
    creditApprvLog = json['credit_apprv_log'];
    pending = json['pending'];
    cancel = json['cancel'];
    cancelDate = json['cancel_date'];
    posted = json['posted'];
    complete = json['complete'];
    clear = json['clear'];
    fullyBilled = json['fully_billed'];
    tlBilledAmt = json['tl_billed_amt'];
    tlPaidAmt = json['tl_paid_amt'];
    readOnly = json['read_only'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    deleted = json['deleted'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    rowKey = json['row_key'];
    lastupload = json['lastupload'];
    duplicateKey = json['duplicate_key'];
    validateFailed = json['validate_failed'];
    validateRemark = json['validate_remark'];
    lastValidate = json['last_validate'];
    transtamp = json['transtamp'];
    packageCode = json['package_code'];
    packageDesc = json['package_desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['merchant_no'] = this.merchantNo;
    data['doc_doc'] = this.docDoc;
    data['doc_ref'] = this.docRef;
    data['sls_doc'] = this.slsDoc;
    data['sls_ref'] = this.slsRef;
    data['rev_no'] = this.revNo;
    data['ord_date'] = this.ordDate;
    data['ord_time'] = this.ordTime;
    data['wf_status'] = this.wfStatus;
    data['ref_no'] = this.refNo;
    data['subject'] = this.subject;
    data['validity'] = this.validity;
    data['lead_time'] = this.leadTime;
    data['dbcode'] = this.dbcode;
    data['ic_no'] = this.icNo;
    data['name'] = this.name;
    data['branch'] = this.branch;
    data['loc_code'] = this.locCode;
    data['area_code'] = this.areaCode;
    data['currency'] = this.currency;
    data['rate'] = this.rate;
    data['terms'] = this.terms;
    data['sales_per'] = this.salesPer;
    data['proj_code'] = this.projCode;
    data['order_by'] = this.orderBy;
    data['cust_po_no'] = this.custPoNo;
    data['cust_po_date'] = this.custPoDate;
    data['shipment_term'] = this.shipmentTerm;
    data['shipment_term_detl'] = this.shipmentTermDetl;
    data['ship_mode'] = this.shipMode;
    data['ship_code'] = this.shipCode;
    data['ship_to'] = this.shipTo;
    data['ship_name'] = this.shipName;
    data['ship_add'] = this.shipAdd;
    data['ship_add1'] = this.shipAdd1;
    data['ship_add2'] = this.shipAdd2;
    data['ship_add3'] = this.shipAdd3;
    data['ship_add4'] = this.shipAdd4;
    data['ship_area'] = this.shipArea;
    data['ship_phone'] = this.shipPhone;
    data['ship_fax'] = this.shipFax;
    data['ship_ptc'] = this.shipPtc;
    data['ship_remark'] = this.shipRemark;
    data['misc1'] = this.misc1;
    data['misc2'] = this.misc2;
    data['misc3'] = this.misc3;
    data['misc4'] = this.misc4;
    data['misc5'] = this.misc5;
    data['misc6'] = this.misc6;
    data['misc13'] = this.misc13;
    data['misc14'] = this.misc14;
    data['misc15'] = this.misc15;
    data['misc16'] = this.misc16;
    data['misc17'] = this.misc17;
    data['misc18'] = this.misc18;
    data['tl_ord_qty'] = this.tlOrdQty;
    data['tl_ord_amt'] = this.tlOrdAmt;
    data['tl_nett_detl_amt'] = this.tlNettDetlAmt;
    data['tl_loc_detl_amt'] = this.tlLocDetlAmt;
    data['tl_nett_ord_amt'] = this.tlNettOrdAmt;
    data['tl_loc_ord_amt'] = this.tlLocOrdAmt;
    data['tl_disc_amt'] = this.tlDiscAmt;
    data['tl_loc_disc_amt'] = this.tlLocDiscAmt;
    data['tl_sls_tax'] = this.tlSlsTax;
    data['tl_loc_sls_tax'] = this.tlLocSlsTax;
    data['tl_ser_tax'] = this.tlSerTax;
    data['tl_loc_ser_tax'] = this.tlLocSerTax;
    data['bdisc_rate'] = this.bdiscRate;
    data['bdisc_amt'] = this.bdiscAmt;
    data['trans_chrg'] = this.transChrg;
    data['trans_rate'] = this.transRate;
    data['mfg_currency'] = this.mfgCurrency;
    data['mfg_rate'] = this.mfgRate;
    data['mfg_tl_nett_ord_amt'] = this.mfgTlNettOrdAmt;
    data['mfg_tl_loc_ord_amt'] = this.mfgTlLocOrdAmt;
    data['hold'] = this.hold;
    data['cj5_no'] = this.cj5No;
    data['db_acct'] = this.dbAcct;
    data['db_dept'] = this.dbDept;
    data['tl_dlv_qty'] = this.tlDlvQty;
    data['do_doc'] = this.doDoc;
    data['do_ref'] = this.doRef;
    data['inv_doc'] = this.invDoc;
    data['inv_ref'] = this.invRef;
    data['title1'] = this.title1;
    data['title2'] = this.title2;
    data['title3'] = this.title3;
    data['remark'] = this.remark;
    data['remark1'] = this.remark1;
    data['remark2'] = this.remark2;
    data['prn_count'] = this.prnCount;
    data['print_log'] = this.printLog;
    data['trn_status'] = this.trnStatus;
    data['credit_block_reason'] = this.creditBlockReason;
    data['credit_block_info'] = this.creditBlockInfo;
    data['credit_req_apprv'] = this.creditReqApprv;
    data['credit_apprv_user'] = this.creditApprvUser;
    data['credit_apprv_date'] = this.creditApprvDate;
    data['credit_apprv_amt'] = this.creditApprvAmt;
    data['credit_apprv_log'] = this.creditApprvLog;
    data['pending'] = this.pending;
    data['cancel'] = this.cancel;
    data['cancel_date'] = this.cancelDate;
    data['posted'] = this.posted;
    data['complete'] = this.complete;
    data['clear'] = this.clear;
    data['fully_billed'] = this.fullyBilled;
    data['tl_billed_amt'] = this.tlBilledAmt;
    data['tl_paid_amt'] = this.tlPaidAmt;
    data['read_only'] = this.readOnly;
    data['create_user'] = this.createUser;
    data['create_date'] = this.createDate;
    data['edit_user'] = this.editUser;
    data['edit_date'] = this.editDate;
    data['deleted'] = this.deleted;
    data['comp_code'] = this.compCode;
    data['branch_code'] = this.branchCode;
    data['row_key'] = this.rowKey;
    data['lastupload'] = this.lastupload;
    data['duplicate_key'] = this.duplicateKey;
    data['validate_failed'] = this.validateFailed;
    data['validate_remark'] = this.validateRemark;
    data['last_validate'] = this.lastValidate;
    data['transtamp'] = this.transtamp;
    data['package_code'] = this.packageCode;
    data['package_desc'] = this.packageDesc;
    return data;
  }
}

class GetOrderListByIcNoResponse {
  List<GetOrderListSlsTrn>? slsTrn;

  GetOrderListByIcNoResponse({this.slsTrn});

  GetOrderListByIcNoResponse.fromJson(Map<String, dynamic> json) {
    if (json['SlsTrn'] != null) {
      slsTrn = new List<GetOrderListSlsTrn>.empty(growable: true);
      json['SlsTrn'].forEach((v) {
        slsTrn!.add(new GetOrderListSlsTrn.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.slsTrn != null) {
      data['SlsTrn'] = this.slsTrn!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetOrderListSlsTrn {
  String? iD;
  String? merchantNo;
  String? docDoc;
  String? docRef;
  String? slsDoc;
  String? slsRef;
  String? revNo;
  String? ordDate;
  String? ordTime;
  String? wfStatus;
  String? refNo;
  String? subject;
  String? validity;
  String? leadTime;
  String? dbcode;
  String? icNo;
  String? name;
  String? branch;
  String? locCode;
  String? areaCode;
  String? currency;
  String? rate;
  String? terms;
  String? salesPer;
  String? projCode;
  String? orderBy;
  String? custPoNo;
  String? custPoDate;
  String? shipmentTerm;
  String? shipmentTermDetl;
  String? shipMode;
  String? shipCode;
  String? shipTo;
  String? shipName;
  String? shipAdd;
  String? shipAdd1;
  String? shipAdd2;
  String? shipAdd3;
  String? shipAdd4;
  String? shipArea;
  String? shipPhone;
  String? shipFax;
  String? shipPtc;
  String? shipRemark;
  String? misc1;
  String? misc2;
  String? misc3;
  String? misc4;
  String? misc5;
  String? misc6;
  String? misc13;
  String? misc14;
  String? misc15;
  String? misc16;
  String? misc17;
  String? misc18;
  String? tlOrdQty;
  String? tlOrdAmt;
  String? tlNettDetlAmt;
  String? tlLocDetlAmt;
  String? tlNettOrdAmt;
  String? tlLocOrdAmt;
  String? tlDiscAmt;
  String? tlLocDiscAmt;
  String? tlSlsTax;
  String? tlLocSlsTax;
  String? tlSerTax;
  String? tlLocSerTax;
  String? bdiscRate;
  String? bdiscAmt;
  String? transChrg;
  String? transRate;
  String? mfgCurrency;
  String? mfgRate;
  String? mfgTlNettOrdAmt;
  String? mfgTlLocOrdAmt;
  String? hold;
  String? cj5No;
  String? dbAcct;
  String? dbDept;
  String? tlDlvQty;
  String? doDoc;
  String? doRef;
  String? invDoc;
  String? invRef;
  String? title1;
  String? title2;
  String? title3;
  String? remark;
  String? remark1;
  String? remark2;
  String? prnCount;
  String? printLog;
  String? trnStatus;
  String? creditBlockReason;
  String? creditBlockInfo;
  String? creditReqApprv;
  String? creditApprvUser;
  String? creditApprvDate;
  String? creditApprvAmt;
  String? creditApprvLog;
  String? pending;
  String? cancel;
  String? cancelDate;
  String? posted;
  String? complete;
  String? clear;
  String? fullyBilled;
  String? tlBilledAmt;
  String? tlPaidAmt;
  String? readOnly;
  String? createUser;
  String? createDate;
  String? editUser;
  String? editDate;
  String? deleted;
  String? compCode;
  String? branchCode;
  String? rowKey;
  String? lastupload;
  String? duplicateKey;
  String? validateFailed;
  String? validateRemark;
  String? lastValidate;
  String? transtamp;
  String? packageCode;
  String? packageDesc;

  GetOrderListSlsTrn(
      {this.iD,
      this.merchantNo,
      this.docDoc,
      this.docRef,
      this.slsDoc,
      this.slsRef,
      this.revNo,
      this.ordDate,
      this.ordTime,
      this.wfStatus,
      this.refNo,
      this.subject,
      this.validity,
      this.leadTime,
      this.dbcode,
      this.icNo,
      this.name,
      this.branch,
      this.locCode,
      this.areaCode,
      this.currency,
      this.rate,
      this.terms,
      this.salesPer,
      this.projCode,
      this.orderBy,
      this.custPoNo,
      this.custPoDate,
      this.shipmentTerm,
      this.shipmentTermDetl,
      this.shipMode,
      this.shipCode,
      this.shipTo,
      this.shipName,
      this.shipAdd,
      this.shipAdd1,
      this.shipAdd2,
      this.shipAdd3,
      this.shipAdd4,
      this.shipArea,
      this.shipPhone,
      this.shipFax,
      this.shipPtc,
      this.shipRemark,
      this.misc1,
      this.misc2,
      this.misc3,
      this.misc4,
      this.misc5,
      this.misc6,
      this.misc13,
      this.misc14,
      this.misc15,
      this.misc16,
      this.misc17,
      this.misc18,
      this.tlOrdQty,
      this.tlOrdAmt,
      this.tlNettDetlAmt,
      this.tlLocDetlAmt,
      this.tlNettOrdAmt,
      this.tlLocOrdAmt,
      this.tlDiscAmt,
      this.tlLocDiscAmt,
      this.tlSlsTax,
      this.tlLocSlsTax,
      this.tlSerTax,
      this.tlLocSerTax,
      this.bdiscRate,
      this.bdiscAmt,
      this.transChrg,
      this.transRate,
      this.mfgCurrency,
      this.mfgRate,
      this.mfgTlNettOrdAmt,
      this.mfgTlLocOrdAmt,
      this.hold,
      this.cj5No,
      this.dbAcct,
      this.dbDept,
      this.tlDlvQty,
      this.doDoc,
      this.doRef,
      this.invDoc,
      this.invRef,
      this.title1,
      this.title2,
      this.title3,
      this.remark,
      this.remark1,
      this.remark2,
      this.prnCount,
      this.printLog,
      this.trnStatus,
      this.creditBlockReason,
      this.creditBlockInfo,
      this.creditReqApprv,
      this.creditApprvUser,
      this.creditApprvDate,
      this.creditApprvAmt,
      this.creditApprvLog,
      this.pending,
      this.cancel,
      this.cancelDate,
      this.posted,
      this.complete,
      this.clear,
      this.fullyBilled,
      this.tlBilledAmt,
      this.tlPaidAmt,
      this.readOnly,
      this.createUser,
      this.createDate,
      this.editUser,
      this.editDate,
      this.deleted,
      this.compCode,
      this.branchCode,
      this.rowKey,
      this.lastupload,
      this.duplicateKey,
      this.validateFailed,
      this.validateRemark,
      this.lastValidate,
      this.transtamp,
      this.packageCode,
      this.packageDesc});

  GetOrderListSlsTrn.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    merchantNo = json['merchant_no'];
    docDoc = json['doc_doc'];
    docRef = json['doc_ref'];
    slsDoc = json['sls_doc'];
    slsRef = json['sls_ref'];
    revNo = json['rev_no'];
    ordDate = json['ord_date'];
    ordTime = json['ord_time'];
    wfStatus = json['wf_status'];
    refNo = json['ref_no'];
    subject = json['subject'];
    validity = json['validity'];
    leadTime = json['lead_time'];
    dbcode = json['dbcode'];
    icNo = json['ic_no'];
    name = json['name'];
    branch = json['branch'];
    locCode = json['loc_code'];
    areaCode = json['area_code'];
    currency = json['currency'];
    rate = json['rate'];
    terms = json['terms'];
    salesPer = json['sales_per'];
    projCode = json['proj_code'];
    orderBy = json['order_by'];
    custPoNo = json['cust_po_no'];
    custPoDate = json['cust_po_date'];
    shipmentTerm = json['shipment_term'];
    shipmentTermDetl = json['shipment_term_detl'];
    shipMode = json['ship_mode'];
    shipCode = json['ship_code'];
    shipTo = json['ship_to'];
    shipName = json['ship_name'];
    shipAdd = json['ship_add'];
    shipAdd1 = json['ship_add1'];
    shipAdd2 = json['ship_add2'];
    shipAdd3 = json['ship_add3'];
    shipAdd4 = json['ship_add4'];
    shipArea = json['ship_area'];
    shipPhone = json['ship_phone'];
    shipFax = json['ship_fax'];
    shipPtc = json['ship_ptc'];
    shipRemark = json['ship_remark'];
    misc1 = json['misc1'];
    misc2 = json['misc2'];
    misc3 = json['misc3'];
    misc4 = json['misc4'];
    misc5 = json['misc5'];
    misc6 = json['misc6'];
    misc13 = json['misc13'];
    misc14 = json['misc14'];
    misc15 = json['misc15'];
    misc16 = json['misc16'];
    misc17 = json['misc17'];
    misc18 = json['misc18'];
    tlOrdQty = json['tl_ord_qty'];
    tlOrdAmt = json['tl_ord_amt'];
    tlNettDetlAmt = json['tl_nett_detl_amt'];
    tlLocDetlAmt = json['tl_loc_detl_amt'];
    tlNettOrdAmt = json['tl_nett_ord_amt'];
    tlLocOrdAmt = json['tl_loc_ord_amt'];
    tlDiscAmt = json['tl_disc_amt'];
    tlLocDiscAmt = json['tl_loc_disc_amt'];
    tlSlsTax = json['tl_sls_tax'];
    tlLocSlsTax = json['tl_loc_sls_tax'];
    tlSerTax = json['tl_ser_tax'];
    tlLocSerTax = json['tl_loc_ser_tax'];
    bdiscRate = json['bdisc_rate'];
    bdiscAmt = json['bdisc_amt'];
    transChrg = json['trans_chrg'];
    transRate = json['trans_rate'];
    mfgCurrency = json['mfg_currency'];
    mfgRate = json['mfg_rate'];
    mfgTlNettOrdAmt = json['mfg_tl_nett_ord_amt'];
    mfgTlLocOrdAmt = json['mfg_tl_loc_ord_amt'];
    hold = json['hold'];
    cj5No = json['cj5_no'];
    dbAcct = json['db_acct'];
    dbDept = json['db_dept'];
    tlDlvQty = json['tl_dlv_qty'];
    doDoc = json['do_doc'];
    doRef = json['do_ref'];
    invDoc = json['inv_doc'];
    invRef = json['inv_ref'];
    title1 = json['title1'];
    title2 = json['title2'];
    title3 = json['title3'];
    remark = json['remark'];
    remark1 = json['remark1'];
    remark2 = json['remark2'];
    prnCount = json['prn_count'];
    printLog = json['print_log'];
    trnStatus = json['trn_status'];
    creditBlockReason = json['credit_block_reason'];
    creditBlockInfo = json['credit_block_info'];
    creditReqApprv = json['credit_req_apprv'];
    creditApprvUser = json['credit_apprv_user'];
    creditApprvDate = json['credit_apprv_date'];
    creditApprvAmt = json['credit_apprv_amt'];
    creditApprvLog = json['credit_apprv_log'];
    pending = json['pending'];
    cancel = json['cancel'];
    cancelDate = json['cancel_date'];
    posted = json['posted'];
    complete = json['complete'];
    clear = json['clear'];
    fullyBilled = json['fully_billed'];
    tlBilledAmt = json['tl_billed_amt'];
    tlPaidAmt = json['tl_paid_amt'];
    readOnly = json['read_only'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    deleted = json['deleted'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    rowKey = json['row_key'];
    lastupload = json['lastupload'];
    duplicateKey = json['duplicate_key'];
    validateFailed = json['validate_failed'];
    validateRemark = json['validate_remark'];
    lastValidate = json['last_validate'];
    transtamp = json['transtamp'];
    packageCode = json['package_code'];
    packageDesc = json['package_desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['merchant_no'] = this.merchantNo;
    data['doc_doc'] = this.docDoc;
    data['doc_ref'] = this.docRef;
    data['sls_doc'] = this.slsDoc;
    data['sls_ref'] = this.slsRef;
    data['rev_no'] = this.revNo;
    data['ord_date'] = this.ordDate;
    data['ord_time'] = this.ordTime;
    data['wf_status'] = this.wfStatus;
    data['ref_no'] = this.refNo;
    data['subject'] = this.subject;
    data['validity'] = this.validity;
    data['lead_time'] = this.leadTime;
    data['dbcode'] = this.dbcode;
    data['ic_no'] = this.icNo;
    data['name'] = this.name;
    data['branch'] = this.branch;
    data['loc_code'] = this.locCode;
    data['area_code'] = this.areaCode;
    data['currency'] = this.currency;
    data['rate'] = this.rate;
    data['terms'] = this.terms;
    data['sales_per'] = this.salesPer;
    data['proj_code'] = this.projCode;
    data['order_by'] = this.orderBy;
    data['cust_po_no'] = this.custPoNo;
    data['cust_po_date'] = this.custPoDate;
    data['shipment_term'] = this.shipmentTerm;
    data['shipment_term_detl'] = this.shipmentTermDetl;
    data['ship_mode'] = this.shipMode;
    data['ship_code'] = this.shipCode;
    data['ship_to'] = this.shipTo;
    data['ship_name'] = this.shipName;
    data['ship_add'] = this.shipAdd;
    data['ship_add1'] = this.shipAdd1;
    data['ship_add2'] = this.shipAdd2;
    data['ship_add3'] = this.shipAdd3;
    data['ship_add4'] = this.shipAdd4;
    data['ship_area'] = this.shipArea;
    data['ship_phone'] = this.shipPhone;
    data['ship_fax'] = this.shipFax;
    data['ship_ptc'] = this.shipPtc;
    data['ship_remark'] = this.shipRemark;
    data['misc1'] = this.misc1;
    data['misc2'] = this.misc2;
    data['misc3'] = this.misc3;
    data['misc4'] = this.misc4;
    data['misc5'] = this.misc5;
    data['misc6'] = this.misc6;
    data['misc13'] = this.misc13;
    data['misc14'] = this.misc14;
    data['misc15'] = this.misc15;
    data['misc16'] = this.misc16;
    data['misc17'] = this.misc17;
    data['misc18'] = this.misc18;
    data['tl_ord_qty'] = this.tlOrdQty;
    data['tl_ord_amt'] = this.tlOrdAmt;
    data['tl_nett_detl_amt'] = this.tlNettDetlAmt;
    data['tl_loc_detl_amt'] = this.tlLocDetlAmt;
    data['tl_nett_ord_amt'] = this.tlNettOrdAmt;
    data['tl_loc_ord_amt'] = this.tlLocOrdAmt;
    data['tl_disc_amt'] = this.tlDiscAmt;
    data['tl_loc_disc_amt'] = this.tlLocDiscAmt;
    data['tl_sls_tax'] = this.tlSlsTax;
    data['tl_loc_sls_tax'] = this.tlLocSlsTax;
    data['tl_ser_tax'] = this.tlSerTax;
    data['tl_loc_ser_tax'] = this.tlLocSerTax;
    data['bdisc_rate'] = this.bdiscRate;
    data['bdisc_amt'] = this.bdiscAmt;
    data['trans_chrg'] = this.transChrg;
    data['trans_rate'] = this.transRate;
    data['mfg_currency'] = this.mfgCurrency;
    data['mfg_rate'] = this.mfgRate;
    data['mfg_tl_nett_ord_amt'] = this.mfgTlNettOrdAmt;
    data['mfg_tl_loc_ord_amt'] = this.mfgTlLocOrdAmt;
    data['hold'] = this.hold;
    data['cj5_no'] = this.cj5No;
    data['db_acct'] = this.dbAcct;
    data['db_dept'] = this.dbDept;
    data['tl_dlv_qty'] = this.tlDlvQty;
    data['do_doc'] = this.doDoc;
    data['do_ref'] = this.doRef;
    data['inv_doc'] = this.invDoc;
    data['inv_ref'] = this.invRef;
    data['title1'] = this.title1;
    data['title2'] = this.title2;
    data['title3'] = this.title3;
    data['remark'] = this.remark;
    data['remark1'] = this.remark1;
    data['remark2'] = this.remark2;
    data['prn_count'] = this.prnCount;
    data['print_log'] = this.printLog;
    data['trn_status'] = this.trnStatus;
    data['credit_block_reason'] = this.creditBlockReason;
    data['credit_block_info'] = this.creditBlockInfo;
    data['credit_req_apprv'] = this.creditReqApprv;
    data['credit_apprv_user'] = this.creditApprvUser;
    data['credit_apprv_date'] = this.creditApprvDate;
    data['credit_apprv_amt'] = this.creditApprvAmt;
    data['credit_apprv_log'] = this.creditApprvLog;
    data['pending'] = this.pending;
    data['cancel'] = this.cancel;
    data['cancel_date'] = this.cancelDate;
    data['posted'] = this.posted;
    data['complete'] = this.complete;
    data['clear'] = this.clear;
    data['fully_billed'] = this.fullyBilled;
    data['tl_billed_amt'] = this.tlBilledAmt;
    data['tl_paid_amt'] = this.tlPaidAmt;
    data['read_only'] = this.readOnly;
    data['create_user'] = this.createUser;
    data['create_date'] = this.createDate;
    data['edit_user'] = this.editUser;
    data['edit_date'] = this.editDate;
    data['deleted'] = this.deleted;
    data['comp_code'] = this.compCode;
    data['branch_code'] = this.branchCode;
    data['row_key'] = this.rowKey;
    data['lastupload'] = this.lastupload;
    data['duplicate_key'] = this.duplicateKey;
    data['validate_failed'] = this.validateFailed;
    data['validate_remark'] = this.validateRemark;
    data['last_validate'] = this.lastValidate;
    data['transtamp'] = this.transtamp;
    data['package_code'] = this.packageCode;
    data['package_desc'] = this.packageDesc;
    return data;
  }
}

class GetOrderDetlByOrderNoResponse {
  List<SlsDetl>? slsDetl;

  GetOrderDetlByOrderNoResponse({this.slsDetl});

  GetOrderDetlByOrderNoResponse.fromJson(Map<String, dynamic> json) {
    if (json['SlsDetl'] != null) {
      slsDetl = new List<SlsDetl>.empty(growable: true);
      json['SlsDetl'].forEach((v) {
        slsDetl!.add(new SlsDetl.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.slsDetl != null) {
      data['SlsDetl'] = this.slsDetl!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SlsDetl {
  String? iD;
  String? merchantNo;
  String? docDoc;
  String? docRef;
  String? ordDate;
  String? slsDoc;
  String? slsRef;
  String? key;
  String? mainKey;
  String? subItem;
  String? stkFormula;
  String? itemNo;
  String? locCode;
  String? branch;
  String? packageCode;
  String? packageDesc;
  String? uom;
  String? existQty;
  String? ordQty;
  String? ordUom;
  String? ordPrice;
  String? unitPrice;
  String? itemQty;
  String? itemUom;
  String? itemPrice;
  String? extraQty;
  String? extraUom;
  String? extraPrice;
  String? uom2Qty;
  String? uom2Uom;
  String? focQty;
  String? focUom;
  String? fillQty;
  String? manuQty;
  String? tlmanuQty;
  String? manufQty;
  String? tlManufQty;
  String? packedQty;
  String? priceCode;
  String? priceSource;
  String? allowDisc;
  String? discCode;
  String? discRate;
  String? multiDisc;
  String? discAmt;
  String? locDiscAmt;
  String? serTax;
  String? locSerTax;
  String? inclSlsTax;
  String? slsTax;
  String? locSlsTax;
  String? slsCommRate;
  String? slsComm;
  String? locSlsComm;
  String? nettPrice;
  String? ordAmt;
  String? nettOrdAmt;
  String? locOrdAmt;
  String? mfgUnitPrice;
  String? mfgNettOrdAmt;
  String? mfgLocOrdAmt;
  String? unitCost;
  String? custPoNo;
  String? custPoDate;
  String? expDlvdt;
  String? dueDate;
  String? dueTime;
  String? invDoc;
  String? invRef;
  String? doDoc;
  String? doRef;
  String? invKey;
  String? doKey;
  String? quoDoc;
  String? quoRef;
  String? quoKey;
  String? dlvQty;
  String? dlvIqty;
  String? dlvEqty;
  String? dlvFqty;
  String? woQty;
  String? poQty;
  String? poDoc;
  String? poRef;
  String? poKey;
  String? matrlreqQty;
  String? matrlreqClosed;
  String? billedQty;
  String? projCode;
  String? custBarcode;
  String? custSellPrice;
  String? misc7;
  String? misc8;
  String? misc9;
  String? misc10;
  String? misc11;
  String? misc12;
  String? dlvMisc10;
  String? dlvMisc11;
  String? dlvMisc12;
  String? stkMisc1;
  String? stkMisc2;
  String? stkMisc3;
  String? custRef1;
  String? custRef2;
  String? undrMinpc;
  String? cj5No;
  String? cj5Bgdt;
  String? cj5Enddt;
  String? cj5Totqty;
  String? cj5Balqty;
  String? saleAcct;
  String? saleDept;
  String? remark;
  String? trnStatus;
  String? complete;
  String? completedRemark;
  String? completedUser;
  String? completedDate;
  String? matrlReserved;
  String? cancel;
  String? createUser;
  String? createDate;
  String? editUser;
  String? editDate;
  String? deleted;
  String? compCode;
  String? branchCode;
  String? rowKey;
  String? lastupload;
  String? duplicateKey;
  String? validateFailed;
  String? validateRemark;
  String? lastValidate;
  String? transtamp;
  String? frmStoreQty;

  SlsDetl(
      {this.iD,
      this.merchantNo,
      this.docDoc,
      this.docRef,
      this.ordDate,
      this.slsDoc,
      this.slsRef,
      this.key,
      this.mainKey,
      this.subItem,
      this.stkFormula,
      this.itemNo,
      this.locCode,
      this.branch,
      this.packageCode,
      this.packageDesc,
      this.uom,
      this.existQty,
      this.ordQty,
      this.ordUom,
      this.ordPrice,
      this.unitPrice,
      this.itemQty,
      this.itemUom,
      this.itemPrice,
      this.extraQty,
      this.extraUom,
      this.extraPrice,
      this.uom2Qty,
      this.uom2Uom,
      this.focQty,
      this.focUom,
      this.fillQty,
      this.manuQty,
      this.tlmanuQty,
      this.manufQty,
      this.tlManufQty,
      this.packedQty,
      this.priceCode,
      this.priceSource,
      this.allowDisc,
      this.discCode,
      this.discRate,
      this.multiDisc,
      this.discAmt,
      this.locDiscAmt,
      this.serTax,
      this.locSerTax,
      this.inclSlsTax,
      this.slsTax,
      this.locSlsTax,
      this.slsCommRate,
      this.slsComm,
      this.locSlsComm,
      this.nettPrice,
      this.ordAmt,
      this.nettOrdAmt,
      this.locOrdAmt,
      this.mfgUnitPrice,
      this.mfgNettOrdAmt,
      this.mfgLocOrdAmt,
      this.unitCost,
      this.custPoNo,
      this.custPoDate,
      this.expDlvdt,
      this.dueDate,
      this.dueTime,
      this.invDoc,
      this.invRef,
      this.doDoc,
      this.doRef,
      this.invKey,
      this.doKey,
      this.quoDoc,
      this.quoRef,
      this.quoKey,
      this.dlvQty,
      this.dlvIqty,
      this.dlvEqty,
      this.dlvFqty,
      this.woQty,
      this.poQty,
      this.poDoc,
      this.poRef,
      this.poKey,
      this.matrlreqQty,
      this.matrlreqClosed,
      this.billedQty,
      this.projCode,
      this.custBarcode,
      this.custSellPrice,
      this.misc7,
      this.misc8,
      this.misc9,
      this.misc10,
      this.misc11,
      this.misc12,
      this.dlvMisc10,
      this.dlvMisc11,
      this.dlvMisc12,
      this.stkMisc1,
      this.stkMisc2,
      this.stkMisc3,
      this.custRef1,
      this.custRef2,
      this.undrMinpc,
      this.cj5No,
      this.cj5Bgdt,
      this.cj5Enddt,
      this.cj5Totqty,
      this.cj5Balqty,
      this.saleAcct,
      this.saleDept,
      this.remark,
      this.trnStatus,
      this.complete,
      this.completedRemark,
      this.completedUser,
      this.completedDate,
      this.matrlReserved,
      this.cancel,
      this.createUser,
      this.createDate,
      this.editUser,
      this.editDate,
      this.deleted,
      this.compCode,
      this.branchCode,
      this.rowKey,
      this.lastupload,
      this.duplicateKey,
      this.validateFailed,
      this.validateRemark,
      this.lastValidate,
      this.transtamp,
      this.frmStoreQty});

  SlsDetl.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    merchantNo = json['merchant_no'];
    docDoc = json['doc_doc'];
    docRef = json['doc_ref'];
    ordDate = json['ord_date'];
    slsDoc = json['sls_doc'];
    slsRef = json['sls_ref'];
    key = json['key'];
    mainKey = json['main_key'];
    subItem = json['sub_item'];
    stkFormula = json['stk_formula'];
    itemNo = json['item_no'];
    locCode = json['loc_code'];
    branch = json['branch'];
    packageCode = json['package_code'];
    packageDesc = json['package_desc'];
    uom = json['uom'];
    existQty = json['exist_qty'];
    ordQty = json['ord_qty'];
    ordUom = json['ord_uom'];
    ordPrice = json['ord_price'];
    unitPrice = json['unit_price'];
    itemQty = json['item_qty'];
    itemUom = json['item_uom'];
    itemPrice = json['item_price'];
    extraQty = json['extra_qty'];
    extraUom = json['extra_uom'];
    extraPrice = json['extra_price'];
    uom2Qty = json['uom2_qty'];
    uom2Uom = json['uom2_uom'];
    focQty = json['foc_qty'];
    focUom = json['foc_uom'];
    fillQty = json['fill_qty'];
    manuQty = json['manu_qty'];
    tlmanuQty = json['tlmanu_qty'];
    manufQty = json['manuf_qty'];
    tlManufQty = json['tl_manuf_qty'];
    packedQty = json['packed_qty'];
    priceCode = json['price_code'];
    priceSource = json['price_source'];
    allowDisc = json['allow_disc'];
    discCode = json['disc_code'];
    discRate = json['disc_rate'];
    multiDisc = json['multi_disc'];
    discAmt = json['disc_amt'];
    locDiscAmt = json['loc_disc_amt'];
    serTax = json['ser_tax'];
    locSerTax = json['loc_ser_tax'];
    inclSlsTax = json['incl_sls_tax'];
    slsTax = json['sls_tax'];
    locSlsTax = json['loc_sls_tax'];
    slsCommRate = json['sls_comm_rate'];
    slsComm = json['sls_comm'];
    locSlsComm = json['loc_sls_comm'];
    nettPrice = json['nett_price'];
    ordAmt = json['ord_amt'];
    nettOrdAmt = json['nett_ord_amt'];
    locOrdAmt = json['loc_ord_amt'];
    mfgUnitPrice = json['mfg_unit_price'];
    mfgNettOrdAmt = json['mfg_nett_ord_amt'];
    mfgLocOrdAmt = json['mfg_loc_ord_amt'];
    unitCost = json['unit_cost'];
    custPoNo = json['cust_po_no'];
    custPoDate = json['cust_po_date'];
    expDlvdt = json['exp_dlvdt'];
    dueDate = json['due_date'];
    dueTime = json['due_time'];
    invDoc = json['inv_doc'];
    invRef = json['inv_ref'];
    doDoc = json['do_doc'];
    doRef = json['do_ref'];
    invKey = json['inv_key'];
    doKey = json['do_key'];
    quoDoc = json['quo_doc'];
    quoRef = json['quo_ref'];
    quoKey = json['quo_key'];
    dlvQty = json['dlv_qty'];
    dlvIqty = json['dlv_iqty'];
    dlvEqty = json['dlv_eqty'];
    dlvFqty = json['dlv_fqty'];
    woQty = json['wo_qty'];
    poQty = json['po_qty'];
    poDoc = json['po_doc'];
    poRef = json['po_ref'];
    poKey = json['po_key'];
    matrlreqQty = json['matrlreq_qty'];
    matrlreqClosed = json['matrlreq_closed'];
    billedQty = json['billed_qty'];
    projCode = json['proj_code'];
    custBarcode = json['cust_barcode'];
    custSellPrice = json['cust_sell_price'];
    misc7 = json['misc7'];
    misc8 = json['misc8'];
    misc9 = json['misc9'];
    misc10 = json['misc10'];
    misc11 = json['misc11'];
    misc12 = json['misc12'];
    dlvMisc10 = json['dlv_misc10'];
    dlvMisc11 = json['dlv_misc11'];
    dlvMisc12 = json['dlv_misc12'];
    stkMisc1 = json['stk_misc1'];
    stkMisc2 = json['stk_misc2'];
    stkMisc3 = json['stk_misc3'];
    custRef1 = json['cust_ref1'];
    custRef2 = json['cust_ref2'];
    undrMinpc = json['undr_minpc'];
    cj5No = json['cj5_no'];
    cj5Bgdt = json['cj5_bgdt'];
    cj5Enddt = json['cj5_enddt'];
    cj5Totqty = json['cj5_totqty'];
    cj5Balqty = json['cj5_balqty'];
    saleAcct = json['sale_acct'];
    saleDept = json['sale_dept'];
    remark = json['remark'];
    trnStatus = json['trn_status'];
    complete = json['complete'];
    completedRemark = json['completed_remark'];
    completedUser = json['completed_user'];
    completedDate = json['completed_date'];
    matrlReserved = json['matrl_reserved'];
    cancel = json['cancel'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    deleted = json['deleted'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    rowKey = json['row_key'];
    lastupload = json['lastupload'];
    duplicateKey = json['duplicate_key'];
    validateFailed = json['validate_failed'];
    validateRemark = json['validate_remark'];
    lastValidate = json['last_validate'];
    transtamp = json['transtamp'];
    frmStoreQty = json['frm_store_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['merchant_no'] = this.merchantNo;
    data['doc_doc'] = this.docDoc;
    data['doc_ref'] = this.docRef;
    data['ord_date'] = this.ordDate;
    data['sls_doc'] = this.slsDoc;
    data['sls_ref'] = this.slsRef;
    data['key'] = this.key;
    data['main_key'] = this.mainKey;
    data['sub_item'] = this.subItem;
    data['stk_formula'] = this.stkFormula;
    data['item_no'] = this.itemNo;
    data['loc_code'] = this.locCode;
    data['branch'] = this.branch;
    data['package_code'] = this.packageCode;
    data['package_desc'] = this.packageDesc;
    data['uom'] = this.uom;
    data['exist_qty'] = this.existQty;
    data['ord_qty'] = this.ordQty;
    data['ord_uom'] = this.ordUom;
    data['ord_price'] = this.ordPrice;
    data['unit_price'] = this.unitPrice;
    data['item_qty'] = this.itemQty;
    data['item_uom'] = this.itemUom;
    data['item_price'] = this.itemPrice;
    data['extra_qty'] = this.extraQty;
    data['extra_uom'] = this.extraUom;
    data['extra_price'] = this.extraPrice;
    data['uom2_qty'] = this.uom2Qty;
    data['uom2_uom'] = this.uom2Uom;
    data['foc_qty'] = this.focQty;
    data['foc_uom'] = this.focUom;
    data['fill_qty'] = this.fillQty;
    data['manu_qty'] = this.manuQty;
    data['tlmanu_qty'] = this.tlmanuQty;
    data['manuf_qty'] = this.manufQty;
    data['tl_manuf_qty'] = this.tlManufQty;
    data['packed_qty'] = this.packedQty;
    data['price_code'] = this.priceCode;
    data['price_source'] = this.priceSource;
    data['allow_disc'] = this.allowDisc;
    data['disc_code'] = this.discCode;
    data['disc_rate'] = this.discRate;
    data['multi_disc'] = this.multiDisc;
    data['disc_amt'] = this.discAmt;
    data['loc_disc_amt'] = this.locDiscAmt;
    data['ser_tax'] = this.serTax;
    data['loc_ser_tax'] = this.locSerTax;
    data['incl_sls_tax'] = this.inclSlsTax;
    data['sls_tax'] = this.slsTax;
    data['loc_sls_tax'] = this.locSlsTax;
    data['sls_comm_rate'] = this.slsCommRate;
    data['sls_comm'] = this.slsComm;
    data['loc_sls_comm'] = this.locSlsComm;
    data['nett_price'] = this.nettPrice;
    data['ord_amt'] = this.ordAmt;
    data['nett_ord_amt'] = this.nettOrdAmt;
    data['loc_ord_amt'] = this.locOrdAmt;
    data['mfg_unit_price'] = this.mfgUnitPrice;
    data['mfg_nett_ord_amt'] = this.mfgNettOrdAmt;
    data['mfg_loc_ord_amt'] = this.mfgLocOrdAmt;
    data['unit_cost'] = this.unitCost;
    data['cust_po_no'] = this.custPoNo;
    data['cust_po_date'] = this.custPoDate;
    data['exp_dlvdt'] = this.expDlvdt;
    data['due_date'] = this.dueDate;
    data['due_time'] = this.dueTime;
    data['inv_doc'] = this.invDoc;
    data['inv_ref'] = this.invRef;
    data['do_doc'] = this.doDoc;
    data['do_ref'] = this.doRef;
    data['inv_key'] = this.invKey;
    data['do_key'] = this.doKey;
    data['quo_doc'] = this.quoDoc;
    data['quo_ref'] = this.quoRef;
    data['quo_key'] = this.quoKey;
    data['dlv_qty'] = this.dlvQty;
    data['dlv_iqty'] = this.dlvIqty;
    data['dlv_eqty'] = this.dlvEqty;
    data['dlv_fqty'] = this.dlvFqty;
    data['wo_qty'] = this.woQty;
    data['po_qty'] = this.poQty;
    data['po_doc'] = this.poDoc;
    data['po_ref'] = this.poRef;
    data['po_key'] = this.poKey;
    data['matrlreq_qty'] = this.matrlreqQty;
    data['matrlreq_closed'] = this.matrlreqClosed;
    data['billed_qty'] = this.billedQty;
    data['proj_code'] = this.projCode;
    data['cust_barcode'] = this.custBarcode;
    data['cust_sell_price'] = this.custSellPrice;
    data['misc7'] = this.misc7;
    data['misc8'] = this.misc8;
    data['misc9'] = this.misc9;
    data['misc10'] = this.misc10;
    data['misc11'] = this.misc11;
    data['misc12'] = this.misc12;
    data['dlv_misc10'] = this.dlvMisc10;
    data['dlv_misc11'] = this.dlvMisc11;
    data['dlv_misc12'] = this.dlvMisc12;
    data['stk_misc1'] = this.stkMisc1;
    data['stk_misc2'] = this.stkMisc2;
    data['stk_misc3'] = this.stkMisc3;
    data['cust_ref1'] = this.custRef1;
    data['cust_ref2'] = this.custRef2;
    data['undr_minpc'] = this.undrMinpc;
    data['cj5_no'] = this.cj5No;
    data['cj5_bgdt'] = this.cj5Bgdt;
    data['cj5_enddt'] = this.cj5Enddt;
    data['cj5_totqty'] = this.cj5Totqty;
    data['cj5_balqty'] = this.cj5Balqty;
    data['sale_acct'] = this.saleAcct;
    data['sale_dept'] = this.saleDept;
    data['remark'] = this.remark;
    data['trn_status'] = this.trnStatus;
    data['complete'] = this.complete;
    data['completed_remark'] = this.completedRemark;
    data['completed_user'] = this.completedUser;
    data['completed_date'] = this.completedDate;
    data['matrl_reserved'] = this.matrlReserved;
    data['cancel'] = this.cancel;
    data['create_user'] = this.createUser;
    data['create_date'] = this.createDate;
    data['edit_user'] = this.editUser;
    data['edit_date'] = this.editDate;
    data['deleted'] = this.deleted;
    data['comp_code'] = this.compCode;
    data['branch_code'] = this.branchCode;
    data['row_key'] = this.rowKey;
    data['lastupload'] = this.lastupload;
    data['duplicate_key'] = this.duplicateKey;
    data['validate_failed'] = this.validateFailed;
    data['validate_remark'] = this.validateRemark;
    data['last_validate'] = this.lastValidate;
    data['transtamp'] = this.transtamp;
    data['frm_store_qty'] = this.frmStoreQty;
    return data;
  }
}

class FpxSendB2CAuthResponse {
  List<FpxResponse>? response;

  FpxSendB2CAuthResponse({this.response});

  FpxSendB2CAuthResponse.fromJson(Map<String, dynamic> json) {
    if (json['Response'] != null) {
      response = new List<FpxResponse>.empty(growable: true);
      json['Response'].forEach((v) {
        response!.add(new FpxResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['Response'] = this.response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FpxResponse {
  String? requestUrl;
  String? requestData;
  String? responseCode;
  String? responseDescription;
  String? responseData;
  String? transId;
  String? sessionId;
  String? signatureString;

  FpxResponse(
      {this.requestUrl,
      this.requestData,
      this.responseCode,
      this.responseDescription,
      this.responseData,
      this.transId,
      this.sessionId,
      this.signatureString});

  FpxResponse.fromJson(Map<String, dynamic> json) {
    requestUrl = json['requestUrl'];
    requestData = json['requestData'];
    responseCode = json['responseCode'];
    responseDescription = json['responseDescription'];
    responseData = json['responseData'];
    transId = json['transId'];
    sessionId = json['sessionId'];
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
    data['signatureString'] = this.signatureString;
    return data;
  }
}

class GetOnlinePaymentByOrderNoResponse {
  List<OnlinePaymentByOrderNo>? onlinePayment;

  GetOnlinePaymentByOrderNoResponse({this.onlinePayment});

  GetOnlinePaymentByOrderNoResponse.fromJson(Map<String, dynamic> json) {
    if (json['OnlinePayment'] != null) {
      onlinePayment = new List<OnlinePaymentByOrderNo>.empty(growable: true);
      json['OnlinePayment'].forEach((v) {
        onlinePayment!.add(new OnlinePaymentByOrderNo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.onlinePayment != null) {
      data['OnlinePayment'] =
          this.onlinePayment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OnlinePaymentByOrderNo {
  String? iD;
  String? merchantNo;
  String? docDoc;
  String? docRef;
  String? paymentDate;
  String? paymentTime;
  String? dbcode;
  String? icNo;
  String? name;
  String? source;
  String? sourceDoc;
  String? sourceRef;
  String? currency;
  String? paidAmt;
  String? gatewayId;
  String? transId;
  String? transDatetime;
  String? gatewayTransId;
  String? bankId;
  String? bankName;
  String? sessionId;
  String? responseCode;
  String? responseData;
  String? status;
  String? createUser;
  String? createDate;
  String? editUser;
  String? editDate;
  String? deleted;
  String? compCode;
  String? branchCode;
  String? rowKey;
  String? lastupload;
  String? duplicateKey;
  String? validateFailed;
  String? validateRemark;
  String? lastValidate;
  String? transtamp;
  String? receiptUrl;

  OnlinePaymentByOrderNo(
      {this.iD,
      this.merchantNo,
      this.docDoc,
      this.docRef,
      this.paymentDate,
      this.paymentTime,
      this.dbcode,
      this.icNo,
      this.name,
      this.source,
      this.sourceDoc,
      this.sourceRef,
      this.currency,
      this.paidAmt,
      this.gatewayId,
      this.transId,
      this.transDatetime,
      this.gatewayTransId,
      this.bankId,
      this.bankName,
      this.sessionId,
      this.responseCode,
      this.responseData,
      this.status,
      this.createUser,
      this.createDate,
      this.editUser,
      this.editDate,
      this.deleted,
      this.compCode,
      this.branchCode,
      this.rowKey,
      this.lastupload,
      this.duplicateKey,
      this.validateFailed,
      this.validateRemark,
      this.lastValidate,
      this.transtamp,
      this.receiptUrl});

  OnlinePaymentByOrderNo.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    merchantNo = json['merchant_no'];
    docDoc = json['doc_doc'];
    docRef = json['doc_ref'];
    paymentDate = json['payment_date'];
    paymentTime = json['payment_time'];
    dbcode = json['dbcode'];
    icNo = json['ic_no'];
    name = json['name'];
    source = json['source'];
    sourceDoc = json['source_doc'];
    sourceRef = json['source_ref'];
    currency = json['currency'];
    paidAmt = json['paid_amt'];
    gatewayId = json['gateway_id'];
    transId = json['trans_id'];
    transDatetime = json['trans_datetime'];
    gatewayTransId = json['gateway_trans_id'];
    bankId = json['bank_id'];
    bankName = json['bank_name'];
    sessionId = json['session_id'];
    responseCode = json['response_code'];
    responseData = json['response_data'];
    status = json['status'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    deleted = json['deleted'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    rowKey = json['row_key'];
    lastupload = json['lastupload'];
    duplicateKey = json['duplicate_key'];
    validateFailed = json['validate_failed'];
    validateRemark = json['validate_remark'];
    lastValidate = json['last_validate'];
    transtamp = json['transtamp'];
    receiptUrl = json['receipt_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['merchant_no'] = this.merchantNo;
    data['doc_doc'] = this.docDoc;
    data['doc_ref'] = this.docRef;
    data['payment_date'] = this.paymentDate;
    data['payment_time'] = this.paymentTime;
    data['dbcode'] = this.dbcode;
    data['ic_no'] = this.icNo;
    data['name'] = this.name;
    data['source'] = this.source;
    data['source_doc'] = this.sourceDoc;
    data['source_ref'] = this.sourceRef;
    data['currency'] = this.currency;
    data['paid_amt'] = this.paidAmt;
    data['gateway_id'] = this.gatewayId;
    data['trans_id'] = this.transId;
    data['trans_datetime'] = this.transDatetime;
    data['gateway_trans_id'] = this.gatewayTransId;
    data['bank_id'] = this.bankId;
    data['bank_name'] = this.bankName;
    data['session_id'] = this.sessionId;
    data['response_code'] = this.responseCode;
    data['response_data'] = this.responseData;
    data['status'] = this.status;
    data['create_user'] = this.createUser;
    data['create_date'] = this.createDate;
    data['edit_user'] = this.editUser;
    data['edit_date'] = this.editDate;
    data['deleted'] = this.deleted;
    data['comp_code'] = this.compCode;
    data['branch_code'] = this.branchCode;
    data['row_key'] = this.rowKey;
    data['lastupload'] = this.lastupload;
    data['duplicate_key'] = this.duplicateKey;
    data['validate_failed'] = this.validateFailed;
    data['validate_remark'] = this.validateRemark;
    data['last_validate'] = this.lastValidate;
    data['transtamp'] = this.transtamp;
    data['receipt_url'] = this.receiptUrl;
    return data;
  }
}

class GetAppPaymentMenuResponse {
  List<AppPaymentMenu>? appPaymentMenu;

  GetAppPaymentMenuResponse({this.appPaymentMenu});

  GetAppPaymentMenuResponse.fromJson(Map<String, dynamic> json) {
    if (json['AppPaymentMenu'] != null) {
      appPaymentMenu = new List<AppPaymentMenu>.empty(growable: true);
      json['AppPaymentMenu'].forEach((v) {
        appPaymentMenu!.add(new AppPaymentMenu.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.appPaymentMenu != null) {
      data['AppPaymentMenu'] =
          this.appPaymentMenu!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AppPaymentMenu {
  String? iD;
  String? appCode;
  String? menuCode;
  String? codeDesc;
  String? createDate;
  String? createUser;
  String? editDate;
  String? editUser;
  String? lastupload;
  String? transtamp;
  String? compCode;
  String? branchCode;
  String? rowKey;
  String? deleted;

  AppPaymentMenu(
      {this.iD,
      this.appCode,
      this.menuCode,
      this.codeDesc,
      this.createDate,
      this.createUser,
      this.editDate,
      this.editUser,
      this.lastupload,
      this.transtamp,
      this.compCode,
      this.branchCode,
      this.rowKey,
      this.deleted});

  AppPaymentMenu.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    appCode = json['app_code'];
    menuCode = json['menu_code'];
    codeDesc = json['code_desc'];
    createDate = json['create_date'];
    createUser = json['create_user'];
    editDate = json['edit_date'];
    editUser = json['edit_user'];
    lastupload = json['lastupload'];
    transtamp = json['transtamp'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    rowKey = json['row_key'];
    deleted = json['deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['app_code'] = this.appCode;
    data['menu_code'] = this.menuCode;
    data['code_desc'] = this.codeDesc;
    data['create_date'] = this.createDate;
    data['create_user'] = this.createUser;
    data['edit_date'] = this.editDate;
    data['edit_user'] = this.editUser;
    data['lastupload'] = this.lastupload;
    data['transtamp'] = this.transtamp;
    data['comp_code'] = this.compCode;
    data['branch_code'] = this.branchCode;
    data['row_key'] = this.rowKey;
    data['deleted'] = this.deleted;
    return data;
  }
}

class GetMerchantPaymentGatewayResponse {
  List<MerchantPaymentGateway>? merchantPaymentGateway;

  GetMerchantPaymentGatewayResponse({this.merchantPaymentGateway});

  GetMerchantPaymentGatewayResponse.fromJson(Map<String, dynamic> json) {
    if (json['MerchantPaymentGateway'] != null) {
      merchantPaymentGateway =
          new List<MerchantPaymentGateway>.empty(growable: true);
      json['MerchantPaymentGateway'].forEach((v) {
        merchantPaymentGateway!.add(new MerchantPaymentGateway.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.merchantPaymentGateway != null) {
      data['MerchantPaymentGateway'] =
          this.merchantPaymentGateway!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MerchantPaymentGateway {
  String? iD;
  String? appCode;
  String? merchantNo;
  String? gatewayId;
  String? gatewayDesc;
  String? minAmt;
  String? createDate;
  String? createUser;
  String? editDate;
  String? editUser;
  String? lastupload;
  String? transtamp;
  String? compCode;
  String? branchCode;
  String? rowKey;
  String? deleted;

  MerchantPaymentGateway(
      {this.iD,
      this.appCode,
      this.merchantNo,
      this.gatewayId,
      this.gatewayDesc,
      this.minAmt,
      this.createDate,
      this.createUser,
      this.editDate,
      this.editUser,
      this.lastupload,
      this.transtamp,
      this.compCode,
      this.branchCode,
      this.rowKey,
      this.deleted});

  MerchantPaymentGateway.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    appCode = json['app_code'];
    merchantNo = json['merchant_no'];
    gatewayId = json['gateway_id'];
    gatewayDesc = json['gateway_desc'];
    minAmt = json['min_amt'];
    createDate = json['create_date'];
    createUser = json['create_user'];
    editDate = json['edit_date'];
    editUser = json['edit_user'];
    lastupload = json['lastupload'];
    transtamp = json['transtamp'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    rowKey = json['row_key'];
    deleted = json['deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['app_code'] = this.appCode;
    data['merchant_no'] = this.merchantNo;
    data['gateway_id'] = this.gatewayId;
    data['gateway_desc'] = this.gatewayDesc;
    data['min_amt'] = this.minAmt;
    data['create_date'] = this.createDate;
    data['create_user'] = this.createUser;
    data['edit_date'] = this.editDate;
    data['edit_user'] = this.editUser;
    data['lastupload'] = this.lastupload;
    data['transtamp'] = this.transtamp;
    data['comp_code'] = this.compCode;
    data['branch_code'] = this.branchCode;
    data['row_key'] = this.rowKey;
    data['deleted'] = this.deleted;
    return data;
  }
}
