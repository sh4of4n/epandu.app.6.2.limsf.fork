class GetEnrollmentRequest {
  String wsCodeCrypt;
  String caUid;
  String caPwd;
  String diCode;
  String icNo;
  String groupId;

  GetEnrollmentRequest(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
      this.diCode,
      this.icNo,
      this.groupId});

  GetEnrollmentRequest.fromJson(Map<String, String> json) {
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

class GetEnrollmentResponse {
  List<Enroll> enroll;

  GetEnrollmentResponse({this.enroll});

  GetEnrollmentResponse.fromJson(Map<String, dynamic> json) {
    if (json['Enroll'] != null) {
      enroll = new List<Enroll>();
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
      stuPrac = new List<StuPrac>();
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
class StudentPaymentRequest {
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
}

class StudentPaymentResponse {
  List<CollectTrn> collectTrn;

  StudentPaymentResponse({this.collectTrn});

  StudentPaymentResponse.fromJson(Map<String, dynamic> json) {
    if (json['CollectTrn'] != null) {
      collectTrn = new List<CollectTrn>();
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
  String sName;
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
  String cashAmount;
  String chqAmount;
  String ccAmount;
  String crdType;
  String payRefno;
  String balAmount;
  String tlTaxAmt;
  String cancelUser;
  String cancelOn;
  String cancel;
  String batchNo;
  String transtamp;
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

  CollectTrn(
      {this.jobNo,
      this.recpNo,
      this.serialType,
      this.trandate,
      this.trantime,
      this.vehNo,
      this.icNo,
      this.sName,
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
      this.cashAmount,
      this.chqAmount,
      this.ccAmount,
      this.crdType,
      this.payRefno,
      this.balAmount,
      this.tlTaxAmt,
      this.cancelUser,
      this.cancelOn,
      this.cancel,
      this.batchNo,
      this.transtamp,
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
      this.diCode});

  CollectTrn.fromJson(Map<String, dynamic> json) {
    jobNo = json['job_no'];
    recpNo = json['recp_no'];
    serialType = json['serial_type'];
    trandate = json['trandate'];
    trantime = json['trantime'];
    vehNo = json['veh_no'];
    icNo = json['ic_no'];
    sName = json['__name'];
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
    cashAmount = json['cash_amount'];
    chqAmount = json['chq_amount'];
    ccAmount = json['cc_amount'];
    crdType = json['crd_type'];
    payRefno = json['pay_refno'];
    balAmount = json['bal_amount'];
    tlTaxAmt = json['tl_tax_amt'];
    cancelUser = json['cancel_user'];
    cancelOn = json['cancel_on'];
    cancel = json['cancel'];
    batchNo = json['batch_no'];
    transtamp = json['transtamp'];
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
    data['__name'] = this.sName;
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
    data['cash_amount'] = this.cashAmount;
    data['chq_amount'] = this.chqAmount;
    data['cc_amount'] = this.ccAmount;
    data['crd_type'] = this.crdType;
    data['pay_refno'] = this.payRefno;
    data['bal_amount'] = this.balAmount;
    data['tl_tax_amt'] = this.tlTaxAmt;
    data['cancel_user'] = this.cancelUser;
    data['cancel_on'] = this.cancelOn;
    data['cancel'] = this.cancel;
    data['batch_no'] = this.batchNo;
    data['transtamp'] = this.transtamp;
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
    return data;
  }
}

// get student attendance
class StudentAttendanceRequest {
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
}

class StudentAttendanceResponse {
  List<DTest> dTest;

  StudentAttendanceResponse({this.dTest});

  StudentAttendanceResponse.fromJson(Map<String, dynamic> json) {
    if (json['DTest'] != null) {
      dTest = new List<DTest>();
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
  String pRemark;
  String pAmount;
  String sesi;
  String testLoc;
  String apprvBooking;
  String compCode;
  String branchCode;
  String lastupload;
  String deleted;
  String diCode;

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
      this.pRemark,
      this.pAmount,
      this.sesi,
      this.testLoc,
      this.apprvBooking,
      this.compCode,
      this.branchCode,
      this.lastupload,
      this.deleted,
      this.diCode});

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
    pRemark = json['p_remark'];
    pAmount = json['p_amount'];
    sesi = json['sesi'];
    testLoc = json['test_loc'];
    apprvBooking = json['apprv_booking'];
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
    data['p_remark'] = this.pRemark;
    data['p_amount'] = this.pAmount;
    data['sesi'] = this.sesi;
    data['test_loc'] = this.testLoc;
    data['apprv_booking'] = this.apprvBooking;
    data['comp_code'] = this.compCode;
    data['branch_code'] = this.branchCode;
    data['lastupload'] = this.lastupload;
    data['deleted'] = this.deleted;
    data['di_code'] = this.diCode;
    return data;
  }
}
