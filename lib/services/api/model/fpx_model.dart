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

class CreateOrderRequest {
  String wsCodeCrypt;
  String caUid;
  String caPwd;
  String diCode;
  String userId;
  String icNo;
  String packageCode;

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

class CreateOrderResponse {
  List<SlsTrn> slsTrn;

  CreateOrderResponse({this.slsTrn});

  CreateOrderResponse.fromJson(Map<String, dynamic> json) {
    if (json['SlsTrn'] != null) {
      slsTrn = new List<SlsTrn>();
      json['SlsTrn'].forEach((v) {
        slsTrn.add(new SlsTrn.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.slsTrn != null) {
      data['SlsTrn'] = this.slsTrn.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SlsTrn {
  String iD;
  String merchantNo;
  String docDoc;
  String docRef;
  String slsDoc;
  String slsRef;
  String revNo;
  String ordDate;
  String ordTime;
  String wfStatus;
  String refNo;
  String subject;
  String validity;
  String leadTime;
  String dbcode;
  String icNo;
  String name;
  String branch;
  String locCode;
  String areaCode;
  String currency;
  String rate;
  String terms;
  String salesPer;
  String projCode;
  String orderBy;
  String custPoNo;
  String custPoDate;
  String shipmentTerm;
  String shipmentTermDetl;
  String shipMode;
  String shipCode;
  String shipTo;
  String shipName;
  String shipAdd;
  String shipAdd1;
  String shipAdd2;
  String shipAdd3;
  String shipAdd4;
  String shipArea;
  String shipPhone;
  String shipFax;
  String shipPtc;
  String shipRemark;
  String misc1;
  String misc2;
  String misc3;
  String misc4;
  String misc5;
  String misc6;
  String misc13;
  String misc14;
  String misc15;
  String misc16;
  String misc17;
  String misc18;
  String tlOrdQty;
  String tlOrdAmt;
  String tlNettDetlAmt;
  String tlLocDetlAmt;
  String tlNettOrdAmt;
  String tlLocOrdAmt;
  String tlDiscAmt;
  String tlLocDiscAmt;
  String tlSlsTax;
  String tlLocSlsTax;
  String tlSerTax;
  String tlLocSerTax;
  String bdiscRate;
  String bdiscAmt;
  String transChrg;
  String transRate;
  String mfgCurrency;
  String mfgRate;
  String mfgTlNettOrdAmt;
  String mfgTlLocOrdAmt;
  String hold;
  String cj5No;
  String dbAcct;
  String dbDept;
  String tlDlvQty;
  String doDoc;
  String doRef;
  String invDoc;
  String invRef;
  String title1;
  String title2;
  String title3;
  String remark;
  String remark1;
  String remark2;
  String prnCount;
  String printLog;
  String trnStatus;
  String creditBlockReason;
  String creditBlockInfo;
  String creditReqApprv;
  String creditApprvUser;
  String creditApprvDate;
  String creditApprvAmt;
  String creditApprvLog;
  String pending;
  String cancel;
  String cancelDate;
  String posted;
  String complete;
  String clear;
  String fullyBilled;
  String tlBilledAmt;
  String tlPaidAmt;
  String readOnly;
  String createUser;
  String createDate;
  String editUser;
  String editDate;
  String deleted;
  String compCode;
  String branchCode;
  String rowKey;
  String lastupload;
  String duplicateKey;
  String validateFailed;
  String validateRemark;
  String lastValidate;
  String transtamp;

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
      this.transtamp});

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
    return data;
  }
}

class GetOrderListByIcNoResponse {
  List<GetOrderListSlsTrn> slsTrn;

  GetOrderListByIcNoResponse({this.slsTrn});

  GetOrderListByIcNoResponse.fromJson(Map<String, dynamic> json) {
    if (json['SlsTrn'] != null) {
      slsTrn = new List<GetOrderListSlsTrn>();
      json['SlsTrn'].forEach((v) {
        slsTrn.add(new GetOrderListSlsTrn.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.slsTrn != null) {
      data['SlsTrn'] = this.slsTrn.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetOrderListSlsTrn {
  String iD;
  String merchantNo;
  String docDoc;
  String docRef;
  String slsDoc;
  String slsRef;
  String revNo;
  String ordDate;
  String ordTime;
  String wfStatus;
  String refNo;
  String subject;
  String validity;
  String leadTime;
  String dbcode;
  String icNo;
  String name;
  String branch;
  String locCode;
  String areaCode;
  String currency;
  String rate;
  String terms;
  String salesPer;
  String projCode;
  String orderBy;
  String custPoNo;
  String custPoDate;
  String shipmentTerm;
  String shipmentTermDetl;
  String shipMode;
  String shipCode;
  String shipTo;
  String shipName;
  String shipAdd;
  String shipAdd1;
  String shipAdd2;
  String shipAdd3;
  String shipAdd4;
  String shipArea;
  String shipPhone;
  String shipFax;
  String shipPtc;
  String shipRemark;
  String misc1;
  String misc2;
  String misc3;
  String misc4;
  String misc5;
  String misc6;
  String misc13;
  String misc14;
  String misc15;
  String misc16;
  String misc17;
  String misc18;
  String tlOrdQty;
  String tlOrdAmt;
  String tlNettDetlAmt;
  String tlLocDetlAmt;
  String tlNettOrdAmt;
  String tlLocOrdAmt;
  String tlDiscAmt;
  String tlLocDiscAmt;
  String tlSlsTax;
  String tlLocSlsTax;
  String tlSerTax;
  String tlLocSerTax;
  String bdiscRate;
  String bdiscAmt;
  String transChrg;
  String transRate;
  String mfgCurrency;
  String mfgRate;
  String mfgTlNettOrdAmt;
  String mfgTlLocOrdAmt;
  String hold;
  String cj5No;
  String dbAcct;
  String dbDept;
  String tlDlvQty;
  String doDoc;
  String doRef;
  String invDoc;
  String invRef;
  String title1;
  String title2;
  String title3;
  String remark;
  String remark1;
  String remark2;
  String prnCount;
  String printLog;
  String trnStatus;
  String creditBlockReason;
  String creditBlockInfo;
  String creditReqApprv;
  String creditApprvUser;
  String creditApprvDate;
  String creditApprvAmt;
  String creditApprvLog;
  String pending;
  String cancel;
  String cancelDate;
  String posted;
  String complete;
  String clear;
  String fullyBilled;
  String tlBilledAmt;
  String tlPaidAmt;
  String readOnly;
  String createUser;
  String createDate;
  String editUser;
  String editDate;
  String deleted;
  String compCode;
  String branchCode;
  String rowKey;
  String lastupload;
  String duplicateKey;
  String validateFailed;
  String validateRemark;
  String lastValidate;
  String transtamp;
  String packageCode;
  String packageDesc;

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

class FpxSendB2CAuthResponse {
  List<FpxResponse> response;

  FpxSendB2CAuthResponse({this.response});

  FpxSendB2CAuthResponse.fromJson(Map<String, dynamic> json) {
    if (json['Response'] != null) {
      response = new List<FpxResponse>();
      json['Response'].forEach((v) {
        response.add(new FpxResponse.fromJson(v));
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

class FpxResponse {
  String requestUrl;
  String requestData;
  String responseCode;
  String responseDescription;
  String responseData;
  String transId;
  String sessionId;
  String signatureString;

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
  List<OnlinePaymentByOrderNo> onlinePayment;

  GetOnlinePaymentByOrderNoResponse({this.onlinePayment});

  GetOnlinePaymentByOrderNoResponse.fromJson(Map<String, dynamic> json) {
    if (json['OnlinePayment'] != null) {
      onlinePayment = new List<OnlinePaymentByOrderNo>();
      json['OnlinePayment'].forEach((v) {
        onlinePayment.add(new OnlinePaymentByOrderNo.fromJson(v));
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

class OnlinePaymentByOrderNo {
  String iD;
  String merchantNo;
  String docDoc;
  String docRef;
  String paymentDate;
  String paymentTime;
  String dbcode;
  String icNo;
  String name;
  String source;
  String sourceDoc;
  String sourceRef;
  String currency;
  String paidAmt;
  String gatewayId;
  String transId;
  String transDatetime;
  String gatewayTransId;
  String bankId;
  String bankName;
  String sessionId;
  String responseCode;
  String responseData;
  String status;
  String createUser;
  String createDate;
  String editUser;
  String editDate;
  String deleted;
  String compCode;
  String branchCode;
  String rowKey;
  String lastupload;
  String duplicateKey;
  String validateFailed;
  String validateRemark;
  String lastValidate;
  String transtamp;
  String receiptUrl;

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
