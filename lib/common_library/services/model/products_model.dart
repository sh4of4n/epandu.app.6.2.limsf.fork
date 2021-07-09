// GetCategory

class GetCategoryResponse {
  List<StkCat>? stkCat;

  GetCategoryResponse({this.stkCat});

  GetCategoryResponse.fromJson(Map<String, dynamic> json) {
    if (json['StkCat'] != null) {
      stkCat = new List<StkCat>.empty(growable: true);
      json['StkCat'].forEach((v) {
        stkCat!.add(new StkCat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stkCat != null) {
      data['StkCat'] = this.stkCat!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StkCat {
  String? iD;
  String? stkCat;
  String? catDesc;
  String? nonGst;
  String? purchaseTaxCode;
  String? supplyTaxCode;
  String? priceIncludeGst;
  String? deleted;
  String? publish;
  String? createUser;
  String? createDate;
  String? editUser;
  String? editDate;
  String? rowKey;
  String? transtamp;
  String? crdSlsAcct;
  String? crdSlsDept;
  String? cshSlsAcct;
  String? cshSlsDept;
  String? crdPurcAcct;
  String? crdPurcDept;
  String? openPos;
  String? openPosType;
  String? picturePath;
  String? sGst;
  String? triggerCode;
  String? tariffCode;
  String? zoneCode;
  String? subjectSlsTax;
  String? cshPurcAcct;
  String? cshPurcDept;
  String? crdSlsAc;
  String? crdSlsDp;
  String? cshSlsAc;
  String? cshSlsDp;
  String? crdPurcAc;
  String? crdPurcDp;
  String? cshPurcAc;
  String? cshPurcDp;
  String? compCode;
  String? branchCode;
  String? lastupload;
  String? duplicateKey;
  String? validateFailed;
  String? lastEditedBy;
  String? createdBy;

  StkCat(
      {this.iD,
      this.stkCat,
      this.catDesc,
      this.nonGst,
      this.purchaseTaxCode,
      this.supplyTaxCode,
      this.priceIncludeGst,
      this.deleted,
      this.publish,
      this.createUser,
      this.createDate,
      this.editUser,
      this.editDate,
      this.rowKey,
      this.transtamp,
      this.crdSlsAcct,
      this.crdSlsDept,
      this.cshSlsAcct,
      this.cshSlsDept,
      this.crdPurcAcct,
      this.crdPurcDept,
      this.openPos,
      this.openPosType,
      this.picturePath,
      this.sGst,
      this.triggerCode,
      this.tariffCode,
      this.zoneCode,
      this.subjectSlsTax,
      this.cshPurcAcct,
      this.cshPurcDept,
      this.crdSlsAc,
      this.crdSlsDp,
      this.cshSlsAc,
      this.cshSlsDp,
      this.crdPurcAc,
      this.crdPurcDp,
      this.cshPurcAc,
      this.cshPurcDp,
      this.compCode,
      this.branchCode,
      this.lastupload,
      this.duplicateKey,
      this.validateFailed,
      this.lastEditedBy,
      this.createdBy});

  StkCat.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    stkCat = json['stk_cat'];
    catDesc = json['cat_desc'];
    nonGst = json['non_gst'];
    purchaseTaxCode = json['purchase_tax_code'];
    supplyTaxCode = json['supply_tax_code'];
    priceIncludeGst = json['price_include_gst'];
    deleted = json['deleted'];
    publish = json['publish'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    rowKey = json['row_key'];
    transtamp = json['transtamp'];
    crdSlsAcct = json['crd_sls_acct'];
    crdSlsDept = json['crd_sls_dept'];
    cshSlsAcct = json['csh_sls_acct'];
    cshSlsDept = json['csh_sls_dept'];
    crdPurcAcct = json['crd_purc_acct'];
    crdPurcDept = json['crd_purc_dept'];
    openPos = json['open_pos'];
    openPosType = json['open_pos_type'];
    picturePath = json['picture_path'];
    sGst = json['__gst'];
    triggerCode = json['trigger_code'];
    tariffCode = json['tariff_code'];
    zoneCode = json['zone_code'];
    subjectSlsTax = json['subject_sls_tax'];
    cshPurcAcct = json['csh_purc_acct'];
    cshPurcDept = json['csh_purc_dept'];
    crdSlsAc = json['crd_sls_ac'];
    crdSlsDp = json['crd_sls_dp'];
    cshSlsAc = json['csh_sls_ac'];
    cshSlsDp = json['csh_sls_dp'];
    crdPurcAc = json['crd_purc_ac'];
    crdPurcDp = json['crd_purc_dp'];
    cshPurcAc = json['csh_purc_ac'];
    cshPurcDp = json['csh_purc_dp'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    lastupload = json['lastupload'];
    duplicateKey = json['duplicate_key'];
    validateFailed = json['validate_failed'];
    lastEditedBy = json['last_edited_by'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['stk_cat'] = this.stkCat;
    data['cat_desc'] = this.catDesc;
    data['non_gst'] = this.nonGst;
    data['purchase_tax_code'] = this.purchaseTaxCode;
    data['supply_tax_code'] = this.supplyTaxCode;
    data['price_include_gst'] = this.priceIncludeGst;
    data['deleted'] = this.deleted;
    data['publish'] = this.publish;
    data['create_user'] = this.createUser;
    data['create_date'] = this.createDate;
    data['edit_user'] = this.editUser;
    data['edit_date'] = this.editDate;
    data['row_key'] = this.rowKey;
    data['transtamp'] = this.transtamp;
    data['crd_sls_acct'] = this.crdSlsAcct;
    data['crd_sls_dept'] = this.crdSlsDept;
    data['csh_sls_acct'] = this.cshSlsAcct;
    data['csh_sls_dept'] = this.cshSlsDept;
    data['crd_purc_acct'] = this.crdPurcAcct;
    data['crd_purc_dept'] = this.crdPurcDept;
    data['open_pos'] = this.openPos;
    data['open_pos_type'] = this.openPosType;
    data['picture_path'] = this.picturePath;
    data['__gst'] = this.sGst;
    data['trigger_code'] = this.triggerCode;
    data['tariff_code'] = this.tariffCode;
    data['zone_code'] = this.zoneCode;
    data['subject_sls_tax'] = this.subjectSlsTax;
    data['csh_purc_acct'] = this.cshPurcAcct;
    data['csh_purc_dept'] = this.cshPurcDept;
    data['crd_sls_ac'] = this.crdSlsAc;
    data['crd_sls_dp'] = this.crdSlsDp;
    data['csh_sls_ac'] = this.cshSlsAc;
    data['csh_sls_dp'] = this.cshSlsDp;
    data['crd_purc_ac'] = this.crdPurcAc;
    data['crd_purc_dp'] = this.crdPurcDp;
    data['csh_purc_ac'] = this.cshPurcAc;
    data['csh_purc_dp'] = this.cshPurcDp;
    data['comp_code'] = this.compCode;
    data['branch_code'] = this.branchCode;
    data['lastupload'] = this.lastupload;
    data['duplicate_key'] = this.duplicateKey;
    data['validate_failed'] = this.validateFailed;
    data['last_edited_by'] = this.lastEditedBy;
    data['created_by'] = this.createdBy;
    return data;
  }
}

// GetStock
class GetStockResponse {
  List<Stkmst>? stkmst;

  GetStockResponse({this.stkmst});

  GetStockResponse.fromJson(Map<String, dynamic> json) {
    if (json['Stkmst'] != null) {
      stkmst = new List<Stkmst>.empty(growable: true);
      json['Stkmst'].forEach((v) {
        stkmst!.add(new Stkmst.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stkmst != null) {
      data['Stkmst'] = this.stkmst!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stkmst {
  String? iD;
  String? stkCode;
  String? stkDesc1;
  String? stkDesc2;
  String? shortDesc;
  String? shortDesc2;
  String? partNo;
  String? stkCat;
  String? stkGrp;
  String? transportType;
  String? brandCode;
  String? gradeCode;
  String? menuNo;
  String? intCode;
  String? extCode;
  String? extCode1;
  String? extCode2;
  String? extCode3;
  String? uom;
  String? dualUom;
  String? uom2;
  String? qtyUom2;
  String? trnType;
  String? fgOrRaw;
  String? deductRm;
  String? nonActive;
  String? publish;
  String? binNo;
  String? uploadItm;
  String? openPos;
  String? nonGst;
  String? purchaseTaxCode;
  String? supplyTaxCode;
  String? priceIncludeGst;
  String? controlSn;
  String? snDoc;
  String? useBatch;
  String? ctrlBatchPrice;
  String? batchDoc;
  String? qcCheck;
  String? gstByMargin;
  String? labelFile;
  String? labelSetting;
  String? flexiUom;
  String? updateBom;
  String? warperiod;
  String? warMthyr;
  String? currency;
  String? dbcode;
  String? crcode;
  String? price1;
  String? price2;
  String? price3;
  String? price4;
  String? price5;
  String? price6;
  String? minprice1;
  String? minprice2;
  String? minprice3;
  String? minprice4;
  String? minprice5;
  String? minprice6;
  String? cost1;
  String? cost2;
  String? cost3;
  String? cost4;
  String? cost5;
  String? cost6;
  String? maxQty;
  String? minQty;
  String? minOrQty;
  String? roLevel;
  String? fillupLevel;
  String? roQty;
  String? roUom;
  String? lIsPrice;
  String? lInCost;
  String? lInPrice;
  String? lActCost;
  String? amtSign;
  String? scomRate;
  String? scomAmt;
  String? subjectSlsTax;
  String? stkMisc1;
  String? stkMisc2;
  String? stkMisc3;
  String? stkMisc4;
  String? stkMisc5;
  String? stkMisc6;
  String? stkMisc7;
  String? stkMisc8;
  String? stkMisc9;
  String? stkMisc10;
  String? stkMisc11;
  String? stkMisc12;
  String? stkMisc13;
  String? stkMisc14;
  String? stkMisc15;
  String? stkMisc16;
  String? stkMisc17;
  String? stkMisc18;
  String? stkMisc19;
  String? stkMisc20;
  String? stkFormula;
  String? piFormula;
  String? autoassbly;
  String? pointEarn;
  String? pointUsed;
  String? stkpicturePath;
  String? costFactr;
  String? codetariff;
  String? codetariffDesc;
  String? drawingNo;
  String? engineerDrawNo;
  String? engineerApprvBy;
  String? grossWeight;
  String? grossWeightUom;
  String? netWeight;
  String? netWeightUom;
  String? m3;
  String? stkThickness;
  String? stkThicknessUom;
  String? stkWidth;
  String? stkWidthUom;
  String? stkLength;
  String? stkLengthUom;
  String? tlnpct;
  String? tlnqty;
  String? tlnstatus;
  String? useMatrix;
  String? multiDisc;
  String? serTax;
  String? salesTax;
  String? saleAcct;
  String? saleDept;
  String? sdiscAcct;
  String? sdiscDept;
  String? purcAcct;
  String? purcDept;
  String? pdiscAcct;
  String? pdiscDept;
  String? toGlAcct;
  String? toGlDept;
  String? remark;
  String? ytdQty;
  String? unpostqty;
  String? ytdQtyord;
  String? ytdQtyresv;
  String? ytdPQty;
  String? ytdSQty;
  String? ytdavrcost;
  String? deleted;
  String? createUser;
  String? createDate;
  String? editUser;
  String? compCode;
  String? branchCode;
  String? rowKey;
  String? transtamp;
  String? editDate;
  String? sampleNo;
  String? version;
  String? docRef;
  String? stkKey;
  String? verify;
  String? qaSpec;
  String? slsMinOrQty;
  String? sMatrix1;
  String? sMatrix2;
  String? sMatrix3;
  String? sLocCode;
  String? sBatchNo;
  String? sBatchKey;
  String? sBatchQty;
  String? openPosType;
  String? sGst;
  String? triggerCode;
  String? unitPrice;
  String? lastupload;
  String? duplicateKey;
  String? validateFailed;
  String? validateRemark;
  String? lastValidate;
  String? lastEditedBy;
  String? createdBy;
  String? catDesc;
  String? grpDesc;
  String? stkqtyYtdQty;
  String? stkqtyYtdQtyresv;
  String? stkqtyYtdAvailableQty;
  String? lInCost1;
  String? lInDate1;
  String? lIsDate1;
  String? lIsPrice1;
  String? discRate;
  String? stkpriceUnitPrice;
  String? minUnitPrice;
  String? custSellPrice;
  String? custMinSellPrice;
  String? rmdCustLabelPrice;
  String? labelPrice;
  String? stkuom;
  String? specDiscRate;
  String? specUnitPrice;
  String? specNettPrice;
  String? effectiveDate;

  Stkmst(
      {this.iD,
      this.stkCode,
      this.stkDesc1,
      this.stkDesc2,
      this.shortDesc,
      this.shortDesc2,
      this.partNo,
      this.stkCat,
      this.stkGrp,
      this.transportType,
      this.brandCode,
      this.gradeCode,
      this.menuNo,
      this.intCode,
      this.extCode,
      this.extCode1,
      this.extCode2,
      this.extCode3,
      this.uom,
      this.dualUom,
      this.uom2,
      this.qtyUom2,
      this.trnType,
      this.fgOrRaw,
      this.deductRm,
      this.nonActive,
      this.publish,
      this.binNo,
      this.uploadItm,
      this.openPos,
      this.nonGst,
      this.purchaseTaxCode,
      this.supplyTaxCode,
      this.priceIncludeGst,
      this.controlSn,
      this.snDoc,
      this.useBatch,
      this.ctrlBatchPrice,
      this.batchDoc,
      this.qcCheck,
      this.gstByMargin,
      this.labelFile,
      this.labelSetting,
      this.flexiUom,
      this.updateBom,
      this.warperiod,
      this.warMthyr,
      this.currency,
      this.dbcode,
      this.crcode,
      this.price1,
      this.price2,
      this.price3,
      this.price4,
      this.price5,
      this.price6,
      this.minprice1,
      this.minprice2,
      this.minprice3,
      this.minprice4,
      this.minprice5,
      this.minprice6,
      this.cost1,
      this.cost2,
      this.cost3,
      this.cost4,
      this.cost5,
      this.cost6,
      this.maxQty,
      this.minQty,
      this.minOrQty,
      this.roLevel,
      this.fillupLevel,
      this.roQty,
      this.roUom,
      this.lIsPrice,
      this.lInCost,
      this.lInPrice,
      this.lActCost,
      this.amtSign,
      this.scomRate,
      this.scomAmt,
      this.subjectSlsTax,
      this.stkMisc1,
      this.stkMisc2,
      this.stkMisc3,
      this.stkMisc4,
      this.stkMisc5,
      this.stkMisc6,
      this.stkMisc7,
      this.stkMisc8,
      this.stkMisc9,
      this.stkMisc10,
      this.stkMisc11,
      this.stkMisc12,
      this.stkMisc13,
      this.stkMisc14,
      this.stkMisc15,
      this.stkMisc16,
      this.stkMisc17,
      this.stkMisc18,
      this.stkMisc19,
      this.stkMisc20,
      this.stkFormula,
      this.piFormula,
      this.autoassbly,
      this.pointEarn,
      this.pointUsed,
      this.stkpicturePath,
      this.costFactr,
      this.codetariff,
      this.codetariffDesc,
      this.drawingNo,
      this.engineerDrawNo,
      this.engineerApprvBy,
      this.grossWeight,
      this.grossWeightUom,
      this.netWeight,
      this.netWeightUom,
      this.m3,
      this.stkThickness,
      this.stkThicknessUom,
      this.stkWidth,
      this.stkWidthUom,
      this.stkLength,
      this.stkLengthUom,
      this.tlnpct,
      this.tlnqty,
      this.tlnstatus,
      this.useMatrix,
      this.multiDisc,
      this.serTax,
      this.salesTax,
      this.saleAcct,
      this.saleDept,
      this.sdiscAcct,
      this.sdiscDept,
      this.purcAcct,
      this.purcDept,
      this.pdiscAcct,
      this.pdiscDept,
      this.toGlAcct,
      this.toGlDept,
      this.remark,
      this.ytdQty,
      this.unpostqty,
      this.ytdQtyord,
      this.ytdQtyresv,
      this.ytdPQty,
      this.ytdSQty,
      this.ytdavrcost,
      this.deleted,
      this.createUser,
      this.createDate,
      this.editUser,
      this.compCode,
      this.branchCode,
      this.rowKey,
      this.transtamp,
      this.editDate,
      this.sampleNo,
      this.version,
      this.docRef,
      this.stkKey,
      this.verify,
      this.qaSpec,
      this.slsMinOrQty,
      this.sMatrix1,
      this.sMatrix2,
      this.sMatrix3,
      this.sLocCode,
      this.sBatchNo,
      this.sBatchKey,
      this.sBatchQty,
      this.openPosType,
      this.sGst,
      this.triggerCode,
      this.unitPrice,
      this.lastupload,
      this.duplicateKey,
      this.validateFailed,
      this.validateRemark,
      this.lastValidate,
      this.lastEditedBy,
      this.createdBy,
      this.catDesc,
      this.grpDesc,
      this.stkqtyYtdQty,
      this.stkqtyYtdQtyresv,
      this.stkqtyYtdAvailableQty,
      this.lInCost1,
      this.lInDate1,
      this.lIsDate1,
      this.lIsPrice1,
      this.discRate,
      this.stkpriceUnitPrice,
      this.minUnitPrice,
      this.custSellPrice,
      this.custMinSellPrice,
      this.rmdCustLabelPrice,
      this.labelPrice,
      this.stkuom,
      this.specDiscRate,
      this.specUnitPrice,
      this.specNettPrice,
      this.effectiveDate});

  Stkmst.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    stkCode = json['stk_code'];
    stkDesc1 = json['stk_desc1'];
    stkDesc2 = json['stk_desc2'];
    shortDesc = json['short_desc'];
    shortDesc2 = json['short_desc2'];
    partNo = json['part_no'];
    stkCat = json['stk_cat'];
    stkGrp = json['stk_grp'];
    transportType = json['transport_type'];
    brandCode = json['brand_code'];
    gradeCode = json['grade_code'];
    menuNo = json['menu_no'];
    intCode = json['int_code'];
    extCode = json['ext_code'];
    extCode1 = json['ext_code1'];
    extCode2 = json['ext_code2'];
    extCode3 = json['ext_code3'];
    uom = json['uom'];
    dualUom = json['dual_uom'];
    uom2 = json['uom2'];
    qtyUom2 = json['qty_uom2'];
    trnType = json['trn_type'];
    fgOrRaw = json['fg_or_raw'];
    deductRm = json['deduct_rm'];
    nonActive = json['non_active'];
    publish = json['publish'];
    binNo = json['bin_no'];
    uploadItm = json['upload_itm'];
    openPos = json['open_pos'];
    nonGst = json['non_gst'];
    purchaseTaxCode = json['purchase_tax_code'];
    supplyTaxCode = json['supply_tax_code'];
    priceIncludeGst = json['price_include_gst'];
    controlSn = json['control_sn'];
    snDoc = json['sn_doc'];
    useBatch = json['use_batch'];
    ctrlBatchPrice = json['ctrl_batch_price'];
    batchDoc = json['batch_doc'];
    qcCheck = json['qc_check'];
    gstByMargin = json['gst_by_margin'];
    labelFile = json['label_file'];
    labelSetting = json['label_setting'];
    flexiUom = json['flexi_uom'];
    updateBom = json['update_bom'];
    warperiod = json['warperiod'];
    warMthyr = json['war_mthyr'];
    currency = json['currency'];
    dbcode = json['dbcode'];
    crcode = json['crcode'];
    price1 = json['price_1'];
    price2 = json['price_2'];
    price3 = json['price_3'];
    price4 = json['price_4'];
    price5 = json['price_5'];
    price6 = json['price_6'];
    minprice1 = json['minprice_1'];
    minprice2 = json['minprice_2'];
    minprice3 = json['minprice_3'];
    minprice4 = json['minprice_4'];
    minprice5 = json['minprice_5'];
    minprice6 = json['minprice_6'];
    cost1 = json['cost_1'];
    cost2 = json['cost_2'];
    cost3 = json['cost_3'];
    cost4 = json['cost_4'];
    cost5 = json['cost_5'];
    cost6 = json['cost_6'];
    maxQty = json['max_qty'];
    minQty = json['min_qty'];
    minOrQty = json['min_or_qty'];
    roLevel = json['ro_level'];
    fillupLevel = json['fillup_level'];
    roQty = json['ro_qty'];
    roUom = json['ro_uom'];
    lIsPrice = json['l_is_price'];
    lInCost = json['l_in_cost'];
    lInPrice = json['l_in_price'];
    lActCost = json['l_act_cost'];
    amtSign = json['amt_sign'];
    scomRate = json['scom_rate'];
    scomAmt = json['scom_amt'];
    subjectSlsTax = json['subject_sls_tax'];
    stkMisc1 = json['stk_misc1'];
    stkMisc2 = json['stk_misc2'];
    stkMisc3 = json['stk_misc3'];
    stkMisc4 = json['stk_misc4'];
    stkMisc5 = json['stk_misc5'];
    stkMisc6 = json['stk_misc6'];
    stkMisc7 = json['stk_misc7'];
    stkMisc8 = json['stk_misc8'];
    stkMisc9 = json['stk_misc9'];
    stkMisc10 = json['stk_misc10'];
    stkMisc11 = json['stk_misc11'];
    stkMisc12 = json['stk_misc12'];
    stkMisc13 = json['stk_misc13'];
    stkMisc14 = json['stk_misc14'];
    stkMisc15 = json['stk_misc15'];
    stkMisc16 = json['stk_misc16'];
    stkMisc17 = json['stk_misc17'];
    stkMisc18 = json['stk_misc18'];
    stkMisc19 = json['stk_misc19'];
    stkMisc20 = json['stk_misc20'];
    stkFormula = json['stk_formula'];
    piFormula = json['pi_formula'];
    autoassbly = json['autoassbly'];
    pointEarn = json['point_earn'];
    pointUsed = json['point_used'];
    stkpicturePath = json['stkpicture_path'];
    costFactr = json['cost_factr'];
    codetariff = json['codetariff'];
    codetariffDesc = json['codetariff_desc'];
    drawingNo = json['drawing_no'];
    engineerDrawNo = json['engineer_draw_no'];
    engineerApprvBy = json['engineer_apprv_by'];
    grossWeight = json['gross_weight'];
    grossWeightUom = json['gross_weight_uom'];
    netWeight = json['net_weight'];
    netWeightUom = json['net_weight_uom'];
    m3 = json['m3'];
    stkThickness = json['stk_thickness'];
    stkThicknessUom = json['stk_thickness_uom'];
    stkWidth = json['stk_width'];
    stkWidthUom = json['stk_width_uom'];
    stkLength = json['stk_length'];
    stkLengthUom = json['stk_length_uom'];
    tlnpct = json['tlnpct'];
    tlnqty = json['tlnqty'];
    tlnstatus = json['tlnstatus'];
    useMatrix = json['use_matrix'];
    multiDisc = json['multi_disc'];
    serTax = json['ser_tax'];
    salesTax = json['sales_tax'];
    saleAcct = json['sale_acct'];
    saleDept = json['sale_dept'];
    sdiscAcct = json['sdisc_acct'];
    sdiscDept = json['sdisc_dept'];
    purcAcct = json['purc_acct'];
    purcDept = json['purc_dept'];
    pdiscAcct = json['pdisc_acct'];
    pdiscDept = json['pdisc_dept'];
    toGlAcct = json['to_gl_acct'];
    toGlDept = json['to_gl_dept'];
    remark = json['remark'];
    ytdQty = json['ytd_qty'];
    unpostqty = json['unpostqty'];
    ytdQtyord = json['ytd_qtyord'];
    ytdQtyresv = json['ytd_qtyresv'];
    ytdPQty = json['ytd_p_qty'];
    ytdSQty = json['ytd_s_qty'];
    ytdavrcost = json['ytdavrcost'];
    deleted = json['deleted'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    rowKey = json['row_key'];
    transtamp = json['transtamp'];
    editDate = json['edit_date'];
    sampleNo = json['sample_no'];
    version = json['version'];
    docRef = json['doc_ref'];
    stkKey = json['stk_key'];
    verify = json['verify'];
    qaSpec = json['qa_spec'];
    slsMinOrQty = json['sls_min_or_qty'];
    sMatrix1 = json['__matrix_1'];
    sMatrix2 = json['__matrix_2'];
    sMatrix3 = json['__matrix_3'];
    sLocCode = json['__loc_code'];
    sBatchNo = json['__batch_no'];
    sBatchKey = json['__batch_key'];
    sBatchQty = json['__batch_qty'];
    openPosType = json['open_pos_type'];
    sGst = json['__gst'];
    triggerCode = json['trigger_code'];
    unitPrice = json['unit_price'];
    lastupload = json['lastupload'];
    duplicateKey = json['duplicate_key'];
    validateFailed = json['validate_failed'];
    validateRemark = json['validate_remark'];
    lastValidate = json['last_validate'];
    lastEditedBy = json['last_edited_by'];
    createdBy = json['created_by'];
    catDesc = json['cat_desc'];
    grpDesc = json['grp_desc'];
    stkqtyYtdQty = json['stkqty_ytd_qty'];
    stkqtyYtdQtyresv = json['stkqty_ytd_qtyresv'];
    stkqtyYtdAvailableQty = json['stkqty_ytd_available_qty'];
    lInCost1 = json['l_in_cost1'];
    lInDate1 = json['l_in_date1'];
    lIsDate1 = json['l_is_date1'];
    lIsPrice1 = json['l_is_price1'];
    discRate = json['disc_rate'];
    stkpriceUnitPrice = json['stkprice_unit_price'];
    minUnitPrice = json['min_unit_price'];
    custSellPrice = json['cust_sell_price'];
    custMinSellPrice = json['cust_min_sell_price'];
    rmdCustLabelPrice = json['rmd_cust_label_price'];
    labelPrice = json['label_price'];
    stkuom = json['stkuom'];
    specDiscRate = json['spec_disc_rate'];
    specUnitPrice = json['spec_unit_price'];
    specNettPrice = json['spec_nett_price'];
    effectiveDate = json['effective_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['stk_code'] = this.stkCode;
    data['stk_desc1'] = this.stkDesc1;
    data['stk_desc2'] = this.stkDesc2;
    data['short_desc'] = this.shortDesc;
    data['short_desc2'] = this.shortDesc2;
    data['part_no'] = this.partNo;
    data['stk_cat'] = this.stkCat;
    data['stk_grp'] = this.stkGrp;
    data['transport_type'] = this.transportType;
    data['brand_code'] = this.brandCode;
    data['grade_code'] = this.gradeCode;
    data['menu_no'] = this.menuNo;
    data['int_code'] = this.intCode;
    data['ext_code'] = this.extCode;
    data['ext_code1'] = this.extCode1;
    data['ext_code2'] = this.extCode2;
    data['ext_code3'] = this.extCode3;
    data['uom'] = this.uom;
    data['dual_uom'] = this.dualUom;
    data['uom2'] = this.uom2;
    data['qty_uom2'] = this.qtyUom2;
    data['trn_type'] = this.trnType;
    data['fg_or_raw'] = this.fgOrRaw;
    data['deduct_rm'] = this.deductRm;
    data['non_active'] = this.nonActive;
    data['publish'] = this.publish;
    data['bin_no'] = this.binNo;
    data['upload_itm'] = this.uploadItm;
    data['open_pos'] = this.openPos;
    data['non_gst'] = this.nonGst;
    data['purchase_tax_code'] = this.purchaseTaxCode;
    data['supply_tax_code'] = this.supplyTaxCode;
    data['price_include_gst'] = this.priceIncludeGst;
    data['control_sn'] = this.controlSn;
    data['sn_doc'] = this.snDoc;
    data['use_batch'] = this.useBatch;
    data['ctrl_batch_price'] = this.ctrlBatchPrice;
    data['batch_doc'] = this.batchDoc;
    data['qc_check'] = this.qcCheck;
    data['gst_by_margin'] = this.gstByMargin;
    data['label_file'] = this.labelFile;
    data['label_setting'] = this.labelSetting;
    data['flexi_uom'] = this.flexiUom;
    data['update_bom'] = this.updateBom;
    data['warperiod'] = this.warperiod;
    data['war_mthyr'] = this.warMthyr;
    data['currency'] = this.currency;
    data['dbcode'] = this.dbcode;
    data['crcode'] = this.crcode;
    data['price_1'] = this.price1;
    data['price_2'] = this.price2;
    data['price_3'] = this.price3;
    data['price_4'] = this.price4;
    data['price_5'] = this.price5;
    data['price_6'] = this.price6;
    data['minprice_1'] = this.minprice1;
    data['minprice_2'] = this.minprice2;
    data['minprice_3'] = this.minprice3;
    data['minprice_4'] = this.minprice4;
    data['minprice_5'] = this.minprice5;
    data['minprice_6'] = this.minprice6;
    data['cost_1'] = this.cost1;
    data['cost_2'] = this.cost2;
    data['cost_3'] = this.cost3;
    data['cost_4'] = this.cost4;
    data['cost_5'] = this.cost5;
    data['cost_6'] = this.cost6;
    data['max_qty'] = this.maxQty;
    data['min_qty'] = this.minQty;
    data['min_or_qty'] = this.minOrQty;
    data['ro_level'] = this.roLevel;
    data['fillup_level'] = this.fillupLevel;
    data['ro_qty'] = this.roQty;
    data['ro_uom'] = this.roUom;
    data['l_is_price'] = this.lIsPrice;
    data['l_in_cost'] = this.lInCost;
    data['l_in_price'] = this.lInPrice;
    data['l_act_cost'] = this.lActCost;
    data['amt_sign'] = this.amtSign;
    data['scom_rate'] = this.scomRate;
    data['scom_amt'] = this.scomAmt;
    data['subject_sls_tax'] = this.subjectSlsTax;
    data['stk_misc1'] = this.stkMisc1;
    data['stk_misc2'] = this.stkMisc2;
    data['stk_misc3'] = this.stkMisc3;
    data['stk_misc4'] = this.stkMisc4;
    data['stk_misc5'] = this.stkMisc5;
    data['stk_misc6'] = this.stkMisc6;
    data['stk_misc7'] = this.stkMisc7;
    data['stk_misc8'] = this.stkMisc8;
    data['stk_misc9'] = this.stkMisc9;
    data['stk_misc10'] = this.stkMisc10;
    data['stk_misc11'] = this.stkMisc11;
    data['stk_misc12'] = this.stkMisc12;
    data['stk_misc13'] = this.stkMisc13;
    data['stk_misc14'] = this.stkMisc14;
    data['stk_misc15'] = this.stkMisc15;
    data['stk_misc16'] = this.stkMisc16;
    data['stk_misc17'] = this.stkMisc17;
    data['stk_misc18'] = this.stkMisc18;
    data['stk_misc19'] = this.stkMisc19;
    data['stk_misc20'] = this.stkMisc20;
    data['stk_formula'] = this.stkFormula;
    data['pi_formula'] = this.piFormula;
    data['autoassbly'] = this.autoassbly;
    data['point_earn'] = this.pointEarn;
    data['point_used'] = this.pointUsed;
    data['stkpicture_path'] = this.stkpicturePath;
    data['cost_factr'] = this.costFactr;
    data['codetariff'] = this.codetariff;
    data['codetariff_desc'] = this.codetariffDesc;
    data['drawing_no'] = this.drawingNo;
    data['engineer_draw_no'] = this.engineerDrawNo;
    data['engineer_apprv_by'] = this.engineerApprvBy;
    data['gross_weight'] = this.grossWeight;
    data['gross_weight_uom'] = this.grossWeightUom;
    data['net_weight'] = this.netWeight;
    data['net_weight_uom'] = this.netWeightUom;
    data['m3'] = this.m3;
    data['stk_thickness'] = this.stkThickness;
    data['stk_thickness_uom'] = this.stkThicknessUom;
    data['stk_width'] = this.stkWidth;
    data['stk_width_uom'] = this.stkWidthUom;
    data['stk_length'] = this.stkLength;
    data['stk_length_uom'] = this.stkLengthUom;
    data['tlnpct'] = this.tlnpct;
    data['tlnqty'] = this.tlnqty;
    data['tlnstatus'] = this.tlnstatus;
    data['use_matrix'] = this.useMatrix;
    data['multi_disc'] = this.multiDisc;
    data['ser_tax'] = this.serTax;
    data['sales_tax'] = this.salesTax;
    data['sale_acct'] = this.saleAcct;
    data['sale_dept'] = this.saleDept;
    data['sdisc_acct'] = this.sdiscAcct;
    data['sdisc_dept'] = this.sdiscDept;
    data['purc_acct'] = this.purcAcct;
    data['purc_dept'] = this.purcDept;
    data['pdisc_acct'] = this.pdiscAcct;
    data['pdisc_dept'] = this.pdiscDept;
    data['to_gl_acct'] = this.toGlAcct;
    data['to_gl_dept'] = this.toGlDept;
    data['remark'] = this.remark;
    data['ytd_qty'] = this.ytdQty;
    data['unpostqty'] = this.unpostqty;
    data['ytd_qtyord'] = this.ytdQtyord;
    data['ytd_qtyresv'] = this.ytdQtyresv;
    data['ytd_p_qty'] = this.ytdPQty;
    data['ytd_s_qty'] = this.ytdSQty;
    data['ytdavrcost'] = this.ytdavrcost;
    data['deleted'] = this.deleted;
    data['create_user'] = this.createUser;
    data['create_date'] = this.createDate;
    data['edit_user'] = this.editUser;
    data['comp_code'] = this.compCode;
    data['branch_code'] = this.branchCode;
    data['row_key'] = this.rowKey;
    data['transtamp'] = this.transtamp;
    data['edit_date'] = this.editDate;
    data['sample_no'] = this.sampleNo;
    data['version'] = this.version;
    data['doc_ref'] = this.docRef;
    data['stk_key'] = this.stkKey;
    data['verify'] = this.verify;
    data['qa_spec'] = this.qaSpec;
    data['sls_min_or_qty'] = this.slsMinOrQty;
    data['__matrix_1'] = this.sMatrix1;
    data['__matrix_2'] = this.sMatrix2;
    data['__matrix_3'] = this.sMatrix3;
    data['__loc_code'] = this.sLocCode;
    data['__batch_no'] = this.sBatchNo;
    data['__batch_key'] = this.sBatchKey;
    data['__batch_qty'] = this.sBatchQty;
    data['open_pos_type'] = this.openPosType;
    data['__gst'] = this.sGst;
    data['trigger_code'] = this.triggerCode;
    data['unit_price'] = this.unitPrice;
    data['lastupload'] = this.lastupload;
    data['duplicate_key'] = this.duplicateKey;
    data['validate_failed'] = this.validateFailed;
    data['validate_remark'] = this.validateRemark;
    data['last_validate'] = this.lastValidate;
    data['last_edited_by'] = this.lastEditedBy;
    data['created_by'] = this.createdBy;
    data['cat_desc'] = this.catDesc;
    data['grp_desc'] = this.grpDesc;
    data['stkqty_ytd_qty'] = this.stkqtyYtdQty;
    data['stkqty_ytd_qtyresv'] = this.stkqtyYtdQtyresv;
    data['stkqty_ytd_available_qty'] = this.stkqtyYtdAvailableQty;
    data['l_in_cost1'] = this.lInCost1;
    data['l_in_date1'] = this.lInDate1;
    data['l_is_date1'] = this.lIsDate1;
    data['l_is_price1'] = this.lIsPrice1;
    data['disc_rate'] = this.discRate;
    data['stkprice_unit_price'] = this.stkpriceUnitPrice;
    data['min_unit_price'] = this.minUnitPrice;
    data['cust_sell_price'] = this.custSellPrice;
    data['cust_min_sell_price'] = this.custMinSellPrice;
    data['rmd_cust_label_price'] = this.rmdCustLabelPrice;
    data['label_price'] = this.labelPrice;
    data['stkuom'] = this.stkuom;
    data['spec_disc_rate'] = this.specDiscRate;
    data['spec_unit_price'] = this.specUnitPrice;
    data['spec_nett_price'] = this.specNettPrice;
    data['effective_date'] = this.effectiveDate;
    return data;
  }
}

// GetCategoryByPaging
class GetCategoryByPagingResponse {
  List<GetCategoryByPagingStkCat>? stkCat;

  GetCategoryByPagingResponse({this.stkCat});

  GetCategoryByPagingResponse.fromJson(Map<String, dynamic> json) {
    if (json['StkCat'] != null) {
      stkCat = new List<GetCategoryByPagingStkCat>.empty(growable: true);
      json['StkCat'].forEach((v) {
        stkCat!.add(new GetCategoryByPagingStkCat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stkCat != null) {
      data['StkCat'] = this.stkCat!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetCategoryByPagingStkCat {
  String? iD;
  String? stkCat;
  String? catDesc;
  String? nonGst;
  String? purchaseTaxCode;
  String? supplyTaxCode;
  String? priceIncludeGst;
  String? deleted;
  String? publish;
  String? ordLeadTime;
  String? bufferStkDays;
  String? stkHoldingDays;
  String? extraStkHoldingDays;
  String? createUser;
  String? createDate;
  String? editUser;
  String? editDate;
  String? rowKey;
  String? transtamp;
  String? crdSlsAcct;
  String? crdSlsDept;
  String? cshSlsAcct;
  String? cshSlsDept;
  String? crdPurcAcct;
  String? crdPurcDept;
  String? openPos;
  String? openPosType;
  String? picturePath;
  String? sGst;
  String? triggerCode;
  String? tariffCode;
  String? zoneCode;
  String? subjectSlsTax;
  String? cshPurcAcct;
  String? cshPurcDept;
  String? crdSlsAc;
  String? crdSlsDp;
  String? cshSlsAc;
  String? cshSlsDp;
  String? crdPurcAc;
  String? crdPurcDp;
  String? cshPurcAc;
  String? cshPurcDp;
  String? compCode;
  String? branchCode;
  String? lastupload;
  String? duplicateKey;
  String? validateFailed;
  String? validateRemark;
  String? lastValidate;
  String? lastEditedBy;
  String? createdBy;

  GetCategoryByPagingStkCat(
      {this.iD,
      this.stkCat,
      this.catDesc,
      this.nonGst,
      this.purchaseTaxCode,
      this.supplyTaxCode,
      this.priceIncludeGst,
      this.deleted,
      this.publish,
      this.ordLeadTime,
      this.bufferStkDays,
      this.stkHoldingDays,
      this.extraStkHoldingDays,
      this.createUser,
      this.createDate,
      this.editUser,
      this.editDate,
      this.rowKey,
      this.transtamp,
      this.crdSlsAcct,
      this.crdSlsDept,
      this.cshSlsAcct,
      this.cshSlsDept,
      this.crdPurcAcct,
      this.crdPurcDept,
      this.openPos,
      this.openPosType,
      this.picturePath,
      this.sGst,
      this.triggerCode,
      this.tariffCode,
      this.zoneCode,
      this.subjectSlsTax,
      this.cshPurcAcct,
      this.cshPurcDept,
      this.crdSlsAc,
      this.crdSlsDp,
      this.cshSlsAc,
      this.cshSlsDp,
      this.crdPurcAc,
      this.crdPurcDp,
      this.cshPurcAc,
      this.cshPurcDp,
      this.compCode,
      this.branchCode,
      this.lastupload,
      this.duplicateKey,
      this.validateFailed,
      this.validateRemark,
      this.lastValidate,
      this.lastEditedBy,
      this.createdBy});

  GetCategoryByPagingStkCat.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    stkCat = json['stk_cat'];
    catDesc = json['cat_desc'];
    nonGst = json['non_gst'];
    purchaseTaxCode = json['purchase_tax_code'];
    supplyTaxCode = json['supply_tax_code'];
    priceIncludeGst = json['price_include_gst'];
    deleted = json['deleted'];
    publish = json['publish'];
    ordLeadTime = json['ord_lead_time'];
    bufferStkDays = json['buffer_stk_days'];
    stkHoldingDays = json['stk_holding_days'];
    extraStkHoldingDays = json['extra_stk_holding_days'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    rowKey = json['row_key'];
    transtamp = json['transtamp'];
    crdSlsAcct = json['crd_sls_acct'];
    crdSlsDept = json['crd_sls_dept'];
    cshSlsAcct = json['csh_sls_acct'];
    cshSlsDept = json['csh_sls_dept'];
    crdPurcAcct = json['crd_purc_acct'];
    crdPurcDept = json['crd_purc_dept'];
    openPos = json['open_pos'];
    openPosType = json['open_pos_type'];
    picturePath = json['picture_path'];
    sGst = json['__gst'];
    triggerCode = json['trigger_code'];
    tariffCode = json['tariff_code'];
    zoneCode = json['zone_code'];
    subjectSlsTax = json['subject_sls_tax'];
    cshPurcAcct = json['csh_purc_acct'];
    cshPurcDept = json['csh_purc_dept'];
    crdSlsAc = json['crd_sls_ac'];
    crdSlsDp = json['crd_sls_dp'];
    cshSlsAc = json['csh_sls_ac'];
    cshSlsDp = json['csh_sls_dp'];
    crdPurcAc = json['crd_purc_ac'];
    crdPurcDp = json['crd_purc_dp'];
    cshPurcAc = json['csh_purc_ac'];
    cshPurcDp = json['csh_purc_dp'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    lastupload = json['lastupload'];
    duplicateKey = json['duplicate_key'];
    validateFailed = json['validate_failed'];
    validateRemark = json['validate_remark'];
    lastValidate = json['last_validate'];
    lastEditedBy = json['last_edited_by'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['stk_cat'] = this.stkCat;
    data['cat_desc'] = this.catDesc;
    data['non_gst'] = this.nonGst;
    data['purchase_tax_code'] = this.purchaseTaxCode;
    data['supply_tax_code'] = this.supplyTaxCode;
    data['price_include_gst'] = this.priceIncludeGst;
    data['deleted'] = this.deleted;
    data['publish'] = this.publish;
    data['ord_lead_time'] = this.ordLeadTime;
    data['buffer_stk_days'] = this.bufferStkDays;
    data['stk_holding_days'] = this.stkHoldingDays;
    data['extra_stk_holding_days'] = this.extraStkHoldingDays;
    data['create_user'] = this.createUser;
    data['create_date'] = this.createDate;
    data['edit_user'] = this.editUser;
    data['edit_date'] = this.editDate;
    data['row_key'] = this.rowKey;
    data['transtamp'] = this.transtamp;
    data['crd_sls_acct'] = this.crdSlsAcct;
    data['crd_sls_dept'] = this.crdSlsDept;
    data['csh_sls_acct'] = this.cshSlsAcct;
    data['csh_sls_dept'] = this.cshSlsDept;
    data['crd_purc_acct'] = this.crdPurcAcct;
    data['crd_purc_dept'] = this.crdPurcDept;
    data['open_pos'] = this.openPos;
    data['open_pos_type'] = this.openPosType;
    data['picture_path'] = this.picturePath;
    data['__gst'] = this.sGst;
    data['trigger_code'] = this.triggerCode;
    data['tariff_code'] = this.tariffCode;
    data['zone_code'] = this.zoneCode;
    data['subject_sls_tax'] = this.subjectSlsTax;
    data['csh_purc_acct'] = this.cshPurcAcct;
    data['csh_purc_dept'] = this.cshPurcDept;
    data['crd_sls_ac'] = this.crdSlsAc;
    data['crd_sls_dp'] = this.crdSlsDp;
    data['csh_sls_ac'] = this.cshSlsAc;
    data['csh_sls_dp'] = this.cshSlsDp;
    data['crd_purc_ac'] = this.crdPurcAc;
    data['crd_purc_dp'] = this.crdPurcDp;
    data['csh_purc_ac'] = this.cshPurcAc;
    data['csh_purc_dp'] = this.cshPurcDp;
    data['comp_code'] = this.compCode;
    data['branch_code'] = this.branchCode;
    data['lastupload'] = this.lastupload;
    data['duplicate_key'] = this.duplicateKey;
    data['validate_failed'] = this.validateFailed;
    data['validate_remark'] = this.validateRemark;
    data['last_validate'] = this.lastValidate;
    data['last_edited_by'] = this.lastEditedBy;
    data['created_by'] = this.createdBy;
    return data;
  }
}

// GetGrpByPaging

class GetGroupByPagingResponse {
  List<StkGrp>? stkGrp;

  GetGroupByPagingResponse({this.stkGrp});

  GetGroupByPagingResponse.fromJson(Map<String, dynamic> json) {
    if (json['StkGrp'] != null) {
      stkGrp = new List<StkGrp>.empty(growable: true);
      json['StkGrp'].forEach((v) {
        stkGrp!.add(new StkGrp.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stkGrp != null) {
      data['StkGrp'] = this.stkGrp!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StkGrp {
  String? iD;
  String? stkGrp;
  String? grpDesc;
  String? transportType;
  String? tariffCode;
  String? deleted;
  String? createUser;
  String? createDate;
  String? editUser;
  String? editDate;
  String? rowKey;
  String? transtamp;
  String? crdSlsAcct;
  String? crdSlsDept;
  String? cshSlsAcct;
  String? cshSlsDept;
  String? crdPurcAcct;
  String? crdPurcDept;
  String? cshPurcAcct;
  String? cshPurcDept;
  String? matrix1Def;
  String? matrix2Def;
  String? matrix3Def;
  String? flexiMatrixPdo;
  String? flexiMatrixPi;
  String? flexiMatrixDo;
  String? flexiMatrixSi;
  String? flexiMatrixPos;
  String? flexiMatrixStkReceived;
  String? flexiMatrixStkIssues;
  String? matrixLvlUse;
  String? labelFile;
  String? labelSetting;
  String? triggerCode;
  String? compCode;
  String? branchCode;
  String? lastupload;
  String? duplicateKey;
  String? validateFailed;
  String? validateRemark;
  String? lastValidate;
  String? lastEditedBy;
  String? createdBy;

  StkGrp(
      {this.iD,
      this.stkGrp,
      this.grpDesc,
      this.transportType,
      this.tariffCode,
      this.deleted,
      this.createUser,
      this.createDate,
      this.editUser,
      this.editDate,
      this.rowKey,
      this.transtamp,
      this.crdSlsAcct,
      this.crdSlsDept,
      this.cshSlsAcct,
      this.cshSlsDept,
      this.crdPurcAcct,
      this.crdPurcDept,
      this.cshPurcAcct,
      this.cshPurcDept,
      this.matrix1Def,
      this.matrix2Def,
      this.matrix3Def,
      this.flexiMatrixPdo,
      this.flexiMatrixPi,
      this.flexiMatrixDo,
      this.flexiMatrixSi,
      this.flexiMatrixPos,
      this.flexiMatrixStkReceived,
      this.flexiMatrixStkIssues,
      this.matrixLvlUse,
      this.labelFile,
      this.labelSetting,
      this.triggerCode,
      this.compCode,
      this.branchCode,
      this.lastupload,
      this.duplicateKey,
      this.validateFailed,
      this.validateRemark,
      this.lastValidate,
      this.lastEditedBy,
      this.createdBy});

  StkGrp.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    stkGrp = json['stk_grp'];
    grpDesc = json['grp_desc'];
    transportType = json['transport_type'];
    tariffCode = json['tariff_code'];
    deleted = json['deleted'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    rowKey = json['row_key'];
    transtamp = json['transtamp'];
    crdSlsAcct = json['crd_sls_acct'];
    crdSlsDept = json['crd_sls_dept'];
    cshSlsAcct = json['csh_sls_acct'];
    cshSlsDept = json['csh_sls_dept'];
    crdPurcAcct = json['crd_purc_acct'];
    crdPurcDept = json['crd_purc_dept'];
    cshPurcAcct = json['csh_purc_acct'];
    cshPurcDept = json['csh_purc_dept'];
    matrix1Def = json['matrix1_def'];
    matrix2Def = json['matrix2_def'];
    matrix3Def = json['matrix3_def'];
    flexiMatrixPdo = json['flexi_matrix_pdo'];
    flexiMatrixPi = json['flexi_matrix_pi'];
    flexiMatrixDo = json['flexi_matrix_do'];
    flexiMatrixSi = json['flexi_matrix_si'];
    flexiMatrixPos = json['flexi_matrix_pos'];
    flexiMatrixStkReceived = json['flexi_matrix_stk_received'];
    flexiMatrixStkIssues = json['flexi_matrix_stk_issues'];
    matrixLvlUse = json['matrix_lvl_use'];
    labelFile = json['label_file'];
    labelSetting = json['label_setting'];
    triggerCode = json['trigger_code'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    lastupload = json['lastupload'];
    duplicateKey = json['duplicate_key'];
    validateFailed = json['validate_failed'];
    validateRemark = json['validate_remark'];
    lastValidate = json['last_validate'];
    lastEditedBy = json['last_edited_by'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['stk_grp'] = this.stkGrp;
    data['grp_desc'] = this.grpDesc;
    data['transport_type'] = this.transportType;
    data['tariff_code'] = this.tariffCode;
    data['deleted'] = this.deleted;
    data['create_user'] = this.createUser;
    data['create_date'] = this.createDate;
    data['edit_user'] = this.editUser;
    data['edit_date'] = this.editDate;
    data['row_key'] = this.rowKey;
    data['transtamp'] = this.transtamp;
    data['crd_sls_acct'] = this.crdSlsAcct;
    data['crd_sls_dept'] = this.crdSlsDept;
    data['csh_sls_acct'] = this.cshSlsAcct;
    data['csh_sls_dept'] = this.cshSlsDept;
    data['crd_purc_acct'] = this.crdPurcAcct;
    data['crd_purc_dept'] = this.crdPurcDept;
    data['csh_purc_acct'] = this.cshPurcAcct;
    data['csh_purc_dept'] = this.cshPurcDept;
    data['matrix1_def'] = this.matrix1Def;
    data['matrix2_def'] = this.matrix2Def;
    data['matrix3_def'] = this.matrix3Def;
    data['flexi_matrix_pdo'] = this.flexiMatrixPdo;
    data['flexi_matrix_pi'] = this.flexiMatrixPi;
    data['flexi_matrix_do'] = this.flexiMatrixDo;
    data['flexi_matrix_si'] = this.flexiMatrixSi;
    data['flexi_matrix_pos'] = this.flexiMatrixPos;
    data['flexi_matrix_stk_received'] = this.flexiMatrixStkReceived;
    data['flexi_matrix_stk_issues'] = this.flexiMatrixStkIssues;
    data['matrix_lvl_use'] = this.matrixLvlUse;
    data['label_file'] = this.labelFile;
    data['label_setting'] = this.labelSetting;
    data['trigger_code'] = this.triggerCode;
    data['comp_code'] = this.compCode;
    data['branch_code'] = this.branchCode;
    data['lastupload'] = this.lastupload;
    data['duplicate_key'] = this.duplicateKey;
    data['validate_failed'] = this.validateFailed;
    data['validate_remark'] = this.validateRemark;
    data['last_validate'] = this.lastValidate;
    data['last_edited_by'] = this.lastEditedBy;
    data['created_by'] = this.createdBy;
    return data;
  }
}

// GetUOMByPaging
class GetUOMByPagingResponse {
  List<UOM>? uOM;

  GetUOMByPagingResponse({this.uOM});

  GetUOMByPagingResponse.fromJson(Map<String, dynamic> json) {
    if (json['UOM'] != null) {
      uOM = new List<UOM>.empty(growable: true);
      json['UOM'].forEach((v) {
        uOM!.add(new UOM.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.uOM != null) {
      data['UOM'] = this.uOM!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UOM {
  String? iD;
  String? uom;
  String? uomDesc;
  String? createUser;
  String? createDate;
  String? editUser;
  String? compCode;
  String? branchCode;
  String? rowKey;
  String? transtamp;
  String? editDate;
  String? deleted;
  String? triggerBarcode;
  String? lastupload;
  String? lastEditedBy;
  String? createdBy;

  UOM(
      {this.iD,
      this.uom,
      this.uomDesc,
      this.createUser,
      this.createDate,
      this.editUser,
      this.compCode,
      this.branchCode,
      this.rowKey,
      this.transtamp,
      this.editDate,
      this.deleted,
      this.triggerBarcode,
      this.lastupload,
      this.lastEditedBy,
      this.createdBy});

  UOM.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    uom = json['uom'];
    uomDesc = json['uom_desc'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    rowKey = json['row_key'];
    transtamp = json['transtamp'];
    editDate = json['edit_date'];
    deleted = json['deleted'];
    triggerBarcode = json['trigger_barcode'];
    lastupload = json['lastupload'];
    lastEditedBy = json['last_edited_by'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['uom'] = this.uom;
    data['uom_desc'] = this.uomDesc;
    data['create_user'] = this.createUser;
    data['create_date'] = this.createDate;
    data['edit_user'] = this.editUser;
    data['comp_code'] = this.compCode;
    data['branch_code'] = this.branchCode;
    data['row_key'] = this.rowKey;
    data['transtamp'] = this.transtamp;
    data['edit_date'] = this.editDate;
    data['deleted'] = this.deleted;
    data['trigger_barcode'] = this.triggerBarcode;
    data['lastupload'] = this.lastupload;
    data['last_edited_by'] = this.lastEditedBy;
    data['created_by'] = this.createdBy;
    return data;
  }
}

// SaveStock
class SaveStockRequest {
  String? wsCodeCrypt;
  String? caUid;
  String? caPwd;
  String? userId;
  String? stkCode;
  String? stkDesc1;
  String? uom;
  String? stkCat;
  String? stkGrp;
  bool? publish;
  bool? useBatch;
  bool? snControl;
  String? stkPicture;
  String? stkPictureBase64String;

  SaveStockRequest(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
      this.userId,
      this.stkCode,
      this.stkDesc1,
      this.uom,
      this.stkCat,
      this.stkGrp,
      this.publish,
      this.useBatch,
      this.snControl,
      this.stkPicture,
      this.stkPictureBase64String});

  SaveStockRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    userId = json['userId'];
    stkCode = json['stkCode'];
    stkDesc1 = json['stkDesc1'];
    uom = json['uom'];
    stkCat = json['stkCat'];
    stkGrp = json['stkGrp'];
    publish = json['publish'];
    useBatch = json['useBatch'];
    snControl = json['snControl'];
    stkPicture = json['stkPicture'];
    stkPictureBase64String = json['stkPictureBase64String'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
    data['userId'] = this.userId;
    data['stkCode'] = this.stkCode;
    data['stkDesc1'] = this.stkDesc1;
    data['uom'] = this.uom;
    data['stkCat'] = this.stkCat;
    data['stkGrp'] = this.stkGrp;
    data['publish'] = this.publish;
    data['useBatch'] = this.useBatch;
    data['snControl'] = this.snControl;
    data['stkPicture'] = this.stkPicture;
    data['stkPictureBase64String'] = this.stkPictureBase64String;
    return data;
  }
}

// UpdateStockRequest
class UpdateStockRequest {
  String? wsCodeCrypt;
  String? caUid;
  String? caPwd;
  String? userId;
  String? stkCode;
  String? stkDesc1;
  String? uom;
  String? stkCat;
  String? stkGrp;
  bool? publish;
  bool? useBatch;
  bool? snControl;

  UpdateStockRequest(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
      this.userId,
      this.stkCode,
      this.stkDesc1,
      this.uom,
      this.stkCat,
      this.stkGrp,
      this.publish,
      this.useBatch,
      this.snControl});

  UpdateStockRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    userId = json['userId'];
    stkCode = json['stkCode'];
    stkDesc1 = json['stkDesc1'];
    uom = json['uom'];
    stkCat = json['stkCat'];
    stkGrp = json['stkGrp'];
    publish = json['publish'];
    useBatch = json['useBatch'];
    snControl = json['snControl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
    data['userId'] = this.userId;
    data['stkCode'] = this.stkCode;
    data['stkDesc1'] = this.stkDesc1;
    data['uom'] = this.uom;
    data['stkCat'] = this.stkCat;
    data['stkGrp'] = this.stkGrp;
    data['publish'] = this.publish;
    data['useBatch'] = this.useBatch;
    data['snControl'] = this.snControl;
    return data;
  }
}

// GetStockPictureListResponse
class GetStockPictureListResponse {
  List<StkmstFileAttach>? stkmstFileAttach;

  GetStockPictureListResponse({this.stkmstFileAttach});

  GetStockPictureListResponse.fromJson(Map<String, dynamic> json) {
    if (json['StkmstFileAttach'] != null) {
      stkmstFileAttach = new List<StkmstFileAttach>.empty(growable: true);
      json['StkmstFileAttach'].forEach((v) {
        stkmstFileAttach!.add(new StkmstFileAttach.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stkmstFileAttach != null) {
      data['StkmstFileAttach'] =
          this.stkmstFileAttach!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StkmstFileAttach {
  String? iD;
  String? stkCode;
  String? key;
  String? itemNo;
  String? fileAttached;
  String? fileName;
  String? cancel;
  String? cancelDate;
  String? deleted;
  String? createUser;
  String? createDate;
  String? editUser;
  String? editDate;
  String? compCode;
  String? branchCode;
  String? rowKey;
  String? lastupload;
  String? transtamp;
  String? attachType;
  String? lastEditedBy;
  String? createdBy;
  String? attachedSize;
  String? stkpicturePath;

  StkmstFileAttach(
      {this.iD,
      this.stkCode,
      this.key,
      this.itemNo,
      this.fileAttached,
      this.fileName,
      this.cancel,
      this.cancelDate,
      this.deleted,
      this.createUser,
      this.createDate,
      this.editUser,
      this.editDate,
      this.compCode,
      this.branchCode,
      this.rowKey,
      this.lastupload,
      this.transtamp,
      this.attachType,
      this.lastEditedBy,
      this.createdBy,
      this.attachedSize,
      this.stkpicturePath});

  StkmstFileAttach.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    stkCode = json['stk_code'];
    key = json['key'];
    itemNo = json['item_no'];
    fileAttached = json['file_attached'];
    fileName = json['file_name'];
    cancel = json['cancel'];
    cancelDate = json['cancel_date'];
    deleted = json['deleted'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    rowKey = json['row_key'];
    lastupload = json['lastupload'];
    transtamp = json['transtamp'];
    attachType = json['attach_type'];
    lastEditedBy = json['last_edited_by'];
    createdBy = json['created_by'];
    attachedSize = json['attached_size'];
    stkpicturePath = json['stkpicture_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['stk_code'] = this.stkCode;
    data['key'] = this.key;
    data['item_no'] = this.itemNo;
    data['file_attached'] = this.fileAttached;
    data['file_name'] = this.fileName;
    data['cancel'] = this.cancel;
    data['cancel_date'] = this.cancelDate;
    data['deleted'] = this.deleted;
    data['create_user'] = this.createUser;
    data['create_date'] = this.createDate;
    data['edit_user'] = this.editUser;
    data['edit_date'] = this.editDate;
    data['comp_code'] = this.compCode;
    data['branch_code'] = this.branchCode;
    data['row_key'] = this.rowKey;
    data['lastupload'] = this.lastupload;
    data['transtamp'] = this.transtamp;
    data['attach_type'] = this.attachType;
    data['last_edited_by'] = this.lastEditedBy;
    data['created_by'] = this.createdBy;
    data['attached_size'] = this.attachedSize;
    data['stkpicture_path'] = this.stkpicturePath;
    return data;
  }
}

// saveStockPictureRequest
class SaveStockPictureRequest {
  String? wsCodeCrypt;
  String? caUid;
  String? caPwd;
  String? userId;
  String? stkCode;
  String? stkPicture;
  String? stkPictureBase64String;
  String? key;
  bool? deleteRec;

  SaveStockPictureRequest(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
      this.userId,
      this.stkCode,
      this.stkPicture,
      this.stkPictureBase64String,
      this.key,
      this.deleteRec});

  SaveStockPictureRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    userId = json['userId'];
    stkCode = json['stkCode'];
    stkPicture = json['stkPicture'];
    stkPictureBase64String = json['stkPictureBase64String'];
    key = json['key'];
    deleteRec = json['deleteRec'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
    data['userId'] = this.userId;
    data['stkCode'] = this.stkCode;
    data['stkPicture'] = this.stkPicture;
    data['stkPictureBase64String'] = this.stkPictureBase64String;
    data['key'] = this.key;
    data['deleteRec'] = this.deleteRec;
    return data;
  }
}

// GetStkUOM
class GetStkUomResponse {
  List<PackingUOM>? packingUOM;

  GetStkUomResponse({this.packingUOM});

  GetStkUomResponse.fromJson(Map<String, dynamic> json) {
    if (json['PackingUOM'] != null) {
      packingUOM = new List<PackingUOM>.empty(growable: true);
      json['PackingUOM'].forEach((v) {
        packingUOM!.add(new PackingUOM.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.packingUOM != null) {
      data['PackingUOM'] = this.packingUOM!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PackingUOM {
  String? iD;
  String? stkCode;
  String? matrix1;
  String? matrix2;
  String? matrix3;
  String? uom;
  String? formulae;
  String? lastEditedBy;
  String? createdBy;

  PackingUOM(
      {this.iD,
      this.stkCode,
      this.matrix1,
      this.matrix2,
      this.matrix3,
      this.uom,
      this.formulae,
      this.lastEditedBy,
      this.createdBy});

  PackingUOM.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    stkCode = json['stk_code'];
    matrix1 = json['matrix_1'];
    matrix2 = json['matrix_2'];
    matrix3 = json['matrix_3'];
    uom = json['uom'];
    formulae = json['formulae'];
    lastEditedBy = json['last_edited_by'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['stk_code'] = this.stkCode;
    data['matrix_1'] = this.matrix1;
    data['matrix_2'] = this.matrix2;
    data['matrix_3'] = this.matrix3;
    data['uom'] = this.uom;
    data['formulae'] = this.formulae;
    data['last_edited_by'] = this.lastEditedBy;
    data['created_by'] = this.createdBy;
    return data;
  }
}
