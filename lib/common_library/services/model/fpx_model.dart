class FpxSendB2CBankEnquiryResponse {
  List<BankEnquiryResponse>? response;

  FpxSendB2CBankEnquiryResponse({this.response});

  FpxSendB2CBankEnquiryResponse.fromJson(Map<String, dynamic> json) {
    if (json['Response'] != null) {
      response = List<BankEnquiryResponse>.empty(growable: true);
      json['Response'].forEach((v) {
        response!.add(BankEnquiryResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (response != null) {
      data['Response'] = response!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['requestUrl'] = requestUrl;
    data['requestData'] = requestData;
    data['responseCode'] = responseCode;
    data['responseDescription'] = responseDescription;
    data['responseData'] = responseData;
    data['transId'] = transId;
    data['sessionId'] = sessionId;
    data['fpx_msgToken'] = fpxMsgToken;
    data['fpx_sellerExId'] = fpxSellerExId;
    data['fpx_bankList'] = fpxBankList;
    data['fpx_checkSum'] = fpxCheckSum;
    data['fpx_msgType'] = fpxMsgType;
    data['finalVerifiMsg'] = finalVerifiMsg;
    data['bankList'] = bankList;
    data['signatureString'] = signatureString;
    return data;
  }
}

class GetOnlinePaymentListByIcNoResponse {
  List<OnlinePayment>? onlinePayment;

  GetOnlinePaymentListByIcNoResponse({this.onlinePayment});

  GetOnlinePaymentListByIcNoResponse.fromJson(Map<String, dynamic> json) {
    if (json['OnlinePayment'] != null) {
      onlinePayment = List<OnlinePayment>.empty(growable: true);
      json['OnlinePayment'].forEach((v) {
        onlinePayment!.add(OnlinePayment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (onlinePayment != null) {
      data['OnlinePayment'] =
          onlinePayment!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doc_doc'] = docDoc;
    data['doc_ref'] = docRef;
    data['paid_amt'] = paidAmt;
    data['status'] = status;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wsCodeCrypt'] = wsCodeCrypt;
    data['caUid'] = caUid;
    data['caPwd'] = caPwd;
    data['diCode'] = diCode;
    data['userId'] = userId;
    data['icNo'] = icNo;
    data['packageCode'] = packageCode;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wsCodeCrypt'] = wsCodeCrypt;
    data['caUid'] = caUid;
    data['caPwd'] = caPwd;
    data['diCode'] = diCode;
    data['userId'] = userId;
    data['icNo'] = icNo;
    data['packageCode'] = packageCode;
    data['amountString'] = amountString;
    return data;
  }
}

class CreateOrderResponse {
  List<SlsTrn>? slsTrn;

  CreateOrderResponse({this.slsTrn});

  CreateOrderResponse.fromJson(Map<String, dynamic> json) {
    if (json['SlsTrn'] != null) {
      slsTrn = List<SlsTrn>.empty(growable: true);
      json['SlsTrn'].forEach((v) {
        slsTrn!.add(SlsTrn.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (slsTrn != null) {
      data['SlsTrn'] = slsTrn!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['merchant_no'] = merchantNo;
    data['doc_doc'] = docDoc;
    data['doc_ref'] = docRef;
    data['sls_doc'] = slsDoc;
    data['sls_ref'] = slsRef;
    data['rev_no'] = revNo;
    data['ord_date'] = ordDate;
    data['ord_time'] = ordTime;
    data['wf_status'] = wfStatus;
    data['ref_no'] = refNo;
    data['subject'] = subject;
    data['validity'] = validity;
    data['lead_time'] = leadTime;
    data['dbcode'] = dbcode;
    data['ic_no'] = icNo;
    data['name'] = name;
    data['branch'] = branch;
    data['loc_code'] = locCode;
    data['area_code'] = areaCode;
    data['currency'] = currency;
    data['rate'] = rate;
    data['terms'] = terms;
    data['sales_per'] = salesPer;
    data['proj_code'] = projCode;
    data['order_by'] = orderBy;
    data['cust_po_no'] = custPoNo;
    data['cust_po_date'] = custPoDate;
    data['shipment_term'] = shipmentTerm;
    data['shipment_term_detl'] = shipmentTermDetl;
    data['ship_mode'] = shipMode;
    data['ship_code'] = shipCode;
    data['ship_to'] = shipTo;
    data['ship_name'] = shipName;
    data['ship_add'] = shipAdd;
    data['ship_add1'] = shipAdd1;
    data['ship_add2'] = shipAdd2;
    data['ship_add3'] = shipAdd3;
    data['ship_add4'] = shipAdd4;
    data['ship_area'] = shipArea;
    data['ship_phone'] = shipPhone;
    data['ship_fax'] = shipFax;
    data['ship_ptc'] = shipPtc;
    data['ship_remark'] = shipRemark;
    data['misc1'] = misc1;
    data['misc2'] = misc2;
    data['misc3'] = misc3;
    data['misc4'] = misc4;
    data['misc5'] = misc5;
    data['misc6'] = misc6;
    data['misc13'] = misc13;
    data['misc14'] = misc14;
    data['misc15'] = misc15;
    data['misc16'] = misc16;
    data['misc17'] = misc17;
    data['misc18'] = misc18;
    data['tl_ord_qty'] = tlOrdQty;
    data['tl_ord_amt'] = tlOrdAmt;
    data['tl_nett_detl_amt'] = tlNettDetlAmt;
    data['tl_loc_detl_amt'] = tlLocDetlAmt;
    data['tl_nett_ord_amt'] = tlNettOrdAmt;
    data['tl_loc_ord_amt'] = tlLocOrdAmt;
    data['tl_disc_amt'] = tlDiscAmt;
    data['tl_loc_disc_amt'] = tlLocDiscAmt;
    data['tl_sls_tax'] = tlSlsTax;
    data['tl_loc_sls_tax'] = tlLocSlsTax;
    data['tl_ser_tax'] = tlSerTax;
    data['tl_loc_ser_tax'] = tlLocSerTax;
    data['bdisc_rate'] = bdiscRate;
    data['bdisc_amt'] = bdiscAmt;
    data['trans_chrg'] = transChrg;
    data['trans_rate'] = transRate;
    data['mfg_currency'] = mfgCurrency;
    data['mfg_rate'] = mfgRate;
    data['mfg_tl_nett_ord_amt'] = mfgTlNettOrdAmt;
    data['mfg_tl_loc_ord_amt'] = mfgTlLocOrdAmt;
    data['hold'] = hold;
    data['cj5_no'] = cj5No;
    data['db_acct'] = dbAcct;
    data['db_dept'] = dbDept;
    data['tl_dlv_qty'] = tlDlvQty;
    data['do_doc'] = doDoc;
    data['do_ref'] = doRef;
    data['inv_doc'] = invDoc;
    data['inv_ref'] = invRef;
    data['title1'] = title1;
    data['title2'] = title2;
    data['title3'] = title3;
    data['remark'] = remark;
    data['remark1'] = remark1;
    data['remark2'] = remark2;
    data['prn_count'] = prnCount;
    data['print_log'] = printLog;
    data['trn_status'] = trnStatus;
    data['credit_block_reason'] = creditBlockReason;
    data['credit_block_info'] = creditBlockInfo;
    data['credit_req_apprv'] = creditReqApprv;
    data['credit_apprv_user'] = creditApprvUser;
    data['credit_apprv_date'] = creditApprvDate;
    data['credit_apprv_amt'] = creditApprvAmt;
    data['credit_apprv_log'] = creditApprvLog;
    data['pending'] = pending;
    data['cancel'] = cancel;
    data['cancel_date'] = cancelDate;
    data['posted'] = posted;
    data['complete'] = complete;
    data['clear'] = clear;
    data['fully_billed'] = fullyBilled;
    data['tl_billed_amt'] = tlBilledAmt;
    data['tl_paid_amt'] = tlPaidAmt;
    data['read_only'] = readOnly;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_user'] = editUser;
    data['edit_date'] = editDate;
    data['deleted'] = deleted;
    data['comp_code'] = compCode;
    data['branch_code'] = branchCode;
    data['row_key'] = rowKey;
    data['lastupload'] = lastupload;
    data['duplicate_key'] = duplicateKey;
    data['validate_failed'] = validateFailed;
    data['validate_remark'] = validateRemark;
    data['last_validate'] = lastValidate;
    data['transtamp'] = transtamp;
    data['package_code'] = packageCode;
    data['package_desc'] = packageDesc;
    return data;
  }
}

class GetOrderListByIcNoResponse {
  List<GetOrderListSlsTrn>? slsTrn;

  GetOrderListByIcNoResponse({this.slsTrn});

  GetOrderListByIcNoResponse.fromJson(Map<String, dynamic> json) {
    if (json['SlsTrn'] != null) {
      slsTrn = List<GetOrderListSlsTrn>.empty(growable: true);
      json['SlsTrn'].forEach((v) {
        slsTrn!.add(GetOrderListSlsTrn.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (slsTrn != null) {
      data['SlsTrn'] = slsTrn!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['merchant_no'] = merchantNo;
    data['doc_doc'] = docDoc;
    data['doc_ref'] = docRef;
    data['sls_doc'] = slsDoc;
    data['sls_ref'] = slsRef;
    data['rev_no'] = revNo;
    data['ord_date'] = ordDate;
    data['ord_time'] = ordTime;
    data['wf_status'] = wfStatus;
    data['ref_no'] = refNo;
    data['subject'] = subject;
    data['validity'] = validity;
    data['lead_time'] = leadTime;
    data['dbcode'] = dbcode;
    data['ic_no'] = icNo;
    data['name'] = name;
    data['branch'] = branch;
    data['loc_code'] = locCode;
    data['area_code'] = areaCode;
    data['currency'] = currency;
    data['rate'] = rate;
    data['terms'] = terms;
    data['sales_per'] = salesPer;
    data['proj_code'] = projCode;
    data['order_by'] = orderBy;
    data['cust_po_no'] = custPoNo;
    data['cust_po_date'] = custPoDate;
    data['shipment_term'] = shipmentTerm;
    data['shipment_term_detl'] = shipmentTermDetl;
    data['ship_mode'] = shipMode;
    data['ship_code'] = shipCode;
    data['ship_to'] = shipTo;
    data['ship_name'] = shipName;
    data['ship_add'] = shipAdd;
    data['ship_add1'] = shipAdd1;
    data['ship_add2'] = shipAdd2;
    data['ship_add3'] = shipAdd3;
    data['ship_add4'] = shipAdd4;
    data['ship_area'] = shipArea;
    data['ship_phone'] = shipPhone;
    data['ship_fax'] = shipFax;
    data['ship_ptc'] = shipPtc;
    data['ship_remark'] = shipRemark;
    data['misc1'] = misc1;
    data['misc2'] = misc2;
    data['misc3'] = misc3;
    data['misc4'] = misc4;
    data['misc5'] = misc5;
    data['misc6'] = misc6;
    data['misc13'] = misc13;
    data['misc14'] = misc14;
    data['misc15'] = misc15;
    data['misc16'] = misc16;
    data['misc17'] = misc17;
    data['misc18'] = misc18;
    data['tl_ord_qty'] = tlOrdQty;
    data['tl_ord_amt'] = tlOrdAmt;
    data['tl_nett_detl_amt'] = tlNettDetlAmt;
    data['tl_loc_detl_amt'] = tlLocDetlAmt;
    data['tl_nett_ord_amt'] = tlNettOrdAmt;
    data['tl_loc_ord_amt'] = tlLocOrdAmt;
    data['tl_disc_amt'] = tlDiscAmt;
    data['tl_loc_disc_amt'] = tlLocDiscAmt;
    data['tl_sls_tax'] = tlSlsTax;
    data['tl_loc_sls_tax'] = tlLocSlsTax;
    data['tl_ser_tax'] = tlSerTax;
    data['tl_loc_ser_tax'] = tlLocSerTax;
    data['bdisc_rate'] = bdiscRate;
    data['bdisc_amt'] = bdiscAmt;
    data['trans_chrg'] = transChrg;
    data['trans_rate'] = transRate;
    data['mfg_currency'] = mfgCurrency;
    data['mfg_rate'] = mfgRate;
    data['mfg_tl_nett_ord_amt'] = mfgTlNettOrdAmt;
    data['mfg_tl_loc_ord_amt'] = mfgTlLocOrdAmt;
    data['hold'] = hold;
    data['cj5_no'] = cj5No;
    data['db_acct'] = dbAcct;
    data['db_dept'] = dbDept;
    data['tl_dlv_qty'] = tlDlvQty;
    data['do_doc'] = doDoc;
    data['do_ref'] = doRef;
    data['inv_doc'] = invDoc;
    data['inv_ref'] = invRef;
    data['title1'] = title1;
    data['title2'] = title2;
    data['title3'] = title3;
    data['remark'] = remark;
    data['remark1'] = remark1;
    data['remark2'] = remark2;
    data['prn_count'] = prnCount;
    data['print_log'] = printLog;
    data['trn_status'] = trnStatus;
    data['credit_block_reason'] = creditBlockReason;
    data['credit_block_info'] = creditBlockInfo;
    data['credit_req_apprv'] = creditReqApprv;
    data['credit_apprv_user'] = creditApprvUser;
    data['credit_apprv_date'] = creditApprvDate;
    data['credit_apprv_amt'] = creditApprvAmt;
    data['credit_apprv_log'] = creditApprvLog;
    data['pending'] = pending;
    data['cancel'] = cancel;
    data['cancel_date'] = cancelDate;
    data['posted'] = posted;
    data['complete'] = complete;
    data['clear'] = clear;
    data['fully_billed'] = fullyBilled;
    data['tl_billed_amt'] = tlBilledAmt;
    data['tl_paid_amt'] = tlPaidAmt;
    data['read_only'] = readOnly;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_user'] = editUser;
    data['edit_date'] = editDate;
    data['deleted'] = deleted;
    data['comp_code'] = compCode;
    data['branch_code'] = branchCode;
    data['row_key'] = rowKey;
    data['lastupload'] = lastupload;
    data['duplicate_key'] = duplicateKey;
    data['validate_failed'] = validateFailed;
    data['validate_remark'] = validateRemark;
    data['last_validate'] = lastValidate;
    data['transtamp'] = transtamp;
    data['package_code'] = packageCode;
    data['package_desc'] = packageDesc;
    return data;
  }
}

class GetOrderDetlByOrderNoResponse {
  List<SlsDetl>? slsDetl;

  GetOrderDetlByOrderNoResponse({this.slsDetl});

  GetOrderDetlByOrderNoResponse.fromJson(Map<String, dynamic> json) {
    if (json['SlsDetl'] != null) {
      slsDetl = List<SlsDetl>.empty(growable: true);
      json['SlsDetl'].forEach((v) {
        slsDetl!.add(SlsDetl.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (slsDetl != null) {
      data['SlsDetl'] = slsDetl!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['merchant_no'] = merchantNo;
    data['doc_doc'] = docDoc;
    data['doc_ref'] = docRef;
    data['ord_date'] = ordDate;
    data['sls_doc'] = slsDoc;
    data['sls_ref'] = slsRef;
    data['key'] = key;
    data['main_key'] = mainKey;
    data['sub_item'] = subItem;
    data['stk_formula'] = stkFormula;
    data['item_no'] = itemNo;
    data['loc_code'] = locCode;
    data['branch'] = branch;
    data['package_code'] = packageCode;
    data['package_desc'] = packageDesc;
    data['uom'] = uom;
    data['exist_qty'] = existQty;
    data['ord_qty'] = ordQty;
    data['ord_uom'] = ordUom;
    data['ord_price'] = ordPrice;
    data['unit_price'] = unitPrice;
    data['item_qty'] = itemQty;
    data['item_uom'] = itemUom;
    data['item_price'] = itemPrice;
    data['extra_qty'] = extraQty;
    data['extra_uom'] = extraUom;
    data['extra_price'] = extraPrice;
    data['uom2_qty'] = uom2Qty;
    data['uom2_uom'] = uom2Uom;
    data['foc_qty'] = focQty;
    data['foc_uom'] = focUom;
    data['fill_qty'] = fillQty;
    data['manu_qty'] = manuQty;
    data['tlmanu_qty'] = tlmanuQty;
    data['manuf_qty'] = manufQty;
    data['tl_manuf_qty'] = tlManufQty;
    data['packed_qty'] = packedQty;
    data['price_code'] = priceCode;
    data['price_source'] = priceSource;
    data['allow_disc'] = allowDisc;
    data['disc_code'] = discCode;
    data['disc_rate'] = discRate;
    data['multi_disc'] = multiDisc;
    data['disc_amt'] = discAmt;
    data['loc_disc_amt'] = locDiscAmt;
    data['ser_tax'] = serTax;
    data['loc_ser_tax'] = locSerTax;
    data['incl_sls_tax'] = inclSlsTax;
    data['sls_tax'] = slsTax;
    data['loc_sls_tax'] = locSlsTax;
    data['sls_comm_rate'] = slsCommRate;
    data['sls_comm'] = slsComm;
    data['loc_sls_comm'] = locSlsComm;
    data['nett_price'] = nettPrice;
    data['ord_amt'] = ordAmt;
    data['nett_ord_amt'] = nettOrdAmt;
    data['loc_ord_amt'] = locOrdAmt;
    data['mfg_unit_price'] = mfgUnitPrice;
    data['mfg_nett_ord_amt'] = mfgNettOrdAmt;
    data['mfg_loc_ord_amt'] = mfgLocOrdAmt;
    data['unit_cost'] = unitCost;
    data['cust_po_no'] = custPoNo;
    data['cust_po_date'] = custPoDate;
    data['exp_dlvdt'] = expDlvdt;
    data['due_date'] = dueDate;
    data['due_time'] = dueTime;
    data['inv_doc'] = invDoc;
    data['inv_ref'] = invRef;
    data['do_doc'] = doDoc;
    data['do_ref'] = doRef;
    data['inv_key'] = invKey;
    data['do_key'] = doKey;
    data['quo_doc'] = quoDoc;
    data['quo_ref'] = quoRef;
    data['quo_key'] = quoKey;
    data['dlv_qty'] = dlvQty;
    data['dlv_iqty'] = dlvIqty;
    data['dlv_eqty'] = dlvEqty;
    data['dlv_fqty'] = dlvFqty;
    data['wo_qty'] = woQty;
    data['po_qty'] = poQty;
    data['po_doc'] = poDoc;
    data['po_ref'] = poRef;
    data['po_key'] = poKey;
    data['matrlreq_qty'] = matrlreqQty;
    data['matrlreq_closed'] = matrlreqClosed;
    data['billed_qty'] = billedQty;
    data['proj_code'] = projCode;
    data['cust_barcode'] = custBarcode;
    data['cust_sell_price'] = custSellPrice;
    data['misc7'] = misc7;
    data['misc8'] = misc8;
    data['misc9'] = misc9;
    data['misc10'] = misc10;
    data['misc11'] = misc11;
    data['misc12'] = misc12;
    data['dlv_misc10'] = dlvMisc10;
    data['dlv_misc11'] = dlvMisc11;
    data['dlv_misc12'] = dlvMisc12;
    data['stk_misc1'] = stkMisc1;
    data['stk_misc2'] = stkMisc2;
    data['stk_misc3'] = stkMisc3;
    data['cust_ref1'] = custRef1;
    data['cust_ref2'] = custRef2;
    data['undr_minpc'] = undrMinpc;
    data['cj5_no'] = cj5No;
    data['cj5_bgdt'] = cj5Bgdt;
    data['cj5_enddt'] = cj5Enddt;
    data['cj5_totqty'] = cj5Totqty;
    data['cj5_balqty'] = cj5Balqty;
    data['sale_acct'] = saleAcct;
    data['sale_dept'] = saleDept;
    data['remark'] = remark;
    data['trn_status'] = trnStatus;
    data['complete'] = complete;
    data['completed_remark'] = completedRemark;
    data['completed_user'] = completedUser;
    data['completed_date'] = completedDate;
    data['matrl_reserved'] = matrlReserved;
    data['cancel'] = cancel;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_user'] = editUser;
    data['edit_date'] = editDate;
    data['deleted'] = deleted;
    data['comp_code'] = compCode;
    data['branch_code'] = branchCode;
    data['row_key'] = rowKey;
    data['lastupload'] = lastupload;
    data['duplicate_key'] = duplicateKey;
    data['validate_failed'] = validateFailed;
    data['validate_remark'] = validateRemark;
    data['last_validate'] = lastValidate;
    data['transtamp'] = transtamp;
    data['frm_store_qty'] = frmStoreQty;
    return data;
  }
}

class FpxSendB2CAuthResponse {
  List<FpxResponse>? response;

  FpxSendB2CAuthResponse({this.response});

  FpxSendB2CAuthResponse.fromJson(Map<String, dynamic> json) {
    if (json['Response'] != null) {
      response = List<FpxResponse>.empty(growable: true);
      json['Response'].forEach((v) {
        response!.add(FpxResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (response != null) {
      data['Response'] = response!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['requestUrl'] = requestUrl;
    data['requestData'] = requestData;
    data['responseCode'] = responseCode;
    data['responseDescription'] = responseDescription;
    data['responseData'] = responseData;
    data['transId'] = transId;
    data['sessionId'] = sessionId;
    data['signatureString'] = signatureString;
    return data;
  }
}

class GetOnlinePaymentByOrderNoResponse {
  List<OnlinePaymentByOrderNo>? onlinePayment;

  GetOnlinePaymentByOrderNoResponse({this.onlinePayment});

  GetOnlinePaymentByOrderNoResponse.fromJson(Map<String, dynamic> json) {
    if (json['OnlinePayment'] != null) {
      onlinePayment = List<OnlinePaymentByOrderNo>.empty(growable: true);
      json['OnlinePayment'].forEach((v) {
        onlinePayment!.add(OnlinePaymentByOrderNo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (onlinePayment != null) {
      data['OnlinePayment'] =
          onlinePayment!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['merchant_no'] = merchantNo;
    data['doc_doc'] = docDoc;
    data['doc_ref'] = docRef;
    data['payment_date'] = paymentDate;
    data['payment_time'] = paymentTime;
    data['dbcode'] = dbcode;
    data['ic_no'] = icNo;
    data['name'] = name;
    data['source'] = source;
    data['source_doc'] = sourceDoc;
    data['source_ref'] = sourceRef;
    data['currency'] = currency;
    data['paid_amt'] = paidAmt;
    data['gateway_id'] = gatewayId;
    data['trans_id'] = transId;
    data['trans_datetime'] = transDatetime;
    data['gateway_trans_id'] = gatewayTransId;
    data['bank_id'] = bankId;
    data['bank_name'] = bankName;
    data['session_id'] = sessionId;
    data['response_code'] = responseCode;
    data['response_data'] = responseData;
    data['status'] = status;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_user'] = editUser;
    data['edit_date'] = editDate;
    data['deleted'] = deleted;
    data['comp_code'] = compCode;
    data['branch_code'] = branchCode;
    data['row_key'] = rowKey;
    data['lastupload'] = lastupload;
    data['duplicate_key'] = duplicateKey;
    data['validate_failed'] = validateFailed;
    data['validate_remark'] = validateRemark;
    data['last_validate'] = lastValidate;
    data['transtamp'] = transtamp;
    data['receipt_url'] = receiptUrl;
    return data;
  }
}

class GetAppPaymentMenuResponse {
  List<AppPaymentMenu>? appPaymentMenu;

  GetAppPaymentMenuResponse({this.appPaymentMenu});

  GetAppPaymentMenuResponse.fromJson(Map<String, dynamic> json) {
    if (json['AppPaymentMenu'] != null) {
      appPaymentMenu = List<AppPaymentMenu>.empty(growable: true);
      json['AppPaymentMenu'].forEach((v) {
        appPaymentMenu!.add(AppPaymentMenu.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (appPaymentMenu != null) {
      data['AppPaymentMenu'] =
          appPaymentMenu!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['app_code'] = appCode;
    data['menu_code'] = menuCode;
    data['code_desc'] = codeDesc;
    data['create_date'] = createDate;
    data['create_user'] = createUser;
    data['edit_date'] = editDate;
    data['edit_user'] = editUser;
    data['lastupload'] = lastupload;
    data['transtamp'] = transtamp;
    data['comp_code'] = compCode;
    data['branch_code'] = branchCode;
    data['row_key'] = rowKey;
    data['deleted'] = deleted;
    return data;
  }
}

class GetMerchantPaymentGatewayResponse {
  List<MerchantPaymentGateway>? merchantPaymentGateway;

  GetMerchantPaymentGatewayResponse({this.merchantPaymentGateway});

  GetMerchantPaymentGatewayResponse.fromJson(Map<String, dynamic> json) {
    if (json['MerchantPaymentGateway'] != null) {
      merchantPaymentGateway =
          List<MerchantPaymentGateway>.empty(growable: true);
      json['MerchantPaymentGateway'].forEach((v) {
        merchantPaymentGateway!.add(MerchantPaymentGateway.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (merchantPaymentGateway != null) {
      data['MerchantPaymentGateway'] =
          merchantPaymentGateway!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['app_code'] = appCode;
    data['merchant_no'] = merchantNo;
    data['gateway_id'] = gatewayId;
    data['gateway_desc'] = gatewayDesc;
    data['min_amt'] = minAmt;
    data['create_date'] = createDate;
    data['create_user'] = createUser;
    data['edit_date'] = editDate;
    data['edit_user'] = editUser;
    data['lastupload'] = lastupload;
    data['transtamp'] = transtamp;
    data['comp_code'] = compCode;
    data['branch_code'] = branchCode;
    data['row_key'] = rowKey;
    data['deleted'] = deleted;
    return data;
  }
}
