class GetEnrollmentResponse {
  List<Enroll> enroll;

  GetEnrollmentResponse({this.enroll});

  GetEnrollmentResponse.fromJson(Map<String, dynamic> json) {
    if (json['Enroll'] != null) {
      enroll = new List<Enroll>.empty(growable: true);
      json['Enroll'].forEach((v) {
        enroll.add(new Enroll.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.enroll != null) {
      data['Enroll'] = this.enroll.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Enroll {
  String id;
  String trandate;
  String icNo;
  String groupId;
  String kppGroupId;
  String kppGroupId2;
  String kppGroupId3;
  String blacklisted;
  String stuNo;
  String dsCode;
  String employeNo;
  String introBy;
  String commType;
  String feesAgree;
  String hrsAgree;
  String addhrChrg;
  String promptTes;
  String totalPaid;
  String retest;
  String certNo;
  String kpp02CertNo;
  String remark;
  String tlHrsTak;
  String exclIncml;
  String sm4No;
  String pickupPoint;
  String transtamp;
  String epretCode;
  String epretReqid;
  String ekppCode;
  String ekppReqid;
  String ej2bStat;
  String ej2bTick;
  String ej2aTick;
  String addClass;
  String l2aPrnCount;
  String l2bPrnCount;
  String sm4PrnCount;
  String userId;
  String kpp02CertPath;
  String compCode;
  String branchCode;
  String lastupload;
  String deleted;
  String diCode;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['trandate'] = this.trandate;
    data['ic_no'] = this.icNo;
    data['group_id'] = this.groupId;
    data['kpp_group_id'] = this.kppGroupId;
    data['kpp_group_id_2'] = this.kppGroupId2;
    data['kpp_group_id_3'] = this.kppGroupId3;
    data['blacklisted'] = this.blacklisted;
    data['stu_no'] = this.stuNo;
    data['ds_code'] = this.dsCode;
    data['employe_no'] = this.employeNo;
    data['intro_by'] = this.introBy;
    data['comm_type'] = this.commType;
    data['fees_agree'] = this.feesAgree;
    data['hrs_agree'] = this.hrsAgree;
    data['addhr_chrg'] = this.addhrChrg;
    data['prompt_tes'] = this.promptTes;
    data['total_paid'] = this.totalPaid;
    data['retest'] = this.retest;
    data['cert_no'] = this.certNo;
    data['kpp02_cert_no'] = this.kpp02CertNo;
    data['remark'] = this.remark;
    data['tl_hrs_tak'] = this.tlHrsTak;
    data['excl_incml'] = this.exclIncml;
    data['sm4_no'] = this.sm4No;
    data['pickup_point'] = this.pickupPoint;
    data['transtamp'] = this.transtamp;
    data['epret_code'] = this.epretCode;
    data['epret_reqid'] = this.epretReqid;
    data['ekpp_code'] = this.ekppCode;
    data['ekpp_reqid'] = this.ekppReqid;
    data['ej2b_stat'] = this.ej2bStat;
    data['ej2b_tick'] = this.ej2bTick;
    data['ej2a_tick'] = this.ej2aTick;
    data['add_class'] = this.addClass;
    data['l2a_prn_count'] = this.l2aPrnCount;
    data['l2b_prn_count'] = this.l2bPrnCount;
    data['sm4_prn_count'] = this.sm4PrnCount;
    data['user_id'] = this.userId;
    data['kpp02_cert_path'] = this.kpp02CertPath;
    data['comp_code'] = this.compCode;
    data['branch_code'] = this.branchCode;
    data['lastupload'] = this.lastupload;
    data['deleted'] = this.deleted;
    data['di_code'] = this.diCode;
    return data;
  }
}

// get enrolled classes
class EnrolledClassesRequest {
  String wsCodeCrypt;
  String caUid;
  String caPwd;
  String diCode;
  String icNo;
  String groupId;

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
}

class EnrolledClassesResponse {
  List<StuPrac> stuPrac;

  EnrolledClassesResponse({this.stuPrac});

  EnrolledClassesResponse.fromJson(Map<String, dynamic> json) {
    if (json['StuPrac'] != null) {
      stuPrac = new List<StuPrac>.empty(growable: true);
      json['StuPrac'].forEach((v) {
        stuPrac.add(new StuPrac.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stuPrac != null) {
      data['StuPrac'] = this.stuPrac.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StuPrac {
  String id;
  String icNo;
  String stuNo;
  String trandate;
  String vehNo;
  String trnCode;
  String slipNo;
  String sm4No;
  String certNo;
  String kpp02CertNo;
  String groupId;
  String kppGroupId;
  String kppGroupId2;
  String kppGroupId3;
  String classes;
  String bgTime;
  String endTime;
  String employeNo;
  String remark;
  String dsCode;
  String pracType;
  String sysTime;
  String closeUser;
  String closeDate;
  String epretCode;
  String epretReqid;
  String ekppCode;
  String ekppReqid;
  String transtamp;
  String actBgTime;
  String actEndTime;
  String byFingerprn;
  String adminId1;
  String actBgTime2;
  String actEndTime2;
  String classCode;
  String verifyTrncode;
  String entryType;
  String ej2aTick;
  String ej2aInd;
  String ej2aStat;
  String ej2bTick;
  String ej2bInd;
  String ej2bStat;
  String location;
  String courseCode;
  String theoryType;
  String sessionTotalTime;
  String totalTime;
  String compCode;
  String branchCode;
  String lastupload;
  String deleted;
  String diCode;

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
      this.kpp02CertNo,
      this.groupId,
      this.kppGroupId,
      this.kppGroupId2,
      this.kppGroupId3,
      this.classes,
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
      this.adminId1,
      this.actBgTime2,
      this.actEndTime2,
      this.classCode,
      this.verifyTrncode,
      this.entryType,
      this.ej2aTick,
      this.ej2aInd,
      this.ej2aStat,
      this.ej2bTick,
      this.ej2bInd,
      this.ej2bStat,
      this.location,
      this.courseCode,
      this.theoryType,
      this.sessionTotalTime,
      this.totalTime,
      this.compCode,
      this.branchCode,
      this.lastupload,
      this.deleted,
      this.diCode});

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
    kpp02CertNo = json['kpp02_cert_no'];
    groupId = json['group_id'];
    kppGroupId = json['kpp_group_id'];
    kppGroupId2 = json['kpp_group_id_2'];
    kppGroupId3 = json['kpp_group_id_3'];
    classes = json['class'];
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
    adminId1 = json['admin_id1'];
    actBgTime2 = json['act_bg_time2'];
    actEndTime2 = json['act_end_time2'];
    classCode = json['class_code'];
    verifyTrncode = json['verify_trncode'];
    entryType = json['entry_type'];
    ej2aTick = json['ej2a_tick'];
    ej2aInd = json['ej2a_ind'];
    ej2aStat = json['ej2a_stat'];
    ej2bTick = json['ej2b_tick'];
    ej2bInd = json['ej2b_ind'];
    ej2bStat = json['ej2b_stat'];
    location = json['location'];
    courseCode = json['course_code'];
    theoryType = json['theory_type'];
    sessionTotalTime = json['session_total_time'];
    totalTime = json['total_time'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    lastupload = json['lastupload'];
    deleted = json['deleted'];
    diCode = json['di_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ic_no'] = this.icNo;
    data['stu_no'] = this.stuNo;
    data['trandate'] = this.trandate;
    data['veh_no'] = this.vehNo;
    data['trn_code'] = this.trnCode;
    data['slip_no'] = this.slipNo;
    data['sm4_no'] = this.sm4No;
    data['cert_no'] = this.certNo;
    data['kpp02_cert_no'] = this.kpp02CertNo;
    data['group_id'] = this.groupId;
    data['kpp_group_id'] = this.kppGroupId;
    data['kpp_group_id_2'] = this.kppGroupId2;
    data['kpp_group_id_3'] = this.kppGroupId3;
    data['class'] = this.classes;
    data['bg_time'] = this.bgTime;
    data['end_time'] = this.endTime;
    data['employe_no'] = this.employeNo;
    data['remark'] = this.remark;
    data['ds_code'] = this.dsCode;
    data['prac_type'] = this.pracType;
    data['sys_time'] = this.sysTime;
    data['close_user'] = this.closeUser;
    data['close_date'] = this.closeDate;
    data['epret_code'] = this.epretCode;
    data['epret_reqid'] = this.epretReqid;
    data['ekpp_code'] = this.ekppCode;
    data['ekpp_reqid'] = this.ekppReqid;
    data['transtamp'] = this.transtamp;
    data['act_bg_time'] = this.actBgTime;
    data['act_end_time'] = this.actEndTime;
    data['by_fingerprn'] = this.byFingerprn;
    data['admin_id1'] = this.adminId1;
    data['act_bg_time2'] = this.actBgTime2;
    data['act_end_time2'] = this.actEndTime2;
    data['class_code'] = this.classCode;
    data['verify_trncode'] = this.verifyTrncode;
    data['entry_type'] = this.entryType;
    data['ej2a_tick'] = this.ej2aTick;
    data['ej2a_ind'] = this.ej2aInd;
    data['ej2a_stat'] = this.ej2aStat;
    data['ej2b_tick'] = this.ej2bTick;
    data['ej2b_ind'] = this.ej2bInd;
    data['ej2b_stat'] = this.ej2bStat;
    data['location'] = this.location;
    data['course_code'] = this.courseCode;
    data['theory_type'] = this.theoryType;
    data['session_total_time'] = this.sessionTotalTime;
    data['total_time'] = this.totalTime;
    data['comp_code'] = this.compCode;
    data['branch_code'] = this.branchCode;
    data['lastupload'] = this.lastupload;
    data['deleted'] = this.deleted;
    data['di_code'] = this.diCode;
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
  List<CollectTrn> collectTrn;

  StudentPaymentResponse({this.collectTrn});

  StudentPaymentResponse.fromJson(Map<String, dynamic> json) {
    if (json['CollectTrn'] != null) {
      collectTrn = new List<CollectTrn>.empty(growable: true);
      json['CollectTrn'].forEach((v) {
        collectTrn.add(new CollectTrn.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.collectTrn != null) {
      data['CollectTrn'] = this.collectTrn.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CollectTrn {
  String jobNo;
  String recpNo;
  String serialType;
  String trandate;
  String trantime;
  String vehNo;
  String icNo;
  String dsCode;
  String tdefaAmt;
  String thandChrg;
  String tservChrg;
  String tservTax;
  String tranTotal;
  String roundAmt;
  String tranUser;
  String payAmount;
  String payMode;
  String crdType;
  String payRefno;
  String balAmount;
  String tlTaxAmt;
  String cancelUser;
  String cancelOn;
  String cancel;
  String transtamp;
  String batchNo;
  String cashAmount;
  String chqAmount;
  String ccAmount;
  String packageCode;
  String commAmount;
  String oriRecpno;
  String oriStype;
  String tcommAmt;
  String tagentCommAmt;
  String compCode;
  String branchCode;
  String lastupload;
  String deleted;
  String diCode;
  String id;
  String ctrlNo;
  String jobNo1;
  String recpNo1;
  String bookNo;
  String trandate1;
  String trantime1;
  String vehNo1;
  String icNo1;
  String groupId;
  String grpDesc;
  String tranCateg;
  String packageCode1;
  String itemQty;
  String itemPrice;
  String taxCode;
  String taxRate;
  String taxAmt;
  String priceIncludeGst;
  String defaAmt;
  String unitHandChrg;
  String handChrg;
  String unitServChrg;
  String servChrg;
  String unitServTax;
  String servTax;
  String tranTotal1;
  String nettAmt;
  String unitCommAmt;
  String transtamp1;
  String commAmt;
  String unitAgentComm;
  String agentCommAmt;
  String trnCode;
  String trnDesc;
  String compCode1;
  String branchCode1;
  String lastupload1;
  String deleted1;
  String diCode1;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_no'] = this.jobNo;
    data['recp_no'] = this.recpNo;
    data['serial_type'] = this.serialType;
    data['trandate'] = this.trandate;
    data['trantime'] = this.trantime;
    data['veh_no'] = this.vehNo;
    data['ic_no'] = this.icNo;
    data['ds_code'] = this.dsCode;
    data['tdefa_amt'] = this.tdefaAmt;
    data['thand_chrg'] = this.thandChrg;
    data['tserv_chrg'] = this.tservChrg;
    data['tserv_tax'] = this.tservTax;
    data['tran_total'] = this.tranTotal;
    data['round_amt'] = this.roundAmt;
    data['tran_user'] = this.tranUser;
    data['pay_amount'] = this.payAmount;
    data['pay_mode'] = this.payMode;
    data['crd_type'] = this.crdType;
    data['pay_refno'] = this.payRefno;
    data['bal_amount'] = this.balAmount;
    data['tl_tax_amt'] = this.tlTaxAmt;
    data['cancel_user'] = this.cancelUser;
    data['cancel_on'] = this.cancelOn;
    data['cancel'] = this.cancel;
    data['transtamp'] = this.transtamp;
    data['batch_no'] = this.batchNo;
    data['cash_amount'] = this.cashAmount;
    data['chq_amount'] = this.chqAmount;
    data['cc_amount'] = this.ccAmount;
    data['package_code'] = this.packageCode;
    data['comm_amount'] = this.commAmount;
    data['ori_recpno'] = this.oriRecpno;
    data['ori_stype'] = this.oriStype;
    data['tcomm_amt'] = this.tcommAmt;
    data['tagent_comm_amt'] = this.tagentCommAmt;
    data['comp_code'] = this.compCode;
    data['branch_code'] = this.branchCode;
    data['lastupload'] = this.lastupload;
    data['deleted'] = this.deleted;
    data['di_code'] = this.diCode;
    data['id'] = this.id;
    data['ctrl_no'] = this.ctrlNo;
    data['job_no1'] = this.jobNo1;
    data['recp_no1'] = this.recpNo1;
    data['book_no'] = this.bookNo;
    data['trandate1'] = this.trandate1;
    data['trantime1'] = this.trantime1;
    data['veh_no1'] = this.vehNo1;
    data['ic_no1'] = this.icNo1;
    data['group_id'] = this.groupId;
    data['grp_desc'] = this.grpDesc;
    data['tran_categ'] = this.tranCateg;
    data['package_code1'] = this.packageCode1;
    data['item_qty'] = this.itemQty;
    data['item_price'] = this.itemPrice;
    data['tax_code'] = this.taxCode;
    data['tax_rate'] = this.taxRate;
    data['tax_amt'] = this.taxAmt;
    data['price_include_gst'] = this.priceIncludeGst;
    data['defa_amt'] = this.defaAmt;
    data['unit_hand_chrg'] = this.unitHandChrg;
    data['hand_chrg'] = this.handChrg;
    data['unit_serv_chrg'] = this.unitServChrg;
    data['serv_chrg'] = this.servChrg;
    data['unit_serv_tax'] = this.unitServTax;
    data['serv_tax'] = this.servTax;
    data['tran_total1'] = this.tranTotal1;
    data['nett_amt'] = this.nettAmt;
    data['unit_comm_amt'] = this.unitCommAmt;
    data['transtamp1'] = this.transtamp1;
    data['comm_amt'] = this.commAmt;
    data['unit_agent_comm'] = this.unitAgentComm;
    data['agent_comm_amt'] = this.agentCommAmt;
    data['trn_code'] = this.trnCode;
    data['trn_desc'] = this.trnDesc;
    data['comp_code1'] = this.compCode1;
    data['branch_code1'] = this.branchCode1;
    data['lastupload1'] = this.lastupload1;
    data['deleted1'] = this.deleted1;
    data['di_code1'] = this.diCode1;
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
  List<DTest> dTest;

  GetDTestByCodeResponse({this.dTest});

  GetDTestByCodeResponse.fromJson(Map<String, dynamic> json) {
    if (json['DTest'] != null) {
      dTest = new List<DTest>.empty(growable: true);
      json['DTest'].forEach((v) {
        dTest.add(new DTest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dTest != null) {
      data['DTest'] = this.dTest.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DTest {
  String id;
  String icNo;
  String nric;
  String stuNo;
  String dsCode;
  String classes;
  String testDate;
  String testType;
  String groupId;
  String hrsAgree;
  String cardNo;
  String sijilNo;
  String tableNo;
  String time;
  String noCorrect;
  String partIi;
  String partI;
  String partIii;
  String result;
  String partIv;
  String testPart;
  String repeat;
  String amount;
  String pasCrtNo;
  String remark;
  String recNo;
  String sm4No;
  String attempt;
  String cancel;
  String closed;
  String bookNo;
  String ctrlNo;
  String ereqCode;
  String ereqId;
  String ebookDate;
  String etestTime;
  String eattempt;
  String ereqRecp;
  String ereqBookid;
  String ereqAmtpd;
  String erefNo;
  String esent;
  String eaccept;
  String erejReason;
  String siteCode;
  String transtamp;
  String classCode;
  String recpNo;
  String cardDate;
  String aprvDate;
  String pRemark;
  String pAmount;
  String sesi;
  String testLoc;
  String apprvBooking;
  String compCode;
  String branchCode;
  String rowKey;
  String lastupload;
  String deleted;
  String diCode;
  String testTypeValue;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ic_no'] = this.icNo;
    data['nric'] = this.nric;
    data['stu_no'] = this.stuNo;
    data['ds_code'] = this.dsCode;
    data['class'] = this.classes;
    data['test_date'] = this.testDate;
    data['test_type'] = this.testType;
    data['group_id'] = this.groupId;
    data['hrs_agree'] = this.hrsAgree;
    data['card_no'] = this.cardNo;
    data['sijil_no'] = this.sijilNo;
    data['table_no'] = this.tableNo;
    data['time'] = this.time;
    data['no_correct'] = this.noCorrect;
    data['part_ii'] = this.partIi;
    data['part_i'] = this.partI;
    data['part_iii'] = this.partIii;
    data['result'] = this.result;
    data['part_iv'] = this.partIv;
    data['test_part'] = this.testPart;
    data['repeat'] = this.repeat;
    data['amount'] = this.amount;
    data['pas_crt_no'] = this.pasCrtNo;
    data['remark'] = this.remark;
    data['rec_no'] = this.recNo;
    data['sm4_no'] = this.sm4No;
    data['attempt'] = this.attempt;
    data['cancel'] = this.cancel;
    data['closed'] = this.closed;
    data['book_no'] = this.bookNo;
    data['ctrl_no'] = this.ctrlNo;
    data['ereq_code'] = this.ereqCode;
    data['ereq_id'] = this.ereqId;
    data['ebook_date'] = this.ebookDate;
    data['etest_time'] = this.etestTime;
    data['eattempt'] = this.eattempt;
    data['ereq_recp'] = this.ereqRecp;
    data['ereq_bookid'] = this.ereqBookid;
    data['ereq_amtpd'] = this.ereqAmtpd;
    data['eref_no'] = this.erefNo;
    data['esent'] = this.esent;
    data['eaccept'] = this.eaccept;
    data['erej_reason'] = this.erejReason;
    data['site_code'] = this.siteCode;
    data['transtamp'] = this.transtamp;
    data['class_code'] = this.classCode;
    data['recp_no'] = this.recpNo;
    data['card_date'] = this.cardDate;
    data['aprv_date'] = this.aprvDate;
    data['p_remark'] = this.pRemark;
    data['p_amount'] = this.pAmount;
    data['sesi'] = this.sesi;
    data['test_loc'] = this.testLoc;
    data['apprv_booking'] = this.apprvBooking;
    data['comp_code'] = this.compCode;
    data['branch_code'] = this.branchCode;
    data['row_key'] = this.rowKey;
    data['lastupload'] = this.lastupload;
    data['deleted'] = this.deleted;
    data['di_code'] = this.diCode;
    data['test_type_value'] = this.testTypeValue;
    return data;
  }
}

// GetCollectionDetailByRecNoResponse
class GetCollectionDetailByRecpNoResponse {
  List<CollectDetail> collectDetail;

  GetCollectionDetailByRecpNoResponse({this.collectDetail});

  GetCollectionDetailByRecpNoResponse.fromJson(Map<String, dynamic> json) {
    if (json['CollectDetail'] != null) {
      collectDetail = new List<CollectDetail>.empty(growable: true);
      json['CollectDetail'].forEach((v) {
        collectDetail.add(new CollectDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.collectDetail != null) {
      data['CollectDetail'] =
          this.collectDetail.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CollectDetail {
  String id;
  String ctrlNo;
  String jobNo;
  String recpNo;
  String bookNo;
  String trandate;
  String trantime;
  String vehNo;
  String icNo;
  String groupId;
  String grpDesc;
  String tranCateg;
  String packageCode;
  String packageDesc;
  String itemQty;
  String itemPrice;
  String taxCode;
  String taxRate;
  String taxAmt;
  String priceIncludeGst;
  String defaAmt;
  String unitHandChrg;
  String handChrg;
  String unitServChrg;
  String servChrg;
  String unitServTax;
  String servTax;
  String tranTotal;
  String nettAmt;
  String unitCommAmt;
  String transtamp;
  String commAmt;
  String unitAgentComm;
  String agentCommAmt;
  String trnCode;
  String trnDesc;
  String compCode;
  String branchCode;
  String lastupload;
  String deleted;
  String diCode;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ctrl_no'] = this.ctrlNo;
    data['job_no'] = this.jobNo;
    data['recp_no'] = this.recpNo;
    data['book_no'] = this.bookNo;
    data['trandate'] = this.trandate;
    data['trantime'] = this.trantime;
    data['veh_no'] = this.vehNo;
    data['ic_no'] = this.icNo;
    data['group_id'] = this.groupId;
    data['grp_desc'] = this.grpDesc;
    data['tran_categ'] = this.tranCateg;
    data['package_code'] = this.packageCode;
    data['package_desc'] = this.packageDesc;
    data['item_qty'] = this.itemQty;
    data['item_price'] = this.itemPrice;
    data['tax_code'] = this.taxCode;
    data['tax_rate'] = this.taxRate;
    data['tax_amt'] = this.taxAmt;
    data['price_include_gst'] = this.priceIncludeGst;
    data['defa_amt'] = this.defaAmt;
    data['unit_hand_chrg'] = this.unitHandChrg;
    data['hand_chrg'] = this.handChrg;
    data['unit_serv_chrg'] = this.unitServChrg;
    data['serv_chrg'] = this.servChrg;
    data['unit_serv_tax'] = this.unitServTax;
    data['serv_tax'] = this.servTax;
    data['tran_total'] = this.tranTotal;
    data['nett_amt'] = this.nettAmt;
    data['unit_comm_amt'] = this.unitCommAmt;
    data['transtamp'] = this.transtamp;
    data['comm_amt'] = this.commAmt;
    data['unit_agent_comm'] = this.unitAgentComm;
    data['agent_comm_amt'] = this.agentCommAmt;
    data['trn_code'] = this.trnCode;
    data['trn_desc'] = this.trnDesc;
    data['comp_code'] = this.compCode;
    data['branch_code'] = this.branchCode;
    data['lastupload'] = this.lastupload;
    data['deleted'] = this.deleted;
    data['di_code'] = this.diCode;
    return data;
  }
}

// GetCourseSectionList
class GetCourseSectionListResponse {
  List<CourseSection> courseSection;

  GetCourseSectionListResponse({this.courseSection});

  GetCourseSectionListResponse.fromJson(Map<String, dynamic> json) {
    if (json['CourseSection'] != null) {
      courseSection = new List<CourseSection>.empty(growable: true);
      json['CourseSection'].forEach((v) {
        courseSection.add(new CourseSection.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.courseSection != null) {
      data['CourseSection'] =
          this.courseSection.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseSection {
  String iD;
  String groupId;
  String courseCode;
  String section;
  String sectionDesc;
  String createUser;
  String editUser;
  String transtamp;
  String deleted;
  String lastEditedBy;
  String createdBy;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['group_id'] = this.groupId;
    data['course_code'] = this.courseCode;
    data['section'] = this.section;
    data['section_desc'] = this.sectionDesc;
    data['create_user'] = this.createUser;
    data['edit_user'] = this.editUser;
    data['transtamp'] = this.transtamp;
    data['deleted'] = this.deleted;
    data['last_edited_by'] = this.lastEditedBy;
    data['created_by'] = this.createdBy;
    return data;
  }
}

// GetTestListGroupIdResponse
class GetTestListGroupIdResponse {
  List<GroupIdTest> test;

  GetTestListGroupIdResponse({this.test});

  GetTestListGroupIdResponse.fromJson(Map<String, dynamic> json) {
    if (json['Test'] != null) {
      test = new List<GroupIdTest>.empty(growable: true);
      json['Test'].forEach((v) {
        test.add(new GroupIdTest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.test != null) {
      data['Test'] = this.test.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GroupIdTest {
  String iD;
  String diCode;
  String groupId;
  String testType;
  String testDate;
  String testTime;
  String tlQuota;
  String onlineQuota;
  String createUser;
  String createDate;
  String editUser;
  String editDate;
  String transtamp;
  String deleted;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['di_code'] = this.diCode;
    data['group_id'] = this.groupId;
    data['test_type'] = this.testType;
    data['test_date'] = this.testDate;
    data['test_time'] = this.testTime;
    data['tl_quota'] = this.tlQuota;
    data['online_quota'] = this.onlineQuota;
    data['create_user'] = this.createUser;
    data['create_date'] = this.createDate;
    data['edit_user'] = this.editUser;
    data['edit_date'] = this.editDate;
    data['transtamp'] = this.transtamp;
    data['deleted'] = this.deleted;
    return data;
  }
}

// GetTestListTestTypeResponse
class GetTestListTestTypeResponse {
  List<TestTypeTest> test;

  GetTestListTestTypeResponse({this.test});

  GetTestListTestTypeResponse.fromJson(Map<String, dynamic> json) {
    if (json['Test'] != null) {
      test = new List<TestTypeTest>.empty(growable: true);
      json['Test'].forEach((v) {
        test.add(new TestTypeTest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.test != null) {
      data['Test'] = this.test.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TestTypeTest {
  String iD;
  String diCode;
  String groupId;
  String testType;
  String testDate;
  String testTime;
  String tlQuota;
  String onlineQuota;
  String createUser;
  String createDate;
  String editUser;
  String editDate;
  String transtamp;
  String deleted;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['di_code'] = this.diCode;
    data['group_id'] = this.groupId;
    data['test_type'] = this.testType;
    data['test_date'] = this.testDate;
    data['test_time'] = this.testTime;
    data['tl_quota'] = this.tlQuota;
    data['online_quota'] = this.onlineQuota;
    data['create_user'] = this.createUser;
    data['create_date'] = this.createDate;
    data['edit_user'] = this.editUser;
    data['edit_date'] = this.editDate;
    data['transtamp'] = this.transtamp;
    data['deleted'] = this.deleted;
    return data;
  }
}

// GetTestListResponse
class GetTestListResponse {
  List<Test> test;

  GetTestListResponse({this.test});

  GetTestListResponse.fromJson(Map<String, dynamic> json) {
    if (json['Test'] != null) {
      test = new List<Test>.empty(growable: true);
      json['Test'].forEach((v) {
        test.add(new Test.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.test != null) {
      data['Test'] = this.test.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Test {
  String iD;
  String diCode;
  String groupId;
  String testType;
  String testDate;
  String testTime;
  String tlQuota;
  String onlineQuota;
  String createUser;
  String createDate;
  String editUser;
  String editDate;
  String transtamp;
  String deleted;
  String lastEditedBy;
  String createdBy;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['di_code'] = this.diCode;
    data['group_id'] = this.groupId;
    data['test_type'] = this.testType;
    data['test_date'] = this.testDate;
    data['test_time'] = this.testTime;
    data['tl_quota'] = this.tlQuota;
    data['online_quota'] = this.onlineQuota;
    data['create_user'] = this.createUser;
    data['create_date'] = this.createDate;
    data['edit_user'] = this.editUser;
    data['edit_date'] = this.editDate;
    data['transtamp'] = this.transtamp;
    data['deleted'] = this.deleted;
    data['last_edited_by'] = this.lastEditedBy;
    data['created_by'] = this.createdBy;
    return data;
  }
}

// SaveBookingTest

class SaveBookingTestRequest {
  String wsCodeCrypt;
  String caUid;
  String caPwd;
  String diCode;
  String groupId;
  String testType;
  String testDate;
  String courseSection;
  String icNo;
  String userId;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
    data['diCode'] = this.diCode;
    data['groupId'] = this.groupId;
    data['testType'] = this.testType;
    data['testDate'] = this.testDate;
    data['courseSection'] = this.courseSection;
    data['icNo'] = this.icNo;
    data['userId'] = this.userId;
    return data;
  }
}

class GetJpjTestCheckInResponse {
  List<GetJpjTestTrn> jpjTestTrn;

  GetJpjTestCheckInResponse({this.jpjTestTrn});

  GetJpjTestCheckInResponse.fromJson(Map<String, dynamic> json) {
    if (json['JpjTestTrn'] != null) {
      jpjTestTrn = new List<GetJpjTestTrn>.empty(growable: true);
      json['JpjTestTrn'].forEach((v) {
        jpjTestTrn.add(new GetJpjTestTrn.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jpjTestTrn != null) {
      data['JpjTestTrn'] = this.jpjTestTrn.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetJpjTestTrn {
  String iD;
  String testDate;
  String courseCode;
  String groupId;
  String nricNo;
  String fullname;
  String sex;
  String race;
  String nationality;
  String birthDate;
  String add1;
  String add2;
  String add3;
  String postcode;
  String cityName;
  String stateName;
  String icPhoto;
  String queueNo;
  String regDate;
  String registerPhoto;
  String testCode;
  String startDate;
  String startTime;
  String endTime;
  String printed;
  String prnCount;
  String printLog;
  String createUser;
  String createDate;
  String editUser;
  String editDate;
  String transtamp;
  String lastupload;
  String compCode;
  String branchCode;
  String deleted;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['test_date'] = this.testDate;
    data['course_code'] = this.courseCode;
    data['group_id'] = this.groupId;
    data['nric_no'] = this.nricNo;
    data['fullname'] = this.fullname;
    data['sex'] = this.sex;
    data['race'] = this.race;
    data['nationality'] = this.nationality;
    data['birth_date'] = this.birthDate;
    data['add1'] = this.add1;
    data['add2'] = this.add2;
    data['add3'] = this.add3;
    data['postcode'] = this.postcode;
    data['city_name'] = this.cityName;
    data['state_name'] = this.stateName;
    data['ic_photo'] = this.icPhoto;
    data['queue_no'] = this.queueNo;
    data['reg_date'] = this.regDate;
    data['register_photo'] = this.registerPhoto;
    data['test_code'] = this.testCode;
    data['start_date'] = this.startDate;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['printed'] = this.printed;
    data['prn_count'] = this.prnCount;
    data['print_log'] = this.printLog;
    data['create_user'] = this.createUser;
    data['create_date'] = this.createDate;
    data['edit_user'] = this.editUser;
    data['edit_date'] = this.editDate;
    data['transtamp'] = this.transtamp;
    data['lastupload'] = this.lastupload;
    data['comp_code'] = this.compCode;
    data['branch_code'] = this.branchCode;
    data['deleted'] = this.deleted;
    return data;
  }
}

class GetLastJpjTestCheckInByIntervalResponse {
  List<GetJpjTestTrnByInterval> jpjTestTrn;

  GetLastJpjTestCheckInByIntervalResponse({this.jpjTestTrn});

  GetLastJpjTestCheckInByIntervalResponse.fromJson(Map<String, dynamic> json) {
    if (json['JpjTestTrn'] != null) {
      jpjTestTrn = new List<GetJpjTestTrnByInterval>.empty(growable: true);
      json['JpjTestTrn'].forEach((v) {
        jpjTestTrn.add(new GetJpjTestTrnByInterval.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jpjTestTrn != null) {
      data['JpjTestTrn'] = this.jpjTestTrn.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetJpjTestTrnByInterval {
  String iD;
  String testDate;
  String courseCode;
  String groupId;
  String nricNo;
  String fullname;
  String sex;
  String race;
  String nationality;
  String birthDate;
  String add1;
  String add2;
  String add3;
  String postcode;
  String cityName;
  String stateName;
  String icPhoto;
  String queueNo;
  String regDate;
  String registerPhoto;
  String testCode;
  String startDate;
  String startTime;
  String endTime;
  String printed;
  String prnCount;
  String printLog;
  String createUser;
  String createDate;
  String editUser;
  String editDate;
  String transtamp;
  String lastupload;
  String compCode;
  String branchCode;
  String deleted;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['test_date'] = this.testDate;
    data['course_code'] = this.courseCode;
    data['group_id'] = this.groupId;
    data['nric_no'] = this.nricNo;
    data['fullname'] = this.fullname;
    data['sex'] = this.sex;
    data['race'] = this.race;
    data['nationality'] = this.nationality;
    data['birth_date'] = this.birthDate;
    data['add1'] = this.add1;
    data['add2'] = this.add2;
    data['add3'] = this.add3;
    data['postcode'] = this.postcode;
    data['city_name'] = this.cityName;
    data['state_name'] = this.stateName;
    data['ic_photo'] = this.icPhoto;
    data['queue_no'] = this.queueNo;
    data['reg_date'] = this.regDate;
    data['register_photo'] = this.registerPhoto;
    data['test_code'] = this.testCode;
    data['start_date'] = this.startDate;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['printed'] = this.printed;
    data['prn_count'] = this.prnCount;
    data['print_log'] = this.printLog;
    data['create_user'] = this.createUser;
    data['create_date'] = this.createDate;
    data['edit_user'] = this.editUser;
    data['edit_date'] = this.editDate;
    data['transtamp'] = this.transtamp;
    data['lastupload'] = this.lastupload;
    data['comp_code'] = this.compCode;
    data['branch_code'] = this.branchCode;
    data['deleted'] = this.deleted;
    return data;
  }
}

class VerifyScanCodeRequest {
  String wsCodeCrypt;
  String caUid;
  String caPwd;
  String icNo;
  String diCode;
  String userId;
  String qrcodeJson;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
    data['icNo'] = this.icNo;
    data['diCode'] = this.diCode;
    data['userId'] = this.userId;
    data['qrcodeJson'] = this.qrcodeJson;
    return data;
  }
}

class VerifyScanCodeResponse {
  List<JpjTestTrn> jpjTestTrn;

  VerifyScanCodeResponse({this.jpjTestTrn});

  VerifyScanCodeResponse.fromJson(Map<String, dynamic> json) {
    if (json['JpjTestTrn'] != null) {
      jpjTestTrn = new List<JpjTestTrn>();
      json['JpjTestTrn'].forEach((v) {
        jpjTestTrn.add(new JpjTestTrn.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jpjTestTrn != null) {
      data['JpjTestTrn'] = this.jpjTestTrn.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JpjTestTrn {
  String iD;
  String testDate;
  String courseCode;
  String groupId;
  String nricNo;
  String fullname;
  String sex;
  String race;
  String nationality;
  String birthDate;
  String add1;
  String add2;
  String add3;
  String postcode;
  String cityName;
  String stateName;
  String icPhoto;
  String queueNo;
  String regDate;
  String registerPhoto;
  String testCode;
  String startDate;
  String startTime;
  String endTime;
  String printed;
  String prnCount;
  String printLog;
  String createUser;
  String createDate;
  String editUser;
  String editDate;
  String transtamp;
  String lastupload;
  String compCode;
  String branchCode;
  String deleted;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['test_date'] = this.testDate;
    data['course_code'] = this.courseCode;
    data['group_id'] = this.groupId;
    data['nric_no'] = this.nricNo;
    data['fullname'] = this.fullname;
    data['sex'] = this.sex;
    data['race'] = this.race;
    data['nationality'] = this.nationality;
    data['birth_date'] = this.birthDate;
    data['add1'] = this.add1;
    data['add2'] = this.add2;
    data['add3'] = this.add3;
    data['postcode'] = this.postcode;
    data['city_name'] = this.cityName;
    data['state_name'] = this.stateName;
    data['ic_photo'] = this.icPhoto;
    data['queue_no'] = this.queueNo;
    data['reg_date'] = this.regDate;
    data['register_photo'] = this.registerPhoto;
    data['test_code'] = this.testCode;
    data['start_date'] = this.startDate;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['printed'] = this.printed;
    data['prn_count'] = this.prnCount;
    data['print_log'] = this.printLog;
    data['create_user'] = this.createUser;
    data['create_date'] = this.createDate;
    data['edit_user'] = this.editUser;
    data['edit_date'] = this.editDate;
    data['transtamp'] = this.transtamp;
    data['lastupload'] = this.lastupload;
    data['comp_code'] = this.compCode;
    data['branch_code'] = this.branchCode;
    data['deleted'] = this.deleted;
    return data;
  }
}

class GetScanCodeByActionRequest {
  String wsCodeCrypt;
  String caUid;
  String caPwd;
  String icNo;
  String diCode;
  String userId;
  String action;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
    data['icNo'] = this.icNo;
    data['diCode'] = this.diCode;
    data['userId'] = this.userId;
    data['action'] = this.action;
    return data;
  }
}

class GetScanCodeByActionResponse {
  List<Table1> table1;

  GetScanCodeByActionResponse({this.table1});

  GetScanCodeByActionResponse.fromJson(Map<String, dynamic> json) {
    if (json['Table1'] != null) {
      table1 = new List<Table1>.empty(growable: true);
      json['Table1'].forEach((v) {
        table1.add(new Table1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.table1 != null) {
      data['Table1'] = this.table1.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Table1 {
  String merchantNo;
  String action;
  String datetime;

  Table1({this.merchantNo, this.action, this.datetime});

  Table1.fromJson(Map<String, dynamic> json) {
    merchantNo = json['merchant_no'];
    action = json['action'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['merchant_no'] = this.merchantNo;
    data['action'] = this.action;
    data['datetime'] = this.datetime;
    return data;
  }
}

class GetLastCallingJpjTestQueueNumberResponse {
  List<LastCallingQueueJpjTestTrn> jpjTestTrn;

  GetLastCallingJpjTestQueueNumberResponse({this.jpjTestTrn});

  GetLastCallingJpjTestQueueNumberResponse.fromJson(Map<String, dynamic> json) {
    if (json['JpjTestTrn'] != null) {
      jpjTestTrn = new List<LastCallingQueueJpjTestTrn>();
      json['JpjTestTrn'].forEach((v) {
        jpjTestTrn.add(new LastCallingQueueJpjTestTrn.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jpjTestTrn != null) {
      data['JpjTestTrn'] = this.jpjTestTrn.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LastCallingQueueJpjTestTrn {
  String iD;
  String testDate;
  String courseCode;
  String groupId;
  String nricNo;
  String fullname;
  String sex;
  String race;
  String nationality;
  String birthDate;
  String add1;
  String add2;
  String add3;
  String postcode;
  String cityName;
  String stateName;
  String icPhoto;
  String queueNo;
  String regDate;
  String registerPhoto;
  String testCode;
  String startDate;
  String startTime;
  String endTime;
  String printed;
  String prnCount;
  String printLog;
  String createUser;
  String createDate;
  String editUser;
  String editDate;
  String transtamp;
  String lastupload;
  String compCode;
  String branchCode;
  String deleted;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['test_date'] = this.testDate;
    data['course_code'] = this.courseCode;
    data['group_id'] = this.groupId;
    data['nric_no'] = this.nricNo;
    data['fullname'] = this.fullname;
    data['sex'] = this.sex;
    data['race'] = this.race;
    data['nationality'] = this.nationality;
    data['birth_date'] = this.birthDate;
    data['add1'] = this.add1;
    data['add2'] = this.add2;
    data['add3'] = this.add3;
    data['postcode'] = this.postcode;
    data['city_name'] = this.cityName;
    data['state_name'] = this.stateName;
    data['ic_photo'] = this.icPhoto;
    data['queue_no'] = this.queueNo;
    data['reg_date'] = this.regDate;
    data['register_photo'] = this.registerPhoto;
    data['test_code'] = this.testCode;
    data['start_date'] = this.startDate;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['printed'] = this.printed;
    data['prn_count'] = this.prnCount;
    data['print_log'] = this.printLog;
    data['create_user'] = this.createUser;
    data['create_date'] = this.createDate;
    data['edit_user'] = this.editUser;
    data['edit_date'] = this.editDate;
    data['transtamp'] = this.transtamp;
    data['lastupload'] = this.lastupload;
    data['comp_code'] = this.compCode;
    data['branch_code'] = this.branchCode;
    data['deleted'] = this.deleted;
    return data;
  }
}
