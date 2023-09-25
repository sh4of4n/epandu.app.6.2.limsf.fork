class GetEnrollmentResponse {
  List<Enroll>? enroll;

  GetEnrollmentResponse({this.enroll});

  GetEnrollmentResponse.fromJson(Map<String, dynamic> json) {
    if (json['Enroll'] != null) {
      enroll = List<Enroll>.empty(growable: true);
      json['Enroll'].forEach((v) {
        enroll!.add(Enroll.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (enroll != null) {
      data['Enroll'] = enroll!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Enroll {
  String? id;
  String? trandate;
  String? icNo;
  String? groupId;
  String? kppGroupId;
  String? kppGroupId2;
  String? kppGroupId3;
  String? blacklisted;
  String? stuNo;
  String? dsCode;
  String? employeNo;
  String? introBy;
  String? commType;
  String? feesAgree;
  String? hrsAgree;
  String? addhrChrg;
  String? promptTes;
  String? totalPaid;
  String? retest;
  String? certNo;
  String? kpp02CertNo;
  String? remark;
  String? tlHrsTak;
  String? exclIncml;
  String? sm4No;
  String? pickupPoint;
  String? transtamp;
  String? epretCode;
  String? epretReqid;
  String? ekppCode;
  String? ekppReqid;
  String? ej2bStat;
  String? ej2bTick;
  String? ej2aTick;
  String? addClass;
  String? l2aPrnCount;
  String? l2bPrnCount;
  String? sm4PrnCount;
  String? userId;
  String? kpp02CertPath;
  String? compCode;
  String? branchCode;
  String? lastupload;
  String? deleted;
  String? diCode;

  Enroll(
      {this.id,
      this.trandate,
      this.icNo,
      this.groupId,
      this.kppGroupId,
      this.kppGroupId2,
      this.kppGroupId3,
      this.blacklisted,
      this.stuNo,
      this.dsCode,
      this.employeNo,
      this.introBy,
      this.commType,
      this.feesAgree,
      this.hrsAgree,
      this.addhrChrg,
      this.promptTes,
      this.totalPaid,
      this.retest,
      this.certNo,
      this.kpp02CertNo,
      this.remark,
      this.tlHrsTak,
      this.exclIncml,
      this.sm4No,
      this.pickupPoint,
      this.transtamp,
      this.epretCode,
      this.epretReqid,
      this.ekppCode,
      this.ekppReqid,
      this.ej2bStat,
      this.ej2bTick,
      this.ej2aTick,
      this.addClass,
      this.l2aPrnCount,
      this.l2bPrnCount,
      this.sm4PrnCount,
      this.userId,
      this.kpp02CertPath,
      this.compCode,
      this.branchCode,
      this.lastupload,
      this.deleted,
      this.diCode});

  Enroll.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trandate = json['trandate'];
    icNo = json['ic_no'];
    groupId = json['group_id'];
    kppGroupId = json['kpp_group_id'];
    kppGroupId2 = json['kpp_group_id_2'];
    kppGroupId3 = json['kpp_group_id_3'];
    blacklisted = json['blacklisted'];
    stuNo = json['stu_no'];
    dsCode = json['ds_code'];
    employeNo = json['employe_no'];
    introBy = json['intro_by'];
    commType = json['comm_type'];
    feesAgree = json['fees_agree'];
    hrsAgree = json['hrs_agree'];
    addhrChrg = json['addhr_chrg'];
    promptTes = json['prompt_tes'];
    totalPaid = json['total_paid'];
    retest = json['retest'];
    certNo = json['cert_no'];
    kpp02CertNo = json['kpp02_cert_no'];
    remark = json['remark'];
    tlHrsTak = json['tl_hrs_tak'];
    exclIncml = json['excl_incml'];
    sm4No = json['sm4_no'];
    pickupPoint = json['pickup_point'];
    transtamp = json['transtamp'];
    epretCode = json['epret_code'];
    epretReqid = json['epret_reqid'];
    ekppCode = json['ekpp_code'];
    ekppReqid = json['ekpp_reqid'];
    ej2bStat = json['ej2b_stat'];
    ej2bTick = json['ej2b_tick'];
    ej2aTick = json['ej2a_tick'];
    addClass = json['add_class'];
    l2aPrnCount = json['l2a_prn_count'];
    l2bPrnCount = json['l2b_prn_count'];
    sm4PrnCount = json['sm4_prn_count'];
    userId = json['user_id'];
    kpp02CertPath = json['kpp02_cert_path'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    lastupload = json['lastupload'];
    deleted = json['deleted'];
    diCode = json['di_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['trandate'] = trandate;
    data['ic_no'] = icNo;
    data['group_id'] = groupId;
    data['kpp_group_id'] = kppGroupId;
    data['kpp_group_id_2'] = kppGroupId2;
    data['kpp_group_id_3'] = kppGroupId3;
    data['blacklisted'] = blacklisted;
    data['stu_no'] = stuNo;
    data['ds_code'] = dsCode;
    data['employe_no'] = employeNo;
    data['intro_by'] = introBy;
    data['comm_type'] = commType;
    data['fees_agree'] = feesAgree;
    data['hrs_agree'] = hrsAgree;
    data['addhr_chrg'] = addhrChrg;
    data['prompt_tes'] = promptTes;
    data['total_paid'] = totalPaid;
    data['retest'] = retest;
    data['cert_no'] = certNo;
    data['kpp02_cert_no'] = kpp02CertNo;
    data['remark'] = remark;
    data['tl_hrs_tak'] = tlHrsTak;
    data['excl_incml'] = exclIncml;
    data['sm4_no'] = sm4No;
    data['pickup_point'] = pickupPoint;
    data['transtamp'] = transtamp;
    data['epret_code'] = epretCode;
    data['epret_reqid'] = epretReqid;
    data['ekpp_code'] = ekppCode;
    data['ekpp_reqid'] = ekppReqid;
    data['ej2b_stat'] = ej2bStat;
    data['ej2b_tick'] = ej2bTick;
    data['ej2a_tick'] = ej2aTick;
    data['add_class'] = addClass;
    data['l2a_prn_count'] = l2aPrnCount;
    data['l2b_prn_count'] = l2bPrnCount;
    data['sm4_prn_count'] = sm4PrnCount;
    data['user_id'] = userId;
    data['kpp02_cert_path'] = kpp02CertPath;
    data['comp_code'] = compCode;
    data['branch_code'] = branchCode;
    data['lastupload'] = lastupload;
    data['deleted'] = deleted;
    data['di_code'] = diCode;
    return data;
  }
}

// get enrolled classes
class EnrolledClassesRequest {
  String? wsCodeCrypt;
  String? caUid;
  String? caPwd;
  String? diCode;
  String? icNo;
  String? groupId;

  EnrolledClassesRequest(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
      this.diCode,
      this.icNo,
      this.groupId});

  EnrolledClassesRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    diCode = json['diCode'];
    icNo = json['icNo'];
    groupId = json['groupId'];
  }

  Map<String, String?> toJson() {
    final Map<String, String?> data = <String, String?>{};
    data['wsCodeCrypt'] = wsCodeCrypt;
    data['caUid'] = caUid;
    data['caPwd'] = caPwd;
    data['diCode'] = diCode;
    data['icNo'] = icNo;
    data['groupId'] = groupId;
    return data;
  }
}

// get student payment
/* class StudentPaymentRequest {
  String wsCodeCrypt;
  String caUid;
  String caPwd;
  String diCode;
  String icNo;

  StudentPaymentRequest(
      {this.wsCodeCrypt, this.caUid, this.caPwd, this.diCode, this.icNo});

  StudentPaymentRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    diCode = json['diCode'];
    icNo = json['icNo'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
    data['diCode'] = this.diCode;
    data['icNo'] = this.icNo;
    return data;
  }
} */

class StudentPaymentResponse {
  List<CollectTrn>? collectTrn;

  StudentPaymentResponse({this.collectTrn});

  StudentPaymentResponse.fromJson(Map<String, dynamic> json) {
    if (json['CollectTrn'] != null) {
      collectTrn = List<CollectTrn>.empty(growable: true);
      json['CollectTrn'].forEach((v) {
        collectTrn!.add(CollectTrn.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (collectTrn != null) {
      data['CollectTrn'] = collectTrn!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CollectTrn {
  String? jobNo;
  String? recpNo;
  String? serialType;
  String? trandate;
  String? trantime;
  String? vehNo;
  String? icNo;
  String? dsCode;
  String? tdefaAmt;
  String? thandChrg;
  String? tservChrg;
  String? tservTax;
  String? tranTotal;
  String? roundAmt;
  String? tranUser;
  String? payAmount;
  String? payMode;
  String? crdType;
  String? payRefno;
  String? balAmount;
  String? tlTaxAmt;
  String? cancelUser;
  String? cancelOn;
  String? cancel;
  String? transtamp;
  String? batchNo;
  String? cashAmount;
  String? chqAmount;
  String? ccAmount;
  String? packageCode;
  String? commAmount;
  String? oriRecpno;
  String? oriStype;
  String? tcommAmt;
  String? tagentCommAmt;
  String? compCode;
  String? branchCode;
  String? lastupload;
  String? deleted;
  String? diCode;
  String? id;
  String? ctrlNo;
  String? jobNo1;
  String? recpNo1;
  String? bookNo;
  String? trandate1;
  String? trantime1;
  String? vehNo1;
  String? icNo1;
  String? groupId;
  String? grpDesc;
  String? tranCateg;
  String? packageCode1;
  String? itemQty;
  String? itemPrice;
  String? taxCode;
  String? taxRate;
  String? taxAmt;
  String? priceIncludeGst;
  String? defaAmt;
  String? unitHandChrg;
  String? handChrg;
  String? unitServChrg;
  String? servChrg;
  String? unitServTax;
  String? servTax;
  String? tranTotal1;
  String? nettAmt;
  String? unitCommAmt;
  String? transtamp1;
  String? commAmt;
  String? unitAgentComm;
  String? agentCommAmt;
  String? trnCode;
  String? trnDesc;
  String? compCode1;
  String? branchCode1;
  String? lastupload1;
  String? deleted1;
  String? diCode1;

  CollectTrn(
      {this.jobNo,
      this.recpNo,
      this.serialType,
      this.trandate,
      this.trantime,
      this.vehNo,
      this.icNo,
      this.dsCode,
      this.tdefaAmt,
      this.thandChrg,
      this.tservChrg,
      this.tservTax,
      this.tranTotal,
      this.roundAmt,
      this.tranUser,
      this.payAmount,
      this.payMode,
      this.crdType,
      this.payRefno,
      this.balAmount,
      this.tlTaxAmt,
      this.cancelUser,
      this.cancelOn,
      this.cancel,
      this.transtamp,
      this.batchNo,
      this.cashAmount,
      this.chqAmount,
      this.ccAmount,
      this.packageCode,
      this.commAmount,
      this.oriRecpno,
      this.oriStype,
      this.tcommAmt,
      this.tagentCommAmt,
      this.compCode,
      this.branchCode,
      this.lastupload,
      this.deleted,
      this.diCode,
      this.id,
      this.ctrlNo,
      this.jobNo1,
      this.recpNo1,
      this.bookNo,
      this.trandate1,
      this.trantime1,
      this.vehNo1,
      this.icNo1,
      this.groupId,
      this.grpDesc,
      this.tranCateg,
      this.packageCode1,
      this.itemQty,
      this.itemPrice,
      this.taxCode,
      this.taxRate,
      this.taxAmt,
      this.priceIncludeGst,
      this.defaAmt,
      this.unitHandChrg,
      this.handChrg,
      this.unitServChrg,
      this.servChrg,
      this.unitServTax,
      this.servTax,
      this.tranTotal1,
      this.nettAmt,
      this.unitCommAmt,
      this.transtamp1,
      this.commAmt,
      this.unitAgentComm,
      this.agentCommAmt,
      this.trnCode,
      this.trnDesc,
      this.compCode1,
      this.branchCode1,
      this.lastupload1,
      this.deleted1,
      this.diCode1});

  CollectTrn.fromJson(Map<String, dynamic> json) {
    jobNo = json['job_no'];
    recpNo = json['recp_no'];
    serialType = json['serial_type'];
    trandate = json['trandate'];
    trantime = json['trantime'];
    vehNo = json['veh_no'];
    icNo = json['ic_no'];
    dsCode = json['ds_code'];
    tdefaAmt = json['tdefa_amt'];
    thandChrg = json['thand_chrg'];
    tservChrg = json['tserv_chrg'];
    tservTax = json['tserv_tax'];
    tranTotal = json['tran_total'];
    roundAmt = json['round_amt'];
    tranUser = json['tran_user'];
    payAmount = json['pay_amount'];
    payMode = json['pay_mode'];
    crdType = json['crd_type'];
    payRefno = json['pay_refno'];
    balAmount = json['bal_amount'];
    tlTaxAmt = json['tl_tax_amt'];
    cancelUser = json['cancel_user'];
    cancelOn = json['cancel_on'];
    cancel = json['cancel'];
    transtamp = json['transtamp'];
    batchNo = json['batch_no'];
    cashAmount = json['cash_amount'];
    chqAmount = json['chq_amount'];
    ccAmount = json['cc_amount'];
    packageCode = json['package_code'];
    commAmount = json['comm_amount'];
    oriRecpno = json['ori_recpno'];
    oriStype = json['ori_stype'];
    tcommAmt = json['tcomm_amt'];
    tagentCommAmt = json['tagent_comm_amt'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    lastupload = json['lastupload'];
    deleted = json['deleted'];
    diCode = json['di_code'];
    id = json['id'];
    ctrlNo = json['ctrl_no'];
    jobNo1 = json['job_no1'];
    recpNo1 = json['recp_no1'];
    bookNo = json['book_no'];
    trandate1 = json['trandate1'];
    trantime1 = json['trantime1'];
    vehNo1 = json['veh_no1'];
    icNo1 = json['ic_no1'];
    groupId = json['group_id'];
    grpDesc = json['grp_desc'];
    tranCateg = json['tran_categ'];
    packageCode1 = json['package_code1'];
    itemQty = json['item_qty'];
    itemPrice = json['item_price'];
    taxCode = json['tax_code'];
    taxRate = json['tax_rate'];
    taxAmt = json['tax_amt'];
    priceIncludeGst = json['price_include_gst'];
    defaAmt = json['defa_amt'];
    unitHandChrg = json['unit_hand_chrg'];
    handChrg = json['hand_chrg'];
    unitServChrg = json['unit_serv_chrg'];
    servChrg = json['serv_chrg'];
    unitServTax = json['unit_serv_tax'];
    servTax = json['serv_tax'];
    tranTotal1 = json['tran_total1'];
    nettAmt = json['nett_amt'];
    unitCommAmt = json['unit_comm_amt'];
    transtamp1 = json['transtamp1'];
    commAmt = json['comm_amt'];
    unitAgentComm = json['unit_agent_comm'];
    agentCommAmt = json['agent_comm_amt'];
    trnCode = json['trn_code'];
    trnDesc = json['trn_desc'];
    compCode1 = json['comp_code1'];
    branchCode1 = json['branch_code1'];
    lastupload1 = json['lastupload1'];
    deleted1 = json['deleted1'];
    diCode1 = json['di_code1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['job_no'] = jobNo;
    data['recp_no'] = recpNo;
    data['serial_type'] = serialType;
    data['trandate'] = trandate;
    data['trantime'] = trantime;
    data['veh_no'] = vehNo;
    data['ic_no'] = icNo;
    data['ds_code'] = dsCode;
    data['tdefa_amt'] = tdefaAmt;
    data['thand_chrg'] = thandChrg;
    data['tserv_chrg'] = tservChrg;
    data['tserv_tax'] = tservTax;
    data['tran_total'] = tranTotal;
    data['round_amt'] = roundAmt;
    data['tran_user'] = tranUser;
    data['pay_amount'] = payAmount;
    data['pay_mode'] = payMode;
    data['crd_type'] = crdType;
    data['pay_refno'] = payRefno;
    data['bal_amount'] = balAmount;
    data['tl_tax_amt'] = tlTaxAmt;
    data['cancel_user'] = cancelUser;
    data['cancel_on'] = cancelOn;
    data['cancel'] = cancel;
    data['transtamp'] = transtamp;
    data['batch_no'] = batchNo;
    data['cash_amount'] = cashAmount;
    data['chq_amount'] = chqAmount;
    data['cc_amount'] = ccAmount;
    data['package_code'] = packageCode;
    data['comm_amount'] = commAmount;
    data['ori_recpno'] = oriRecpno;
    data['ori_stype'] = oriStype;
    data['tcomm_amt'] = tcommAmt;
    data['tagent_comm_amt'] = tagentCommAmt;
    data['comp_code'] = compCode;
    data['branch_code'] = branchCode;
    data['lastupload'] = lastupload;
    data['deleted'] = deleted;
    data['di_code'] = diCode;
    data['id'] = id;
    data['ctrl_no'] = ctrlNo;
    data['job_no1'] = jobNo1;
    data['recp_no1'] = recpNo1;
    data['book_no'] = bookNo;
    data['trandate1'] = trandate1;
    data['trantime1'] = trantime1;
    data['veh_no1'] = vehNo1;
    data['ic_no1'] = icNo1;
    data['group_id'] = groupId;
    data['grp_desc'] = grpDesc;
    data['tran_categ'] = tranCateg;
    data['package_code1'] = packageCode1;
    data['item_qty'] = itemQty;
    data['item_price'] = itemPrice;
    data['tax_code'] = taxCode;
    data['tax_rate'] = taxRate;
    data['tax_amt'] = taxAmt;
    data['price_include_gst'] = priceIncludeGst;
    data['defa_amt'] = defaAmt;
    data['unit_hand_chrg'] = unitHandChrg;
    data['hand_chrg'] = handChrg;
    data['unit_serv_chrg'] = unitServChrg;
    data['serv_chrg'] = servChrg;
    data['unit_serv_tax'] = unitServTax;
    data['serv_tax'] = servTax;
    data['tran_total1'] = tranTotal1;
    data['nett_amt'] = nettAmt;
    data['unit_comm_amt'] = unitCommAmt;
    data['transtamp1'] = transtamp1;
    data['comm_amt'] = commAmt;
    data['unit_agent_comm'] = unitAgentComm;
    data['agent_comm_amt'] = agentCommAmt;
    data['trn_code'] = trnCode;
    data['trn_desc'] = trnDesc;
    data['comp_code1'] = compCode1;
    data['branch_code1'] = branchCode1;
    data['lastupload1'] = lastupload1;
    data['deleted1'] = deleted1;
    data['di_code1'] = diCode1;
    return data;
  }
}

// get student attendance
/* class StudentAttendanceRequest {
  String wsCodeCrypt;
  String caUid;
  String caPwd;
  String diCode;
  String icNo;
  String groupId;

  StudentAttendanceRequest(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
      this.diCode,
      this.icNo,
      this.groupId});

  StudentAttendanceRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    diCode = json['diCode'];
    icNo = json['icNo'];
    groupId = json['groupId'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
    data['diCode'] = this.diCode;
    data['icNo'] = this.icNo;
    data['groupId'] = this.groupId;
    return data;
  }
} */

// GetDTestByCodeResponse
class GetDTestByCodeResponse {
  List<DTest>? dTest;

  GetDTestByCodeResponse({this.dTest});

  GetDTestByCodeResponse.fromJson(Map<String, dynamic> json) {
    if (json['DTest'] != null) {
      dTest = List<DTest>.empty(growable: true);
      json['DTest'].forEach((v) {
        dTest!.add(DTest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dTest != null) {
      data['DTest'] = dTest!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DTest {
  String? id;
  String? icNo;
  String? nric;
  String? stuNo;
  String? dsCode;
  String? classes;
  String? testDate;
  String? testType;
  String? groupId;
  String? hrsAgree;
  String? cardNo;
  String? sijilNo;
  String? tableNo;
  String? time;
  String? noCorrect;
  String? partIi;
  String? partI;
  String? partIii;
  String? result;
  String? partIv;
  String? testPart;
  String? repeat;
  String? amount;
  String? pasCrtNo;
  String? remark;
  String? recNo;
  String? sm4No;
  String? attempt;
  String? cancel;
  String? closed;
  String? bookNo;
  String? ctrlNo;
  String? ereqCode;
  String? ereqId;
  String? ebookDate;
  String? etestTime;
  String? eattempt;
  String? ereqRecp;
  String? ereqBookid;
  String? ereqAmtpd;
  String? erefNo;
  String? esent;
  String? eaccept;
  String? erejReason;
  String? siteCode;
  String? transtamp;
  String? classCode;
  String? recpNo;
  String? cardDate;
  String? aprvDate;
  String? pRemark;
  String? pAmount;
  String? sesi;
  String? testLoc;
  String? apprvBooking;
  String? compCode;
  String? branchCode;
  String? rowKey;
  String? lastupload;
  String? deleted;
  String? diCode;
  String? testTypeValue;

  DTest(
      {this.id,
      this.icNo,
      this.nric,
      this.stuNo,
      this.dsCode,
      this.classes,
      this.testDate,
      this.testType,
      this.groupId,
      this.hrsAgree,
      this.cardNo,
      this.sijilNo,
      this.tableNo,
      this.time,
      this.noCorrect,
      this.partIi,
      this.partI,
      this.partIii,
      this.result,
      this.partIv,
      this.testPart,
      this.repeat,
      this.amount,
      this.pasCrtNo,
      this.remark,
      this.recNo,
      this.sm4No,
      this.attempt,
      this.cancel,
      this.closed,
      this.bookNo,
      this.ctrlNo,
      this.ereqCode,
      this.ereqId,
      this.ebookDate,
      this.etestTime,
      this.eattempt,
      this.ereqRecp,
      this.ereqBookid,
      this.ereqAmtpd,
      this.erefNo,
      this.esent,
      this.eaccept,
      this.erejReason,
      this.siteCode,
      this.transtamp,
      this.classCode,
      this.recpNo,
      this.cardDate,
      this.aprvDate,
      this.pRemark,
      this.pAmount,
      this.sesi,
      this.testLoc,
      this.apprvBooking,
      this.compCode,
      this.branchCode,
      this.rowKey,
      this.lastupload,
      this.deleted,
      this.diCode,
      this.testTypeValue});

  DTest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icNo = json['ic_no'];
    nric = json['nric'];
    stuNo = json['stu_no'];
    dsCode = json['ds_code'];
    classes = json['class'];
    testDate = json['test_date'];
    testType = json['test_type'];
    groupId = json['group_id'];
    hrsAgree = json['hrs_agree'];
    cardNo = json['card_no'];
    sijilNo = json['sijil_no'];
    tableNo = json['table_no'];
    time = json['time'];
    noCorrect = json['no_correct'];
    partIi = json['part_ii'];
    partI = json['part_i'];
    partIii = json['part_iii'];
    result = json['result'];
    partIv = json['part_iv'];
    testPart = json['test_part'];
    repeat = json['repeat'];
    amount = json['amount'];
    pasCrtNo = json['pas_crt_no'];
    remark = json['remark'];
    recNo = json['rec_no'];
    sm4No = json['sm4_no'];
    attempt = json['attempt'];
    cancel = json['cancel'];
    closed = json['closed'];
    bookNo = json['book_no'];
    ctrlNo = json['ctrl_no'];
    ereqCode = json['ereq_code'];
    ereqId = json['ereq_id'];
    ebookDate = json['ebook_date'];
    etestTime = json['etest_time'];
    eattempt = json['eattempt'];
    ereqRecp = json['ereq_recp'];
    ereqBookid = json['ereq_bookid'];
    ereqAmtpd = json['ereq_amtpd'];
    erefNo = json['eref_no'];
    esent = json['esent'];
    eaccept = json['eaccept'];
    erejReason = json['erej_reason'];
    siteCode = json['site_code'];
    transtamp = json['transtamp'];
    classCode = json['class_code'];
    recpNo = json['recp_no'];
    cardDate = json['card_date'];
    aprvDate = json['aprv_date'];
    pRemark = json['p_remark'];
    pAmount = json['p_amount'];
    sesi = json['sesi'];
    testLoc = json['test_loc'];
    apprvBooking = json['apprv_booking'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    rowKey = json['row_key'];
    lastupload = json['lastupload'];
    deleted = json['deleted'];
    diCode = json['di_code'];
    testTypeValue = json['test_type_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ic_no'] = icNo;
    data['nric'] = nric;
    data['stu_no'] = stuNo;
    data['ds_code'] = dsCode;
    data['class'] = classes;
    data['test_date'] = testDate;
    data['test_type'] = testType;
    data['group_id'] = groupId;
    data['hrs_agree'] = hrsAgree;
    data['card_no'] = cardNo;
    data['sijil_no'] = sijilNo;
    data['table_no'] = tableNo;
    data['time'] = time;
    data['no_correct'] = noCorrect;
    data['part_ii'] = partIi;
    data['part_i'] = partI;
    data['part_iii'] = partIii;
    data['result'] = result;
    data['part_iv'] = partIv;
    data['test_part'] = testPart;
    data['repeat'] = repeat;
    data['amount'] = amount;
    data['pas_crt_no'] = pasCrtNo;
    data['remark'] = remark;
    data['rec_no'] = recNo;
    data['sm4_no'] = sm4No;
    data['attempt'] = attempt;
    data['cancel'] = cancel;
    data['closed'] = closed;
    data['book_no'] = bookNo;
    data['ctrl_no'] = ctrlNo;
    data['ereq_code'] = ereqCode;
    data['ereq_id'] = ereqId;
    data['ebook_date'] = ebookDate;
    data['etest_time'] = etestTime;
    data['eattempt'] = eattempt;
    data['ereq_recp'] = ereqRecp;
    data['ereq_bookid'] = ereqBookid;
    data['ereq_amtpd'] = ereqAmtpd;
    data['eref_no'] = erefNo;
    data['esent'] = esent;
    data['eaccept'] = eaccept;
    data['erej_reason'] = erejReason;
    data['site_code'] = siteCode;
    data['transtamp'] = transtamp;
    data['class_code'] = classCode;
    data['recp_no'] = recpNo;
    data['card_date'] = cardDate;
    data['aprv_date'] = aprvDate;
    data['p_remark'] = pRemark;
    data['p_amount'] = pAmount;
    data['sesi'] = sesi;
    data['test_loc'] = testLoc;
    data['apprv_booking'] = apprvBooking;
    data['comp_code'] = compCode;
    data['branch_code'] = branchCode;
    data['row_key'] = rowKey;
    data['lastupload'] = lastupload;
    data['deleted'] = deleted;
    data['di_code'] = diCode;
    data['test_type_value'] = testTypeValue;
    return data;
  }
}

// GetCollectionDetailByRecNoResponse
class GetCollectionDetailByRecpNoResponse {
  List<CollectDetail>? collectDetail;

  GetCollectionDetailByRecpNoResponse({this.collectDetail});

  GetCollectionDetailByRecpNoResponse.fromJson(Map<String, dynamic> json) {
    if (json['CollectDetail'] != null) {
      collectDetail = List<CollectDetail>.empty(growable: true);
      json['CollectDetail'].forEach((v) {
        collectDetail!.add(CollectDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (collectDetail != null) {
      data['CollectDetail'] =
          collectDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CollectDetail {
  String? id;
  String? ctrlNo;
  String? jobNo;
  String? recpNo;
  String? bookNo;
  String? trandate;
  String? trantime;
  String? vehNo;
  String? icNo;
  String? groupId;
  String? grpDesc;
  String? tranCateg;
  String? packageCode;
  String? packageDesc;
  String? itemQty;
  String? itemPrice;
  String? taxCode;
  String? taxRate;
  String? taxAmt;
  String? priceIncludeGst;
  String? defaAmt;
  String? unitHandChrg;
  String? handChrg;
  String? unitServChrg;
  String? servChrg;
  String? unitServTax;
  String? servTax;
  String? tranTotal;
  String? nettAmt;
  String? unitCommAmt;
  String? transtamp;
  String? commAmt;
  String? unitAgentComm;
  String? agentCommAmt;
  String? trnCode;
  String? trnDesc;
  String? compCode;
  String? branchCode;
  String? lastupload;
  String? deleted;
  String? diCode;

  CollectDetail(
      {this.id,
      this.ctrlNo,
      this.jobNo,
      this.recpNo,
      this.bookNo,
      this.trandate,
      this.trantime,
      this.vehNo,
      this.icNo,
      this.groupId,
      this.grpDesc,
      this.tranCateg,
      this.packageCode,
      this.packageDesc,
      this.itemQty,
      this.itemPrice,
      this.taxCode,
      this.taxRate,
      this.taxAmt,
      this.priceIncludeGst,
      this.defaAmt,
      this.unitHandChrg,
      this.handChrg,
      this.unitServChrg,
      this.servChrg,
      this.unitServTax,
      this.servTax,
      this.tranTotal,
      this.nettAmt,
      this.unitCommAmt,
      this.transtamp,
      this.commAmt,
      this.unitAgentComm,
      this.agentCommAmt,
      this.trnCode,
      this.trnDesc,
      this.compCode,
      this.branchCode,
      this.lastupload,
      this.deleted,
      this.diCode});

  CollectDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ctrlNo = json['ctrl_no'];
    jobNo = json['job_no'];
    recpNo = json['recp_no'];
    bookNo = json['book_no'];
    trandate = json['trandate'];
    trantime = json['trantime'];
    vehNo = json['veh_no'];
    icNo = json['ic_no'];
    groupId = json['group_id'];
    grpDesc = json['grp_desc'];
    tranCateg = json['tran_categ'];
    packageCode = json['package_code'];
    packageDesc = json['package_desc'];
    itemQty = json['item_qty'];
    itemPrice = json['item_price'];
    taxCode = json['tax_code'];
    taxRate = json['tax_rate'];
    taxAmt = json['tax_amt'];
    priceIncludeGst = json['price_include_gst'];
    defaAmt = json['defa_amt'];
    unitHandChrg = json['unit_hand_chrg'];
    handChrg = json['hand_chrg'];
    unitServChrg = json['unit_serv_chrg'];
    servChrg = json['serv_chrg'];
    unitServTax = json['unit_serv_tax'];
    servTax = json['serv_tax'];
    tranTotal = json['tran_total'];
    nettAmt = json['nett_amt'];
    unitCommAmt = json['unit_comm_amt'];
    transtamp = json['transtamp'];
    commAmt = json['comm_amt'];
    unitAgentComm = json['unit_agent_comm'];
    agentCommAmt = json['agent_comm_amt'];
    trnCode = json['trn_code'];
    trnDesc = json['trn_desc'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    lastupload = json['lastupload'];
    deleted = json['deleted'];
    diCode = json['di_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ctrl_no'] = ctrlNo;
    data['job_no'] = jobNo;
    data['recp_no'] = recpNo;
    data['book_no'] = bookNo;
    data['trandate'] = trandate;
    data['trantime'] = trantime;
    data['veh_no'] = vehNo;
    data['ic_no'] = icNo;
    data['group_id'] = groupId;
    data['grp_desc'] = grpDesc;
    data['tran_categ'] = tranCateg;
    data['package_code'] = packageCode;
    data['package_desc'] = packageDesc;
    data['item_qty'] = itemQty;
    data['item_price'] = itemPrice;
    data['tax_code'] = taxCode;
    data['tax_rate'] = taxRate;
    data['tax_amt'] = taxAmt;
    data['price_include_gst'] = priceIncludeGst;
    data['defa_amt'] = defaAmt;
    data['unit_hand_chrg'] = unitHandChrg;
    data['hand_chrg'] = handChrg;
    data['unit_serv_chrg'] = unitServChrg;
    data['serv_chrg'] = servChrg;
    data['unit_serv_tax'] = unitServTax;
    data['serv_tax'] = servTax;
    data['tran_total'] = tranTotal;
    data['nett_amt'] = nettAmt;
    data['unit_comm_amt'] = unitCommAmt;
    data['transtamp'] = transtamp;
    data['comm_amt'] = commAmt;
    data['unit_agent_comm'] = unitAgentComm;
    data['agent_comm_amt'] = agentCommAmt;
    data['trn_code'] = trnCode;
    data['trn_desc'] = trnDesc;
    data['comp_code'] = compCode;
    data['branch_code'] = branchCode;
    data['lastupload'] = lastupload;
    data['deleted'] = deleted;
    data['di_code'] = diCode;
    return data;
  }
}

// GetCourseSectionList
class GetCourseSectionListResponse {
  List<CourseSection>? courseSection;

  GetCourseSectionListResponse({this.courseSection});

  GetCourseSectionListResponse.fromJson(Map<String, dynamic> json) {
    if (json['CourseSection'] != null) {
      courseSection = List<CourseSection>.empty(growable: true);
      json['CourseSection'].forEach((v) {
        courseSection!.add(CourseSection.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (courseSection != null) {
      data['CourseSection'] =
          courseSection!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseSection {
  String? iD;
  String? groupId;
  String? courseCode;
  String? section;
  String? sectionDesc;
  String? createUser;
  String? editUser;
  String? transtamp;
  String? deleted;
  String? lastEditedBy;
  String? createdBy;

  CourseSection(
      {this.iD,
      this.groupId,
      this.courseCode,
      this.section,
      this.sectionDesc,
      this.createUser,
      this.editUser,
      this.transtamp,
      this.deleted,
      this.lastEditedBy,
      this.createdBy});

  CourseSection.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    groupId = json['group_id'];
    courseCode = json['course_code'];
    section = json['section'];
    sectionDesc = json['section_desc'];
    createUser = json['create_user'];
    editUser = json['edit_user'];
    transtamp = json['transtamp'];
    deleted = json['deleted'];
    lastEditedBy = json['last_edited_by'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['group_id'] = groupId;
    data['course_code'] = courseCode;
    data['section'] = section;
    data['section_desc'] = sectionDesc;
    data['create_user'] = createUser;
    data['edit_user'] = editUser;
    data['transtamp'] = transtamp;
    data['deleted'] = deleted;
    data['last_edited_by'] = lastEditedBy;
    data['created_by'] = createdBy;
    return data;
  }
}

// GetTestListGroupIdResponse
class GetTestListGroupIdResponse {
  List<GroupIdTest>? test;

  GetTestListGroupIdResponse({this.test});

  GetTestListGroupIdResponse.fromJson(Map<String, dynamic> json) {
    if (json['Test'] != null) {
      test = List<GroupIdTest>.empty(growable: true);
      json['Test'].forEach((v) {
        test!.add(GroupIdTest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (test != null) {
      data['Test'] = test!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GroupIdTest {
  String? iD;
  String? diCode;
  String? groupId;
  String? testType;
  String? testDate;
  String? testTime;
  String? tlQuota;
  String? onlineQuota;
  String? createUser;
  String? createDate;
  String? editUser;
  String? editDate;
  String? transtamp;
  String? deleted;

  GroupIdTest(
      {this.iD,
      this.diCode,
      this.groupId,
      this.testType,
      this.testDate,
      this.testTime,
      this.tlQuota,
      this.onlineQuota,
      this.createUser,
      this.createDate,
      this.editUser,
      this.editDate,
      this.transtamp,
      this.deleted});

  GroupIdTest.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    diCode = json['di_code'];
    groupId = json['group_id'];
    testType = json['test_type'];
    testDate = json['test_date'];
    testTime = json['test_time'];
    tlQuota = json['tl_quota'];
    onlineQuota = json['online_quota'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    transtamp = json['transtamp'];
    deleted = json['deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['di_code'] = diCode;
    data['group_id'] = groupId;
    data['test_type'] = testType;
    data['test_date'] = testDate;
    data['test_time'] = testTime;
    data['tl_quota'] = tlQuota;
    data['online_quota'] = onlineQuota;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_user'] = editUser;
    data['edit_date'] = editDate;
    data['transtamp'] = transtamp;
    data['deleted'] = deleted;
    return data;
  }
}

// GetTestListTestTypeResponse
class GetTestListTestTypeResponse {
  List<TestTypeTest>? test;

  GetTestListTestTypeResponse({this.test});

  GetTestListTestTypeResponse.fromJson(Map<String, dynamic> json) {
    if (json['Test'] != null) {
      test = List<TestTypeTest>.empty(growable: true);
      json['Test'].forEach((v) {
        test!.add(TestTypeTest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (test != null) {
      data['Test'] = test!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TestTypeTest {
  String? iD;
  String? diCode;
  String? groupId;
  String? testType;
  String? testDate;
  String? testTime;
  String? tlQuota;
  String? onlineQuota;
  String? createUser;
  String? createDate;
  String? editUser;
  String? editDate;
  String? transtamp;
  String? deleted;

  TestTypeTest(
      {this.iD,
      this.diCode,
      this.groupId,
      this.testType,
      this.testDate,
      this.testTime,
      this.tlQuota,
      this.onlineQuota,
      this.createUser,
      this.createDate,
      this.editUser,
      this.editDate,
      this.transtamp,
      this.deleted});

  TestTypeTest.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    diCode = json['di_code'];
    groupId = json['group_id'];
    testType = json['test_type'];
    testDate = json['test_date'];
    testTime = json['test_time'];
    tlQuota = json['tl_quota'];
    onlineQuota = json['online_quota'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    transtamp = json['transtamp'];
    deleted = json['deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['di_code'] = diCode;
    data['group_id'] = groupId;
    data['test_type'] = testType;
    data['test_date'] = testDate;
    data['test_time'] = testTime;
    data['tl_quota'] = tlQuota;
    data['online_quota'] = onlineQuota;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_user'] = editUser;
    data['edit_date'] = editDate;
    data['transtamp'] = transtamp;
    data['deleted'] = deleted;
    return data;
  }
}

// GetTestListResponse
class GetTestListResponse {
  List<Test>? test;

  GetTestListResponse({this.test});

  GetTestListResponse.fromJson(Map<String, dynamic> json) {
    if (json['Test'] != null) {
      test = List<Test>.empty(growable: true);
      json['Test'].forEach((v) {
        test!.add(Test.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (test != null) {
      data['Test'] = test!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Test {
  String? iD;
  String? diCode;
  String? groupId;
  String? testType;
  String? testDate;
  String? testTime;
  String? tlQuota;
  String? onlineQuota;
  String? createUser;
  String? createDate;
  String? editUser;
  String? editDate;
  String? transtamp;
  String? deleted;
  String? lastEditedBy;
  String? createdBy;

  Test(
      {this.iD,
      this.diCode,
      this.groupId,
      this.testType,
      this.testDate,
      this.testTime,
      this.tlQuota,
      this.onlineQuota,
      this.createUser,
      this.createDate,
      this.editUser,
      this.editDate,
      this.transtamp,
      this.deleted,
      this.lastEditedBy,
      this.createdBy});

  Test.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    diCode = json['di_code'];
    groupId = json['group_id'];
    testType = json['test_type'];
    testDate = json['test_date'];
    testTime = json['test_time'];
    tlQuota = json['tl_quota'];
    onlineQuota = json['online_quota'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    transtamp = json['transtamp'];
    deleted = json['deleted'];
    lastEditedBy = json['last_edited_by'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['di_code'] = diCode;
    data['group_id'] = groupId;
    data['test_type'] = testType;
    data['test_date'] = testDate;
    data['test_time'] = testTime;
    data['tl_quota'] = tlQuota;
    data['online_quota'] = onlineQuota;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_user'] = editUser;
    data['edit_date'] = editDate;
    data['transtamp'] = transtamp;
    data['deleted'] = deleted;
    data['last_edited_by'] = lastEditedBy;
    data['created_by'] = createdBy;
    return data;
  }
}

// SaveBookingTest

class SaveBookingTestRequest {
  String? wsCodeCrypt;
  String? caUid;
  String? caPwd;
  String? diCode;
  String? groupId;
  String? testType;
  String? testDate;
  String? courseSection;
  String? icNo;
  String? userId;

  SaveBookingTestRequest(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
      this.diCode,
      this.groupId,
      this.testType,
      this.testDate,
      this.courseSection,
      this.icNo,
      this.userId});

  SaveBookingTestRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    diCode = json['diCode'];
    groupId = json['groupId'];
    testType = json['testType'];
    testDate = json['testDate'];
    courseSection = json['courseSection'];
    icNo = json['icNo'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wsCodeCrypt'] = wsCodeCrypt;
    data['caUid'] = caUid;
    data['caPwd'] = caPwd;
    data['diCode'] = diCode;
    data['groupId'] = groupId;
    data['testType'] = testType;
    data['testDate'] = testDate;
    data['courseSection'] = courseSection;
    data['icNo'] = icNo;
    data['userId'] = userId;
    return data;
  }
}

class GetJpjTestCheckInResponse {
  List<GetJpjTestTrn>? jpjTestTrn;

  GetJpjTestCheckInResponse({this.jpjTestTrn});

  GetJpjTestCheckInResponse.fromJson(Map<String, dynamic> json) {
    if (json['JpjTestTrn'] != null) {
      jpjTestTrn = List<GetJpjTestTrn>.empty(growable: true);
      json['JpjTestTrn'].forEach((v) {
        jpjTestTrn!.add(GetJpjTestTrn.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (jpjTestTrn != null) {
      data['JpjTestTrn'] = jpjTestTrn!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetJpjTestTrn {
  String? iD;
  String? testDate;
  String? courseCode;
  String? groupId;
  String? nricNo;
  String? fullname;
  String? sex;
  String? race;
  String? nationality;
  String? birthDate;
  String? add1;
  String? add2;
  String? add3;
  String? postcode;
  String? cityName;
  String? stateName;
  String? icPhoto;
  String? queueNo;
  String? regDate;
  String? registerPhoto;
  String? testCode;
  String? startDate;
  String? startTime;
  String? endTime;
  String? printed;
  String? prnCount;
  String? printLog;
  String? createUser;
  String? createDate;
  String? editUser;
  String? editDate;
  String? transtamp;
  String? lastupload;
  String? compCode;
  String? branchCode;
  String? deleted;

  GetJpjTestTrn(
      {this.iD,
      this.testDate,
      this.courseCode,
      this.groupId,
      this.nricNo,
      this.fullname,
      this.sex,
      this.race,
      this.nationality,
      this.birthDate,
      this.add1,
      this.add2,
      this.add3,
      this.postcode,
      this.cityName,
      this.stateName,
      this.icPhoto,
      this.queueNo,
      this.regDate,
      this.registerPhoto,
      this.testCode,
      this.startDate,
      this.startTime,
      this.endTime,
      this.printed,
      this.prnCount,
      this.printLog,
      this.createUser,
      this.createDate,
      this.editUser,
      this.editDate,
      this.transtamp,
      this.lastupload,
      this.compCode,
      this.branchCode,
      this.deleted});

  GetJpjTestTrn.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    testDate = json['test_date'];
    courseCode = json['course_code'];
    groupId = json['group_id'];
    nricNo = json['nric_no'];
    fullname = json['fullname'];
    sex = json['sex'];
    race = json['race'];
    nationality = json['nationality'];
    birthDate = json['birth_date'];
    add1 = json['add1'];
    add2 = json['add2'];
    add3 = json['add3'];
    postcode = json['postcode'];
    cityName = json['city_name'];
    stateName = json['state_name'];
    icPhoto = json['ic_photo'];
    queueNo = json['queue_no'];
    regDate = json['reg_date'];
    registerPhoto = json['register_photo'];
    testCode = json['test_code'];
    startDate = json['start_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    printed = json['printed'];
    prnCount = json['prn_count'];
    printLog = json['print_log'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    transtamp = json['transtamp'];
    lastupload = json['lastupload'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    deleted = json['deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['test_date'] = testDate;
    data['course_code'] = courseCode;
    data['group_id'] = groupId;
    data['nric_no'] = nricNo;
    data['fullname'] = fullname;
    data['sex'] = sex;
    data['race'] = race;
    data['nationality'] = nationality;
    data['birth_date'] = birthDate;
    data['add1'] = add1;
    data['add2'] = add2;
    data['add3'] = add3;
    data['postcode'] = postcode;
    data['city_name'] = cityName;
    data['state_name'] = stateName;
    data['ic_photo'] = icPhoto;
    data['queue_no'] = queueNo;
    data['reg_date'] = regDate;
    data['register_photo'] = registerPhoto;
    data['test_code'] = testCode;
    data['start_date'] = startDate;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['printed'] = printed;
    data['prn_count'] = prnCount;
    data['print_log'] = printLog;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_user'] = editUser;
    data['edit_date'] = editDate;
    data['transtamp'] = transtamp;
    data['lastupload'] = lastupload;
    data['comp_code'] = compCode;
    data['branch_code'] = branchCode;
    data['deleted'] = deleted;
    return data;
  }
}

class GetLastJpjTestCheckInByIntervalResponse {
  List<GetJpjTestTrnByInterval>? jpjTestTrn;

  GetLastJpjTestCheckInByIntervalResponse({this.jpjTestTrn});

  GetLastJpjTestCheckInByIntervalResponse.fromJson(Map<String, dynamic> json) {
    if (json['JpjTestTrn'] != null) {
      jpjTestTrn = List<GetJpjTestTrnByInterval>.empty(growable: true);
      json['JpjTestTrn'].forEach((v) {
        jpjTestTrn!.add(GetJpjTestTrnByInterval.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (jpjTestTrn != null) {
      data['JpjTestTrn'] = jpjTestTrn!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetJpjTestTrnByInterval {
  String? iD;
  String? testDate;
  String? courseCode;
  String? groupId;
  String? nricNo;
  String? fullname;
  String? sex;
  String? race;
  String? nationality;
  String? birthDate;
  String? add1;
  String? add2;
  String? add3;
  String? postcode;
  String? cityName;
  String? stateName;
  String? icPhoto;
  String? queueNo;
  String? regDate;
  String? registerPhoto;
  String? testCode;
  String? startDate;
  String? startTime;
  String? endTime;
  String? printed;
  String? prnCount;
  String? printLog;
  String? createUser;
  String? createDate;
  String? editUser;
  String? editDate;
  String? transtamp;
  String? lastupload;
  String? compCode;
  String? branchCode;
  String? deleted;

  GetJpjTestTrnByInterval(
      {this.iD,
      this.testDate,
      this.courseCode,
      this.groupId,
      this.nricNo,
      this.fullname,
      this.sex,
      this.race,
      this.nationality,
      this.birthDate,
      this.add1,
      this.add2,
      this.add3,
      this.postcode,
      this.cityName,
      this.stateName,
      this.icPhoto,
      this.queueNo,
      this.regDate,
      this.registerPhoto,
      this.testCode,
      this.startDate,
      this.startTime,
      this.endTime,
      this.printed,
      this.prnCount,
      this.printLog,
      this.createUser,
      this.createDate,
      this.editUser,
      this.editDate,
      this.transtamp,
      this.lastupload,
      this.compCode,
      this.branchCode,
      this.deleted});

  GetJpjTestTrnByInterval.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    testDate = json['test_date'];
    courseCode = json['course_code'];
    groupId = json['group_id'];
    nricNo = json['nric_no'];
    fullname = json['fullname'];
    sex = json['sex'];
    race = json['race'];
    nationality = json['nationality'];
    birthDate = json['birth_date'];
    add1 = json['add1'];
    add2 = json['add2'];
    add3 = json['add3'];
    postcode = json['postcode'];
    cityName = json['city_name'];
    stateName = json['state_name'];
    icPhoto = json['ic_photo'];
    queueNo = json['queue_no'];
    regDate = json['reg_date'];
    registerPhoto = json['register_photo'];
    testCode = json['test_code'];
    startDate = json['start_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    printed = json['printed'];
    prnCount = json['prn_count'];
    printLog = json['print_log'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    transtamp = json['transtamp'];
    lastupload = json['lastupload'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    deleted = json['deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['test_date'] = testDate;
    data['course_code'] = courseCode;
    data['group_id'] = groupId;
    data['nric_no'] = nricNo;
    data['fullname'] = fullname;
    data['sex'] = sex;
    data['race'] = race;
    data['nationality'] = nationality;
    data['birth_date'] = birthDate;
    data['add1'] = add1;
    data['add2'] = add2;
    data['add3'] = add3;
    data['postcode'] = postcode;
    data['city_name'] = cityName;
    data['state_name'] = stateName;
    data['ic_photo'] = icPhoto;
    data['queue_no'] = queueNo;
    data['reg_date'] = regDate;
    data['register_photo'] = registerPhoto;
    data['test_code'] = testCode;
    data['start_date'] = startDate;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['printed'] = printed;
    data['prn_count'] = prnCount;
    data['print_log'] = printLog;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_user'] = editUser;
    data['edit_date'] = editDate;
    data['transtamp'] = transtamp;
    data['lastupload'] = lastupload;
    data['comp_code'] = compCode;
    data['branch_code'] = branchCode;
    data['deleted'] = deleted;
    return data;
  }
}

class VerifyScanCodeRequest {
  String? wsCodeCrypt;
  String? caUid;
  String? caPwd;
  String? icNo;
  String? diCode;
  String? userId;
  String? qrcodeJson;

  VerifyScanCodeRequest(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
      this.icNo,
      this.diCode,
      this.userId,
      this.qrcodeJson});

  VerifyScanCodeRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    icNo = json['icNo'];
    diCode = json['diCode'];
    userId = json['userId'];
    qrcodeJson = json['qrcodeJson'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wsCodeCrypt'] = wsCodeCrypt;
    data['caUid'] = caUid;
    data['caPwd'] = caPwd;
    data['icNo'] = icNo;
    data['diCode'] = diCode;
    data['userId'] = userId;
    data['qrcodeJson'] = qrcodeJson;
    return data;
  }
}

class VerifyScanCodeResponse {
  List<JpjTestTrn>? jpjTestTrn;

  VerifyScanCodeResponse({this.jpjTestTrn});

  VerifyScanCodeResponse.fromJson(Map<String, dynamic> json) {
    if (json['JpjTestTrn'] != null) {
      jpjTestTrn = List<JpjTestTrn>.empty(growable: true);
      json['JpjTestTrn'].forEach((v) {
        jpjTestTrn!.add(JpjTestTrn.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (jpjTestTrn != null) {
      data['JpjTestTrn'] = jpjTestTrn!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JpjTestTrn {
  String? iD;
  String? testDate;
  String? courseCode;
  String? groupId;
  String? nricNo;
  String? fullname;
  String? sex;
  String? race;
  String? nationality;
  String? birthDate;
  String? add1;
  String? add2;
  String? add3;
  String? postcode;
  String? cityName;
  String? stateName;
  String? icPhoto;
  String? queueNo;
  String? regDate;
  String? registerPhoto;
  String? testCode;
  String? startDate;
  String? startTime;
  String? endTime;
  String? printed;
  String? prnCount;
  String? printLog;
  String? createUser;
  String? createDate;
  String? editUser;
  String? editDate;
  String? transtamp;
  String? lastupload;
  String? compCode;
  String? branchCode;
  String? deleted;

  JpjTestTrn(
      {this.iD,
      this.testDate,
      this.courseCode,
      this.groupId,
      this.nricNo,
      this.fullname,
      this.sex,
      this.race,
      this.nationality,
      this.birthDate,
      this.add1,
      this.add2,
      this.add3,
      this.postcode,
      this.cityName,
      this.stateName,
      this.icPhoto,
      this.queueNo,
      this.regDate,
      this.registerPhoto,
      this.testCode,
      this.startDate,
      this.startTime,
      this.endTime,
      this.printed,
      this.prnCount,
      this.printLog,
      this.createUser,
      this.createDate,
      this.editUser,
      this.editDate,
      this.transtamp,
      this.lastupload,
      this.compCode,
      this.branchCode,
      this.deleted});

  JpjTestTrn.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    testDate = json['test_date'];
    courseCode = json['course_code'];
    groupId = json['group_id'];
    nricNo = json['nric_no'];
    fullname = json['fullname'];
    sex = json['sex'];
    race = json['race'];
    nationality = json['nationality'];
    birthDate = json['birth_date'];
    add1 = json['add1'];
    add2 = json['add2'];
    add3 = json['add3'];
    postcode = json['postcode'];
    cityName = json['city_name'];
    stateName = json['state_name'];
    icPhoto = json['ic_photo'];
    queueNo = json['queue_no'];
    regDate = json['reg_date'];
    registerPhoto = json['register_photo'];
    testCode = json['test_code'];
    startDate = json['start_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    printed = json['printed'];
    prnCount = json['prn_count'];
    printLog = json['print_log'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    transtamp = json['transtamp'];
    lastupload = json['lastupload'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    deleted = json['deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['test_date'] = testDate;
    data['course_code'] = courseCode;
    data['group_id'] = groupId;
    data['nric_no'] = nricNo;
    data['fullname'] = fullname;
    data['sex'] = sex;
    data['race'] = race;
    data['nationality'] = nationality;
    data['birth_date'] = birthDate;
    data['add1'] = add1;
    data['add2'] = add2;
    data['add3'] = add3;
    data['postcode'] = postcode;
    data['city_name'] = cityName;
    data['state_name'] = stateName;
    data['ic_photo'] = icPhoto;
    data['queue_no'] = queueNo;
    data['reg_date'] = regDate;
    data['register_photo'] = registerPhoto;
    data['test_code'] = testCode;
    data['start_date'] = startDate;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['printed'] = printed;
    data['prn_count'] = prnCount;
    data['print_log'] = printLog;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_user'] = editUser;
    data['edit_date'] = editDate;
    data['transtamp'] = transtamp;
    data['lastupload'] = lastupload;
    data['comp_code'] = compCode;
    data['branch_code'] = branchCode;
    data['deleted'] = deleted;
    return data;
  }
}

class GetScanCodeByActionRequest {
  String? wsCodeCrypt;
  String? caUid;
  String? caPwd;
  String? icNo;
  String? diCode;
  String? userId;
  String? action;

  GetScanCodeByActionRequest(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
      this.icNo,
      this.diCode,
      this.userId,
      this.action});

  GetScanCodeByActionRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    icNo = json['icNo'];
    diCode = json['diCode'];
    userId = json['userId'];
    action = json['action'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wsCodeCrypt'] = wsCodeCrypt;
    data['caUid'] = caUid;
    data['caPwd'] = caPwd;
    data['icNo'] = icNo;
    data['diCode'] = diCode;
    data['userId'] = userId;
    data['action'] = action;
    return data;
  }
}

class GetScanCodeByActionResponse {
  List<Table1>? table1;

  GetScanCodeByActionResponse({this.table1});

  GetScanCodeByActionResponse.fromJson(Map<String, dynamic> json) {
    if (json['Table1'] != null) {
      table1 = List<Table1>.empty(growable: true);
      json['Table1'].forEach((v) {
        table1!.add(Table1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (table1 != null) {
      data['Table1'] = table1!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Table1 {
  String? merchantNo;
  String? action;
  String? datetime;

  Table1({this.merchantNo, this.action, this.datetime});

  Table1.fromJson(Map<String, dynamic> json) {
    merchantNo = json['merchant_no'];
    action = json['action'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['merchant_no'] = merchantNo;
    data['action'] = action;
    data['datetime'] = datetime;
    return data;
  }
}

class GetLastCallingJpjTestQueueNumberResponse {
  List<LastCallingQueueJpjTestTrn>? jpjTestTrn;

  GetLastCallingJpjTestQueueNumberResponse({this.jpjTestTrn});

  GetLastCallingJpjTestQueueNumberResponse.fromJson(Map<String, dynamic> json) {
    if (json['JpjTestTrn'] != null) {
      jpjTestTrn = List<LastCallingQueueJpjTestTrn>.empty(growable: true);
      json['JpjTestTrn'].forEach((v) {
        jpjTestTrn!.add(LastCallingQueueJpjTestTrn.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (jpjTestTrn != null) {
      data['JpjTestTrn'] = jpjTestTrn!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LastCallingQueueJpjTestTrn {
  String? iD;
  String? testDate;
  String? courseCode;
  String? groupId;
  String? nricNo;
  String? fullname;
  String? sex;
  String? race;
  String? nationality;
  String? birthDate;
  String? add1;
  String? add2;
  String? add3;
  String? postcode;
  String? cityName;
  String? stateName;
  String? icPhoto;
  String? queueNo;
  String? regDate;
  String? registerPhoto;
  String? testCode;
  String? startDate;
  String? startTime;
  String? endTime;
  String? printed;
  String? prnCount;
  String? printLog;
  String? createUser;
  String? createDate;
  String? editUser;
  String? editDate;
  String? transtamp;
  String? lastupload;
  String? compCode;
  String? branchCode;
  String? deleted;

  LastCallingQueueJpjTestTrn(
      {this.iD,
      this.testDate,
      this.courseCode,
      this.groupId,
      this.nricNo,
      this.fullname,
      this.sex,
      this.race,
      this.nationality,
      this.birthDate,
      this.add1,
      this.add2,
      this.add3,
      this.postcode,
      this.cityName,
      this.stateName,
      this.icPhoto,
      this.queueNo,
      this.regDate,
      this.registerPhoto,
      this.testCode,
      this.startDate,
      this.startTime,
      this.endTime,
      this.printed,
      this.prnCount,
      this.printLog,
      this.createUser,
      this.createDate,
      this.editUser,
      this.editDate,
      this.transtamp,
      this.lastupload,
      this.compCode,
      this.branchCode,
      this.deleted});

  LastCallingQueueJpjTestTrn.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    testDate = json['test_date'];
    courseCode = json['course_code'];
    groupId = json['group_id'];
    nricNo = json['nric_no'];
    fullname = json['fullname'];
    sex = json['sex'];
    race = json['race'];
    nationality = json['nationality'];
    birthDate = json['birth_date'];
    add1 = json['add1'];
    add2 = json['add2'];
    add3 = json['add3'];
    postcode = json['postcode'];
    cityName = json['city_name'];
    stateName = json['state_name'];
    icPhoto = json['ic_photo'];
    queueNo = json['queue_no'];
    regDate = json['reg_date'];
    registerPhoto = json['register_photo'];
    testCode = json['test_code'];
    startDate = json['start_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    printed = json['printed'];
    prnCount = json['prn_count'];
    printLog = json['print_log'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    transtamp = json['transtamp'];
    lastupload = json['lastupload'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    deleted = json['deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['test_date'] = testDate;
    data['course_code'] = courseCode;
    data['group_id'] = groupId;
    data['nric_no'] = nricNo;
    data['fullname'] = fullname;
    data['sex'] = sex;
    data['race'] = race;
    data['nationality'] = nationality;
    data['birth_date'] = birthDate;
    data['add1'] = add1;
    data['add2'] = add2;
    data['add3'] = add3;
    data['postcode'] = postcode;
    data['city_name'] = cityName;
    data['state_name'] = stateName;
    data['ic_photo'] = icPhoto;
    data['queue_no'] = queueNo;
    data['reg_date'] = regDate;
    data['register_photo'] = registerPhoto;
    data['test_code'] = testCode;
    data['start_date'] = startDate;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['printed'] = printed;
    data['prn_count'] = prnCount;
    data['print_log'] = printLog;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_user'] = editUser;
    data['edit_date'] = editDate;
    data['transtamp'] = transtamp;
    data['lastupload'] = lastupload;
    data['comp_code'] = compCode;
    data['branch_code'] = branchCode;
    data['deleted'] = deleted;
    return data;
  }
}

class GetStuPracByCodeResponse {
  List<StuPrac>? stuPrac;

  GetStuPracByCodeResponse({this.stuPrac});

  GetStuPracByCodeResponse.fromJson(Map<String, dynamic> json) {
    if (json['StuPrac'] != null) {
      stuPrac = List<StuPrac>.empty(growable: true);
      json['StuPrac'].forEach((v) {
        stuPrac!.add(StuPrac.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (stuPrac != null) {
      data['StuPrac'] = stuPrac!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StuPrac {
  String? id;
  String? icNo;
  String? stuNo;
  String? trandate;
  String? vehNo;
  String? trnCode;
  String? slipNo;
  String? sm4No;
  String? certNo;
  String? groupId;
  String? kppGroupId;
  String? kppGroupId2;
  String? kppGroupId3;
  String? kClass;
  String? bgTime;
  String? endTime;
  String? employeNo;
  String? remark;
  String? dsCode;
  String? pracType;
  String? sysTime;
  String? closeUser;
  String? closeDate;
  String? epretCode;
  String? epretReqid;
  String? ekppCode;
  String? ekppReqid;
  String? transtamp;
  String? actBgTime;
  String? actEndTime;
  String? byFingerprn;
  String? ej2aTick;
  String? ej2aInd;
  String? ej2aStat;
  String? ej2bInd;
  String? ej2bTick;
  String? ej2bStat;
  String? snoBkpp;
  String? adminId1;
  String? actBgTime2;
  String? classCode;
  String? verifyTrncode;
  String? actEndTime2;
  String? ej2aRemark;
  String? ej2bRemark;
  String? entryType;
  String? sjlprndate;
  String? issueSjDate;
  String? courseCode;
  String? location;
  String? theoryType;
  String? totalTime;
  String? kpp02CertNo;
  String? kpp02IssueSjDate;
  String? kpp02Sjlprndate;
  String? sessionTotalTime;
  String? compCode;
  String? branchCode;
  String? rowKey;
  String? lastupload;
  String? deleted;
  String? diCode;
  String? merchantNo;

  StuPrac(
      {this.id,
      this.icNo,
      this.stuNo,
      this.trandate,
      this.vehNo,
      this.trnCode,
      this.slipNo,
      this.sm4No,
      this.certNo,
      this.groupId,
      this.kppGroupId,
      this.kppGroupId2,
      this.kppGroupId3,
      this.kClass,
      this.bgTime,
      this.endTime,
      this.employeNo,
      this.remark,
      this.dsCode,
      this.pracType,
      this.sysTime,
      this.closeUser,
      this.closeDate,
      this.epretCode,
      this.epretReqid,
      this.ekppCode,
      this.ekppReqid,
      this.transtamp,
      this.actBgTime,
      this.actEndTime,
      this.byFingerprn,
      this.ej2aTick,
      this.ej2aInd,
      this.ej2aStat,
      this.ej2bInd,
      this.ej2bTick,
      this.ej2bStat,
      this.snoBkpp,
      this.adminId1,
      this.actBgTime2,
      this.classCode,
      this.verifyTrncode,
      this.actEndTime2,
      this.ej2aRemark,
      this.ej2bRemark,
      this.entryType,
      this.sjlprndate,
      this.issueSjDate,
      this.courseCode,
      this.location,
      this.theoryType,
      this.totalTime,
      this.kpp02CertNo,
      this.kpp02IssueSjDate,
      this.kpp02Sjlprndate,
      this.sessionTotalTime,
      this.compCode,
      this.branchCode,
      this.rowKey,
      this.lastupload,
      this.deleted,
      this.diCode,
      this.merchantNo});

  StuPrac.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icNo = json['ic_no'];
    stuNo = json['stu_no'];
    trandate = json['trandate'];
    vehNo = json['veh_no'];
    trnCode = json['trn_code'];
    slipNo = json['slip_no'];
    sm4No = json['sm4_no'];
    certNo = json['cert_no'];
    groupId = json['group_id'];
    kppGroupId = json['kpp_group_id'];
    kppGroupId2 = json['kpp_group_id_2'];
    kppGroupId3 = json['kpp_group_id_3'];
    kClass = json['class'];
    bgTime = json['bg_time'];
    endTime = json['end_time'];
    employeNo = json['employe_no'];
    remark = json['remark'];
    dsCode = json['ds_code'];
    pracType = json['prac_type'];
    sysTime = json['sys_time'];
    closeUser = json['close_user'];
    closeDate = json['close_date'];
    epretCode = json['epret_code'];
    epretReqid = json['epret_reqid'];
    ekppCode = json['ekpp_code'];
    ekppReqid = json['ekpp_reqid'];
    transtamp = json['transtamp'];
    actBgTime = json['act_bg_time'];
    actEndTime = json['act_end_time'];
    byFingerprn = json['by_fingerprn'];
    ej2aTick = json['ej2a_tick'];
    ej2aInd = json['ej2a_ind'];
    ej2aStat = json['ej2a_stat'];
    ej2bInd = json['ej2b_ind'];
    ej2bTick = json['ej2b_tick'];
    ej2bStat = json['ej2b_stat'];
    snoBkpp = json['sno_bkpp'];
    adminId1 = json['admin_id1'];
    actBgTime2 = json['act_bg_time2'];
    classCode = json['class_code'];
    verifyTrncode = json['verify_trncode'];
    actEndTime2 = json['act_end_time2'];
    ej2aRemark = json['ej2a_remark'];
    ej2bRemark = json['ej2b_remark'];
    entryType = json['entry_type'];
    sjlprndate = json['sjlprndate'];
    issueSjDate = json['issue_sj_date'];
    courseCode = json['course_code'];
    location = json['location'];
    theoryType = json['theory_type'];
    totalTime = json['total_time'];
    kpp02CertNo = json['kpp02_cert_no'];
    kpp02IssueSjDate = json['kpp02_issue_sj_date'];
    kpp02Sjlprndate = json['kpp02_sjlprndate'];
    sessionTotalTime = json['session_total_time'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    rowKey = json['row_key'];
    lastupload = json['lastupload'];
    deleted = json['deleted'];
    diCode = json['di_code'];
    merchantNo = json['merchant_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ic_no'] = icNo;
    data['stu_no'] = stuNo;
    data['trandate'] = trandate;
    data['veh_no'] = vehNo;
    data['trn_code'] = trnCode;
    data['slip_no'] = slipNo;
    data['sm4_no'] = sm4No;
    data['cert_no'] = certNo;
    data['group_id'] = groupId;
    data['kpp_group_id'] = kppGroupId;
    data['kpp_group_id_2'] = kppGroupId2;
    data['kpp_group_id_3'] = kppGroupId3;
    data['class'] = kClass;
    data['bg_time'] = bgTime;
    data['end_time'] = endTime;
    data['employe_no'] = employeNo;
    data['remark'] = remark;
    data['ds_code'] = dsCode;
    data['prac_type'] = pracType;
    data['sys_time'] = sysTime;
    data['close_user'] = closeUser;
    data['close_date'] = closeDate;
    data['epret_code'] = epretCode;
    data['epret_reqid'] = epretReqid;
    data['ekpp_code'] = ekppCode;
    data['ekpp_reqid'] = ekppReqid;
    data['transtamp'] = transtamp;
    data['act_bg_time'] = actBgTime;
    data['act_end_time'] = actEndTime;
    data['by_fingerprn'] = byFingerprn;
    data['ej2a_tick'] = ej2aTick;
    data['ej2a_ind'] = ej2aInd;
    data['ej2a_stat'] = ej2aStat;
    data['ej2b_ind'] = ej2bInd;
    data['ej2b_tick'] = ej2bTick;
    data['ej2b_stat'] = ej2bStat;
    data['sno_bkpp'] = snoBkpp;
    data['admin_id1'] = adminId1;
    data['act_bg_time2'] = actBgTime2;
    data['class_code'] = classCode;
    data['verify_trncode'] = verifyTrncode;
    data['act_end_time2'] = actEndTime2;
    data['ej2a_remark'] = ej2aRemark;
    data['ej2b_remark'] = ej2bRemark;
    data['entry_type'] = entryType;
    data['sjlprndate'] = sjlprndate;
    data['issue_sj_date'] = issueSjDate;
    data['course_code'] = courseCode;
    data['location'] = location;
    data['theory_type'] = theoryType;
    data['total_time'] = totalTime;
    data['kpp02_cert_no'] = kpp02CertNo;
    data['kpp02_issue_sj_date'] = kpp02IssueSjDate;
    data['kpp02_sjlprndate'] = kpp02Sjlprndate;
    data['session_total_time'] = sessionTotalTime;
    data['comp_code'] = compCode;
    data['branch_code'] = branchCode;
    data['row_key'] = rowKey;
    data['lastupload'] = lastupload;
    data['deleted'] = deleted;
    data['di_code'] = diCode;
    data['merchant_no'] = merchantNo;
    return data;
  }
}
