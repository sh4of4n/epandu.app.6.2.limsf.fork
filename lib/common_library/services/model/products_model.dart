// GetCategory

class GetCategoryResponse {
  List<StkCat>? stkCat;

  GetCategoryResponse({this.stkCat});

  GetCategoryResponse.fromJson(Map<String, dynamic> json) {
    if (json['StkCat'] != null) {
      stkCat = List<StkCat>.empty(growable: true);
      json['StkCat'].forEach((v) {
        stkCat!.add(StkCat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (stkCat != null) {
      data['StkCat'] = stkCat!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['stk_cat'] = stkCat;
    data['cat_desc'] = catDesc;
    data['non_gst'] = nonGst;
    data['purchase_tax_code'] = purchaseTaxCode;
    data['supply_tax_code'] = supplyTaxCode;
    data['price_include_gst'] = priceIncludeGst;
    data['deleted'] = deleted;
    data['publish'] = publish;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_user'] = editUser;
    data['edit_date'] = editDate;
    data['row_key'] = rowKey;
    data['transtamp'] = transtamp;
    data['crd_sls_acct'] = crdSlsAcct;
    data['crd_sls_dept'] = crdSlsDept;
    data['csh_sls_acct'] = cshSlsAcct;
    data['csh_sls_dept'] = cshSlsDept;
    data['crd_purc_acct'] = crdPurcAcct;
    data['crd_purc_dept'] = crdPurcDept;
    data['open_pos'] = openPos;
    data['open_pos_type'] = openPosType;
    data['picture_path'] = picturePath;
    data['__gst'] = sGst;
    data['trigger_code'] = triggerCode;
    data['tariff_code'] = tariffCode;
    data['zone_code'] = zoneCode;
    data['subject_sls_tax'] = subjectSlsTax;
    data['csh_purc_acct'] = cshPurcAcct;
    data['csh_purc_dept'] = cshPurcDept;
    data['crd_sls_ac'] = crdSlsAc;
    data['crd_sls_dp'] = crdSlsDp;
    data['csh_sls_ac'] = cshSlsAc;
    data['csh_sls_dp'] = cshSlsDp;
    data['crd_purc_ac'] = crdPurcAc;
    data['crd_purc_dp'] = crdPurcDp;
    data['csh_purc_ac'] = cshPurcAc;
    data['csh_purc_dp'] = cshPurcDp;
    data['comp_code'] = compCode;
    data['branch_code'] = branchCode;
    data['lastupload'] = lastupload;
    data['duplicate_key'] = duplicateKey;
    data['validate_failed'] = validateFailed;
    data['last_edited_by'] = lastEditedBy;
    data['created_by'] = createdBy;
    return data;
  }
}

// GetStock
class GetStockResponse {
  List<Stkmst>? stkmst;

  GetStockResponse({this.stkmst});

  GetStockResponse.fromJson(Map<String, dynamic> json) {
    if (json['Stkmst'] != null) {
      stkmst = List<Stkmst>.empty(growable: true);
      json['Stkmst'].forEach((v) {
        stkmst!.add(Stkmst.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (stkmst != null) {
      data['Stkmst'] = stkmst!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['stk_code'] = stkCode;
    data['stk_desc1'] = stkDesc1;
    data['stk_desc2'] = stkDesc2;
    data['short_desc'] = shortDesc;
    data['short_desc2'] = shortDesc2;
    data['part_no'] = partNo;
    data['stk_cat'] = stkCat;
    data['stk_grp'] = stkGrp;
    data['transport_type'] = transportType;
    data['brand_code'] = brandCode;
    data['grade_code'] = gradeCode;
    data['menu_no'] = menuNo;
    data['int_code'] = intCode;
    data['ext_code'] = extCode;
    data['ext_code1'] = extCode1;
    data['ext_code2'] = extCode2;
    data['ext_code3'] = extCode3;
    data['uom'] = uom;
    data['dual_uom'] = dualUom;
    data['uom2'] = uom2;
    data['qty_uom2'] = qtyUom2;
    data['trn_type'] = trnType;
    data['fg_or_raw'] = fgOrRaw;
    data['deduct_rm'] = deductRm;
    data['non_active'] = nonActive;
    data['publish'] = publish;
    data['bin_no'] = binNo;
    data['upload_itm'] = uploadItm;
    data['open_pos'] = openPos;
    data['non_gst'] = nonGst;
    data['purchase_tax_code'] = purchaseTaxCode;
    data['supply_tax_code'] = supplyTaxCode;
    data['price_include_gst'] = priceIncludeGst;
    data['control_sn'] = controlSn;
    data['sn_doc'] = snDoc;
    data['use_batch'] = useBatch;
    data['ctrl_batch_price'] = ctrlBatchPrice;
    data['batch_doc'] = batchDoc;
    data['qc_check'] = qcCheck;
    data['gst_by_margin'] = gstByMargin;
    data['label_file'] = labelFile;
    data['label_setting'] = labelSetting;
    data['flexi_uom'] = flexiUom;
    data['update_bom'] = updateBom;
    data['warperiod'] = warperiod;
    data['war_mthyr'] = warMthyr;
    data['currency'] = currency;
    data['dbcode'] = dbcode;
    data['crcode'] = crcode;
    data['price_1'] = price1;
    data['price_2'] = price2;
    data['price_3'] = price3;
    data['price_4'] = price4;
    data['price_5'] = price5;
    data['price_6'] = price6;
    data['minprice_1'] = minprice1;
    data['minprice_2'] = minprice2;
    data['minprice_3'] = minprice3;
    data['minprice_4'] = minprice4;
    data['minprice_5'] = minprice5;
    data['minprice_6'] = minprice6;
    data['cost_1'] = cost1;
    data['cost_2'] = cost2;
    data['cost_3'] = cost3;
    data['cost_4'] = cost4;
    data['cost_5'] = cost5;
    data['cost_6'] = cost6;
    data['max_qty'] = maxQty;
    data['min_qty'] = minQty;
    data['min_or_qty'] = minOrQty;
    data['ro_level'] = roLevel;
    data['fillup_level'] = fillupLevel;
    data['ro_qty'] = roQty;
    data['ro_uom'] = roUom;
    data['l_is_price'] = lIsPrice;
    data['l_in_cost'] = lInCost;
    data['l_in_price'] = lInPrice;
    data['l_act_cost'] = lActCost;
    data['amt_sign'] = amtSign;
    data['scom_rate'] = scomRate;
    data['scom_amt'] = scomAmt;
    data['subject_sls_tax'] = subjectSlsTax;
    data['stk_misc1'] = stkMisc1;
    data['stk_misc2'] = stkMisc2;
    data['stk_misc3'] = stkMisc3;
    data['stk_misc4'] = stkMisc4;
    data['stk_misc5'] = stkMisc5;
    data['stk_misc6'] = stkMisc6;
    data['stk_misc7'] = stkMisc7;
    data['stk_misc8'] = stkMisc8;
    data['stk_misc9'] = stkMisc9;
    data['stk_misc10'] = stkMisc10;
    data['stk_misc11'] = stkMisc11;
    data['stk_misc12'] = stkMisc12;
    data['stk_misc13'] = stkMisc13;
    data['stk_misc14'] = stkMisc14;
    data['stk_misc15'] = stkMisc15;
    data['stk_misc16'] = stkMisc16;
    data['stk_misc17'] = stkMisc17;
    data['stk_misc18'] = stkMisc18;
    data['stk_misc19'] = stkMisc19;
    data['stk_misc20'] = stkMisc20;
    data['stk_formula'] = stkFormula;
    data['pi_formula'] = piFormula;
    data['autoassbly'] = autoassbly;
    data['point_earn'] = pointEarn;
    data['point_used'] = pointUsed;
    data['stkpicture_path'] = stkpicturePath;
    data['cost_factr'] = costFactr;
    data['codetariff'] = codetariff;
    data['codetariff_desc'] = codetariffDesc;
    data['drawing_no'] = drawingNo;
    data['engineer_draw_no'] = engineerDrawNo;
    data['engineer_apprv_by'] = engineerApprvBy;
    data['gross_weight'] = grossWeight;
    data['gross_weight_uom'] = grossWeightUom;
    data['net_weight'] = netWeight;
    data['net_weight_uom'] = netWeightUom;
    data['m3'] = m3;
    data['stk_thickness'] = stkThickness;
    data['stk_thickness_uom'] = stkThicknessUom;
    data['stk_width'] = stkWidth;
    data['stk_width_uom'] = stkWidthUom;
    data['stk_length'] = stkLength;
    data['stk_length_uom'] = stkLengthUom;
    data['tlnpct'] = tlnpct;
    data['tlnqty'] = tlnqty;
    data['tlnstatus'] = tlnstatus;
    data['use_matrix'] = useMatrix;
    data['multi_disc'] = multiDisc;
    data['ser_tax'] = serTax;
    data['sales_tax'] = salesTax;
    data['sale_acct'] = saleAcct;
    data['sale_dept'] = saleDept;
    data['sdisc_acct'] = sdiscAcct;
    data['sdisc_dept'] = sdiscDept;
    data['purc_acct'] = purcAcct;
    data['purc_dept'] = purcDept;
    data['pdisc_acct'] = pdiscAcct;
    data['pdisc_dept'] = pdiscDept;
    data['to_gl_acct'] = toGlAcct;
    data['to_gl_dept'] = toGlDept;
    data['remark'] = remark;
    data['ytd_qty'] = ytdQty;
    data['unpostqty'] = unpostqty;
    data['ytd_qtyord'] = ytdQtyord;
    data['ytd_qtyresv'] = ytdQtyresv;
    data['ytd_p_qty'] = ytdPQty;
    data['ytd_s_qty'] = ytdSQty;
    data['ytdavrcost'] = ytdavrcost;
    data['deleted'] = deleted;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_user'] = editUser;
    data['comp_code'] = compCode;
    data['branch_code'] = branchCode;
    data['row_key'] = rowKey;
    data['transtamp'] = transtamp;
    data['edit_date'] = editDate;
    data['sample_no'] = sampleNo;
    data['version'] = version;
    data['doc_ref'] = docRef;
    data['stk_key'] = stkKey;
    data['verify'] = verify;
    data['qa_spec'] = qaSpec;
    data['sls_min_or_qty'] = slsMinOrQty;
    data['__matrix_1'] = sMatrix1;
    data['__matrix_2'] = sMatrix2;
    data['__matrix_3'] = sMatrix3;
    data['__loc_code'] = sLocCode;
    data['__batch_no'] = sBatchNo;
    data['__batch_key'] = sBatchKey;
    data['__batch_qty'] = sBatchQty;
    data['open_pos_type'] = openPosType;
    data['__gst'] = sGst;
    data['trigger_code'] = triggerCode;
    data['unit_price'] = unitPrice;
    data['lastupload'] = lastupload;
    data['duplicate_key'] = duplicateKey;
    data['validate_failed'] = validateFailed;
    data['validate_remark'] = validateRemark;
    data['last_validate'] = lastValidate;
    data['last_edited_by'] = lastEditedBy;
    data['created_by'] = createdBy;
    data['cat_desc'] = catDesc;
    data['grp_desc'] = grpDesc;
    data['stkqty_ytd_qty'] = stkqtyYtdQty;
    data['stkqty_ytd_qtyresv'] = stkqtyYtdQtyresv;
    data['stkqty_ytd_available_qty'] = stkqtyYtdAvailableQty;
    data['l_in_cost1'] = lInCost1;
    data['l_in_date1'] = lInDate1;
    data['l_is_date1'] = lIsDate1;
    data['l_is_price1'] = lIsPrice1;
    data['disc_rate'] = discRate;
    data['stkprice_unit_price'] = stkpriceUnitPrice;
    data['min_unit_price'] = minUnitPrice;
    data['cust_sell_price'] = custSellPrice;
    data['cust_min_sell_price'] = custMinSellPrice;
    data['rmd_cust_label_price'] = rmdCustLabelPrice;
    data['label_price'] = labelPrice;
    data['stkuom'] = stkuom;
    data['spec_disc_rate'] = specDiscRate;
    data['spec_unit_price'] = specUnitPrice;
    data['spec_nett_price'] = specNettPrice;
    data['effective_date'] = effectiveDate;
    return data;
  }
}

// GetCategoryByPaging
class GetCategoryByPagingResponse {
  List<GetCategoryByPagingStkCat>? stkCat;

  GetCategoryByPagingResponse({this.stkCat});

  GetCategoryByPagingResponse.fromJson(Map<String, dynamic> json) {
    if (json['StkCat'] != null) {
      stkCat = List<GetCategoryByPagingStkCat>.empty(growable: true);
      json['StkCat'].forEach((v) {
        stkCat!.add(GetCategoryByPagingStkCat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (stkCat != null) {
      data['StkCat'] = stkCat!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['stk_cat'] = stkCat;
    data['cat_desc'] = catDesc;
    data['non_gst'] = nonGst;
    data['purchase_tax_code'] = purchaseTaxCode;
    data['supply_tax_code'] = supplyTaxCode;
    data['price_include_gst'] = priceIncludeGst;
    data['deleted'] = deleted;
    data['publish'] = publish;
    data['ord_lead_time'] = ordLeadTime;
    data['buffer_stk_days'] = bufferStkDays;
    data['stk_holding_days'] = stkHoldingDays;
    data['extra_stk_holding_days'] = extraStkHoldingDays;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_user'] = editUser;
    data['edit_date'] = editDate;
    data['row_key'] = rowKey;
    data['transtamp'] = transtamp;
    data['crd_sls_acct'] = crdSlsAcct;
    data['crd_sls_dept'] = crdSlsDept;
    data['csh_sls_acct'] = cshSlsAcct;
    data['csh_sls_dept'] = cshSlsDept;
    data['crd_purc_acct'] = crdPurcAcct;
    data['crd_purc_dept'] = crdPurcDept;
    data['open_pos'] = openPos;
    data['open_pos_type'] = openPosType;
    data['picture_path'] = picturePath;
    data['__gst'] = sGst;
    data['trigger_code'] = triggerCode;
    data['tariff_code'] = tariffCode;
    data['zone_code'] = zoneCode;
    data['subject_sls_tax'] = subjectSlsTax;
    data['csh_purc_acct'] = cshPurcAcct;
    data['csh_purc_dept'] = cshPurcDept;
    data['crd_sls_ac'] = crdSlsAc;
    data['crd_sls_dp'] = crdSlsDp;
    data['csh_sls_ac'] = cshSlsAc;
    data['csh_sls_dp'] = cshSlsDp;
    data['crd_purc_ac'] = crdPurcAc;
    data['crd_purc_dp'] = crdPurcDp;
    data['csh_purc_ac'] = cshPurcAc;
    data['csh_purc_dp'] = cshPurcDp;
    data['comp_code'] = compCode;
    data['branch_code'] = branchCode;
    data['lastupload'] = lastupload;
    data['duplicate_key'] = duplicateKey;
    data['validate_failed'] = validateFailed;
    data['validate_remark'] = validateRemark;
    data['last_validate'] = lastValidate;
    data['last_edited_by'] = lastEditedBy;
    data['created_by'] = createdBy;
    return data;
  }
}

// GetGrpByPaging

class GetGroupByPagingResponse {
  List<StkGrp>? stkGrp;

  GetGroupByPagingResponse({this.stkGrp});

  GetGroupByPagingResponse.fromJson(Map<String, dynamic> json) {
    if (json['StkGrp'] != null) {
      stkGrp = List<StkGrp>.empty(growable: true);
      json['StkGrp'].forEach((v) {
        stkGrp!.add(StkGrp.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (stkGrp != null) {
      data['StkGrp'] = stkGrp!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['stk_grp'] = stkGrp;
    data['grp_desc'] = grpDesc;
    data['transport_type'] = transportType;
    data['tariff_code'] = tariffCode;
    data['deleted'] = deleted;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_user'] = editUser;
    data['edit_date'] = editDate;
    data['row_key'] = rowKey;
    data['transtamp'] = transtamp;
    data['crd_sls_acct'] = crdSlsAcct;
    data['crd_sls_dept'] = crdSlsDept;
    data['csh_sls_acct'] = cshSlsAcct;
    data['csh_sls_dept'] = cshSlsDept;
    data['crd_purc_acct'] = crdPurcAcct;
    data['crd_purc_dept'] = crdPurcDept;
    data['csh_purc_acct'] = cshPurcAcct;
    data['csh_purc_dept'] = cshPurcDept;
    data['matrix1_def'] = matrix1Def;
    data['matrix2_def'] = matrix2Def;
    data['matrix3_def'] = matrix3Def;
    data['flexi_matrix_pdo'] = flexiMatrixPdo;
    data['flexi_matrix_pi'] = flexiMatrixPi;
    data['flexi_matrix_do'] = flexiMatrixDo;
    data['flexi_matrix_si'] = flexiMatrixSi;
    data['flexi_matrix_pos'] = flexiMatrixPos;
    data['flexi_matrix_stk_received'] = flexiMatrixStkReceived;
    data['flexi_matrix_stk_issues'] = flexiMatrixStkIssues;
    data['matrix_lvl_use'] = matrixLvlUse;
    data['label_file'] = labelFile;
    data['label_setting'] = labelSetting;
    data['trigger_code'] = triggerCode;
    data['comp_code'] = compCode;
    data['branch_code'] = branchCode;
    data['lastupload'] = lastupload;
    data['duplicate_key'] = duplicateKey;
    data['validate_failed'] = validateFailed;
    data['validate_remark'] = validateRemark;
    data['last_validate'] = lastValidate;
    data['last_edited_by'] = lastEditedBy;
    data['created_by'] = createdBy;
    return data;
  }
}

// GetUOMByPaging
class GetUOMByPagingResponse {
  List<UOM>? uOM;

  GetUOMByPagingResponse({this.uOM});

  GetUOMByPagingResponse.fromJson(Map<String, dynamic> json) {
    if (json['UOM'] != null) {
      uOM = List<UOM>.empty(growable: true);
      json['UOM'].forEach((v) {
        uOM!.add(UOM.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (uOM != null) {
      data['UOM'] = uOM!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['uom'] = uom;
    data['uom_desc'] = uomDesc;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_user'] = editUser;
    data['comp_code'] = compCode;
    data['branch_code'] = branchCode;
    data['row_key'] = rowKey;
    data['transtamp'] = transtamp;
    data['edit_date'] = editDate;
    data['deleted'] = deleted;
    data['trigger_barcode'] = triggerBarcode;
    data['lastupload'] = lastupload;
    data['last_edited_by'] = lastEditedBy;
    data['created_by'] = createdBy;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wsCodeCrypt'] = wsCodeCrypt;
    data['caUid'] = caUid;
    data['caPwd'] = caPwd;
    data['userId'] = userId;
    data['stkCode'] = stkCode;
    data['stkDesc1'] = stkDesc1;
    data['uom'] = uom;
    data['stkCat'] = stkCat;
    data['stkGrp'] = stkGrp;
    data['publish'] = publish;
    data['useBatch'] = useBatch;
    data['snControl'] = snControl;
    data['stkPicture'] = stkPicture;
    data['stkPictureBase64String'] = stkPictureBase64String;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wsCodeCrypt'] = wsCodeCrypt;
    data['caUid'] = caUid;
    data['caPwd'] = caPwd;
    data['userId'] = userId;
    data['stkCode'] = stkCode;
    data['stkDesc1'] = stkDesc1;
    data['uom'] = uom;
    data['stkCat'] = stkCat;
    data['stkGrp'] = stkGrp;
    data['publish'] = publish;
    data['useBatch'] = useBatch;
    data['snControl'] = snControl;
    return data;
  }
}

// GetStockPictureListResponse
class GetStockPictureListResponse {
  List<StkmstFileAttach>? stkmstFileAttach;

  GetStockPictureListResponse({this.stkmstFileAttach});

  GetStockPictureListResponse.fromJson(Map<String, dynamic> json) {
    if (json['StkmstFileAttach'] != null) {
      stkmstFileAttach = List<StkmstFileAttach>.empty(growable: true);
      json['StkmstFileAttach'].forEach((v) {
        stkmstFileAttach!.add(StkmstFileAttach.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (stkmstFileAttach != null) {
      data['StkmstFileAttach'] =
          stkmstFileAttach!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['stk_code'] = stkCode;
    data['key'] = key;
    data['item_no'] = itemNo;
    data['file_attached'] = fileAttached;
    data['file_name'] = fileName;
    data['cancel'] = cancel;
    data['cancel_date'] = cancelDate;
    data['deleted'] = deleted;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_user'] = editUser;
    data['edit_date'] = editDate;
    data['comp_code'] = compCode;
    data['branch_code'] = branchCode;
    data['row_key'] = rowKey;
    data['lastupload'] = lastupload;
    data['transtamp'] = transtamp;
    data['attach_type'] = attachType;
    data['last_edited_by'] = lastEditedBy;
    data['created_by'] = createdBy;
    data['attached_size'] = attachedSize;
    data['stkpicture_path'] = stkpicturePath;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wsCodeCrypt'] = wsCodeCrypt;
    data['caUid'] = caUid;
    data['caPwd'] = caPwd;
    data['userId'] = userId;
    data['stkCode'] = stkCode;
    data['stkPicture'] = stkPicture;
    data['stkPictureBase64String'] = stkPictureBase64String;
    data['key'] = key;
    data['deleteRec'] = deleteRec;
    return data;
  }
}

// GetStkUOM
class GetStkUomResponse {
  List<PackingUOM>? packingUOM;

  GetStkUomResponse({this.packingUOM});

  GetStkUomResponse.fromJson(Map<String, dynamic> json) {
    if (json['PackingUOM'] != null) {
      packingUOM = List<PackingUOM>.empty(growable: true);
      json['PackingUOM'].forEach((v) {
        packingUOM!.add(PackingUOM.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (packingUOM != null) {
      data['PackingUOM'] = packingUOM!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['stk_code'] = stkCode;
    data['matrix_1'] = matrix1;
    data['matrix_2'] = matrix2;
    data['matrix_3'] = matrix3;
    data['uom'] = uom;
    data['formulae'] = formulae;
    data['last_edited_by'] = lastEditedBy;
    data['created_by'] = createdBy;
    return data;
  }
}
