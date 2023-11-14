// GetBackOrderListResponse
class GetBackOrderListResponse {
  List<SalesOrderDetail>? salesOrderDetail;

  GetBackOrderListResponse({this.salesOrderDetail});

  GetBackOrderListResponse.fromJson(Map<String, dynamic> json) {
    if (json['SalesOrderDetail'] != null) {
      salesOrderDetail = List<SalesOrderDetail>.empty(growable: true);
      json['SalesOrderDetail'].forEach((v) {
        salesOrderDetail!.add(SalesOrderDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (salesOrderDetail != null) {
      data['SalesOrderDetail'] =
          salesOrderDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SalesOrderDetail {
  String? iD;
  String? docDoc;
  String? docRef;
  String? slsDoc;
  String? slsRef;
  String? ordDate;
  String? itemNo;
  String? key;
  String? branch;
  String? locCode;
  String? stkCode;
  String? tempStkCode;
  String? partNo;
  String? batchNo;
  String? batchKey;
  String? stkDesc1;
  String? stkDesc2;
  String? sOutstandingQty;
  String? ordQty;
  String? ordUom;
  String? ordPrice;
  String? nettPrice;
  String? itemQty;
  String? itemPrice;
  String? itemUom;
  String? extraQty;
  String? extraUom;
  String? extraPrice;
  String? uom2Qty;
  String? uom2Uom;
  String? focQty;
  String? focUom;
  String? fillQty;
  String? manufQty;
  String? tlManufQty;
  String? prePickQty;
  String? pickedQty;
  String? priceCode;
  String? allowDisc;
  String? discCode;
  String? discFormula;
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
  String? ordAmt;
  String? nettOrdAmt;
  String? locOrdAmt;
  String? mfgUnitPrice;
  String? mfgNettOrdAmt;
  String? mfgLocOrdAmt;
  String? unitCost;
  String? custPoNo;
  String? dueTime;
  String? woQty;
  String? matrlreqQty;
  String? invDoc;
  String? invRef;
  String? invKey;
  String? doRef;
  String? doDoc;
  String? doKey;
  String? quoDoc;
  String? quoKey;
  String? quoRef;
  String? dlvQty;
  String? dlvEqty;
  String? dlvFqty;
  String? billedQty;
  String? poQty;
  String? poDoc;
  String? poRef;
  String? poKey;
  String? projCode;
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
  String? undrMinpc;
  String? stkFormula;
  String? cj5No;
  String? cj5Totqty;
  String? cj5Balqty;
  String? remark;
  String? matrlReserved;
  String? complete;
  String? cancel;
  String? deleted;
  String? createUser;
  String? createDate;
  String? editUser;
  String? editDate;
  String? rowKey;
  String? compCode;
  String? sSlsNo;
  String? transtamp;
  String? branchCode;
  String? trnStatus;
  String? custRef1;
  String? custRef2;
  String? mainKey;
  String? subItem;
  String? custBarcode;
  String? custSellPrice;
  String? completedRemark;
  String? completedUser;
  String? sStkDesc1;
  String? sStkDesc2;
  String? sPartNo;
  String? sUom;
  String? sDbcode;
  String? sName;
  String? sSourceDocType;
  String? sSourceDoc;
  String? sSourceRef;
  String? sSourceKey;
  String? priceSource;
  String? uom;
  String? existQty;
  String? unitPrice;
  String? manuQty;
  String? tlmanuQty;
  String? dlvIqty;
  String? matrlreqClosed;
  String? lastupload;
  String? duplicateKey;
  String? validateFailed;
  String? frmStoreQty;
  String? slsNo;
  String? controlSn;
  String? useBatch;
  String? sourceDocType;
  String? sourceDoc;
  String? sourceRef;
  String? sourceKey;
  String? withPackList;
  String? ordDate1;
  String? salesPer;

  SalesOrderDetail(
      {this.iD,
      this.docDoc,
      this.docRef,
      this.slsDoc,
      this.slsRef,
      this.ordDate,
      this.itemNo,
      this.key,
      this.branch,
      this.locCode,
      this.stkCode,
      this.tempStkCode,
      this.partNo,
      this.batchNo,
      this.batchKey,
      this.stkDesc1,
      this.stkDesc2,
      this.sOutstandingQty,
      this.ordQty,
      this.ordUom,
      this.ordPrice,
      this.nettPrice,
      this.itemQty,
      this.itemPrice,
      this.itemUom,
      this.extraQty,
      this.extraUom,
      this.extraPrice,
      this.uom2Qty,
      this.uom2Uom,
      this.focQty,
      this.focUom,
      this.fillQty,
      this.manufQty,
      this.tlManufQty,
      this.prePickQty,
      this.pickedQty,
      this.priceCode,
      this.allowDisc,
      this.discCode,
      this.discFormula,
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
      this.ordAmt,
      this.nettOrdAmt,
      this.locOrdAmt,
      this.mfgUnitPrice,
      this.mfgNettOrdAmt,
      this.mfgLocOrdAmt,
      this.unitCost,
      this.custPoNo,
      this.dueTime,
      this.woQty,
      this.matrlreqQty,
      this.invDoc,
      this.invRef,
      this.invKey,
      this.doRef,
      this.doDoc,
      this.doKey,
      this.quoDoc,
      this.quoKey,
      this.quoRef,
      this.dlvQty,
      this.dlvEqty,
      this.dlvFqty,
      this.billedQty,
      this.poQty,
      this.poDoc,
      this.poRef,
      this.poKey,
      this.projCode,
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
      this.undrMinpc,
      this.stkFormula,
      this.cj5No,
      this.cj5Totqty,
      this.cj5Balqty,
      this.remark,
      this.matrlReserved,
      this.complete,
      this.cancel,
      this.deleted,
      this.createUser,
      this.createDate,
      this.editUser,
      this.editDate,
      this.rowKey,
      this.compCode,
      this.sSlsNo,
      this.transtamp,
      this.branchCode,
      this.trnStatus,
      this.custRef1,
      this.custRef2,
      this.mainKey,
      this.subItem,
      this.custBarcode,
      this.custSellPrice,
      this.completedRemark,
      this.completedUser,
      this.sStkDesc1,
      this.sStkDesc2,
      this.sPartNo,
      this.sUom,
      this.sDbcode,
      this.sName,
      this.sSourceDocType,
      this.sSourceDoc,
      this.sSourceRef,
      this.sSourceKey,
      this.priceSource,
      this.uom,
      this.existQty,
      this.unitPrice,
      this.manuQty,
      this.tlmanuQty,
      this.dlvIqty,
      this.matrlreqClosed,
      this.lastupload,
      this.duplicateKey,
      this.validateFailed,
      this.frmStoreQty,
      this.slsNo,
      this.controlSn,
      this.useBatch,
      this.sourceDocType,
      this.sourceDoc,
      this.sourceRef,
      this.sourceKey,
      this.withPackList,
      this.ordDate1,
      this.salesPer});

  SalesOrderDetail.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    docDoc = json['doc_doc'];
    docRef = json['doc_ref'];
    slsDoc = json['sls_doc'];
    slsRef = json['sls_ref'];
    ordDate = json['ord_date'];
    itemNo = json['item_no'];
    key = json['key'];
    branch = json['branch'];
    locCode = json['loc_code'];
    stkCode = json['stk_code'];
    tempStkCode = json['temp_stk_code'];
    partNo = json['part_no'];
    batchNo = json['batch_no'];
    batchKey = json['batch_key'];
    stkDesc1 = json['stk_desc1'];
    stkDesc2 = json['stk_desc2'];
    sOutstandingQty = json['__outstanding_qty'];
    ordQty = json['ord_qty'];
    ordUom = json['ord_uom'];
    ordPrice = json['ord_price'];
    nettPrice = json['nett_price'];
    itemQty = json['item_qty'];
    itemPrice = json['item_price'];
    itemUom = json['item_uom'];
    extraQty = json['extra_qty'];
    extraUom = json['extra_uom'];
    extraPrice = json['extra_price'];
    uom2Qty = json['uom2_qty'];
    uom2Uom = json['uom2_uom'];
    focQty = json['foc_qty'];
    focUom = json['foc_uom'];
    fillQty = json['fill_qty'];
    manufQty = json['manuf_qty'];
    tlManufQty = json['tl_manuf_qty'];
    prePickQty = json['pre_pick_qty'];
    pickedQty = json['picked_qty'];
    priceCode = json['price_code'];
    allowDisc = json['allow_disc'];
    discCode = json['disc_code'];
    discFormula = json['disc_formula'];
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
    ordAmt = json['ord_amt'];
    nettOrdAmt = json['nett_ord_amt'];
    locOrdAmt = json['loc_ord_amt'];
    mfgUnitPrice = json['mfg_unit_price'];
    mfgNettOrdAmt = json['mfg_nett_ord_amt'];
    mfgLocOrdAmt = json['mfg_loc_ord_amt'];
    unitCost = json['unit_cost'];
    custPoNo = json['cust_po_no'];
    dueTime = json['due_time'];
    woQty = json['wo_qty'];
    matrlreqQty = json['matrlreq_qty'];
    invDoc = json['inv_doc'];
    invRef = json['inv_ref'];
    invKey = json['inv_key'];
    doRef = json['do_ref'];
    doDoc = json['do_doc'];
    doKey = json['do_key'];
    quoDoc = json['quo_doc'];
    quoKey = json['quo_key'];
    quoRef = json['quo_ref'];
    dlvQty = json['dlv_qty'];
    dlvEqty = json['dlv_eqty'];
    dlvFqty = json['dlv_fqty'];
    billedQty = json['billed_qty'];
    poQty = json['po_qty'];
    poDoc = json['po_doc'];
    poRef = json['po_ref'];
    poKey = json['po_key'];
    projCode = json['proj_code'];
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
    undrMinpc = json['undr_minpc'];
    stkFormula = json['stk_formula'];
    cj5No = json['cj5_no'];
    cj5Totqty = json['cj5_totqty'];
    cj5Balqty = json['cj5_balqty'];
    remark = json['remark'];
    matrlReserved = json['matrl_reserved'];
    complete = json['complete'];
    cancel = json['cancel'];
    deleted = json['deleted'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    rowKey = json['row_key'];
    compCode = json['comp_code'];
    sSlsNo = json['__sls_no'];
    transtamp = json['transtamp'];
    branchCode = json['branch_code'];
    trnStatus = json['trn_status'];
    custRef1 = json['cust_ref1'];
    custRef2 = json['cust_ref2'];
    mainKey = json['main_key'];
    subItem = json['sub_item'];
    custBarcode = json['cust_barcode'];
    custSellPrice = json['cust_sell_price'];
    completedRemark = json['completed_remark'];
    completedUser = json['completed_user'];
    sStkDesc1 = json['__stk_desc1'];
    sStkDesc2 = json['__stk_desc2'];
    sPartNo = json['__part_no'];
    sUom = json['__uom'];
    sDbcode = json['__dbcode'];
    sName = json['__name'];
    sSourceDocType = json['__source_doc_type'];
    sSourceDoc = json['__source_doc'];
    sSourceRef = json['__source_ref'];
    sSourceKey = json['__source_key'];
    priceSource = json['price_source'];
    uom = json['uom'];
    existQty = json['exist_qty'];
    unitPrice = json['unit_price'];
    manuQty = json['manu_qty'];
    tlmanuQty = json['tlmanu_qty'];
    dlvIqty = json['dlv_iqty'];
    matrlreqClosed = json['matrlreq_closed'];
    lastupload = json['lastupload'];
    duplicateKey = json['duplicate_key'];
    validateFailed = json['validate_failed'];
    frmStoreQty = json['frm_store_qty'];
    slsNo = json['sls_no'];
    controlSn = json['control_sn'];
    useBatch = json['use_batch'];
    sourceDocType = json['source_doc_type'];
    sourceDoc = json['source_doc'];
    sourceRef = json['source_ref'];
    sourceKey = json['source_key'];
    withPackList = json['withPackList'];
    ordDate1 = json['ord_date1'];
    salesPer = json['sales_per'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['doc_doc'] = docDoc;
    data['doc_ref'] = docRef;
    data['sls_doc'] = slsDoc;
    data['sls_ref'] = slsRef;
    data['ord_date'] = ordDate;
    data['item_no'] = itemNo;
    data['key'] = key;
    data['branch'] = branch;
    data['loc_code'] = locCode;
    data['stk_code'] = stkCode;
    data['temp_stk_code'] = tempStkCode;
    data['part_no'] = partNo;
    data['batch_no'] = batchNo;
    data['batch_key'] = batchKey;
    data['stk_desc1'] = stkDesc1;
    data['stk_desc2'] = stkDesc2;
    data['__outstanding_qty'] = sOutstandingQty;
    data['ord_qty'] = ordQty;
    data['ord_uom'] = ordUom;
    data['ord_price'] = ordPrice;
    data['nett_price'] = nettPrice;
    data['item_qty'] = itemQty;
    data['item_price'] = itemPrice;
    data['item_uom'] = itemUom;
    data['extra_qty'] = extraQty;
    data['extra_uom'] = extraUom;
    data['extra_price'] = extraPrice;
    data['uom2_qty'] = uom2Qty;
    data['uom2_uom'] = uom2Uom;
    data['foc_qty'] = focQty;
    data['foc_uom'] = focUom;
    data['fill_qty'] = fillQty;
    data['manuf_qty'] = manufQty;
    data['tl_manuf_qty'] = tlManufQty;
    data['pre_pick_qty'] = prePickQty;
    data['picked_qty'] = pickedQty;
    data['price_code'] = priceCode;
    data['allow_disc'] = allowDisc;
    data['disc_code'] = discCode;
    data['disc_formula'] = discFormula;
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
    data['ord_amt'] = ordAmt;
    data['nett_ord_amt'] = nettOrdAmt;
    data['loc_ord_amt'] = locOrdAmt;
    data['mfg_unit_price'] = mfgUnitPrice;
    data['mfg_nett_ord_amt'] = mfgNettOrdAmt;
    data['mfg_loc_ord_amt'] = mfgLocOrdAmt;
    data['unit_cost'] = unitCost;
    data['cust_po_no'] = custPoNo;
    data['due_time'] = dueTime;
    data['wo_qty'] = woQty;
    data['matrlreq_qty'] = matrlreqQty;
    data['inv_doc'] = invDoc;
    data['inv_ref'] = invRef;
    data['inv_key'] = invKey;
    data['do_ref'] = doRef;
    data['do_doc'] = doDoc;
    data['do_key'] = doKey;
    data['quo_doc'] = quoDoc;
    data['quo_key'] = quoKey;
    data['quo_ref'] = quoRef;
    data['dlv_qty'] = dlvQty;
    data['dlv_eqty'] = dlvEqty;
    data['dlv_fqty'] = dlvFqty;
    data['billed_qty'] = billedQty;
    data['po_qty'] = poQty;
    data['po_doc'] = poDoc;
    data['po_ref'] = poRef;
    data['po_key'] = poKey;
    data['proj_code'] = projCode;
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
    data['undr_minpc'] = undrMinpc;
    data['stk_formula'] = stkFormula;
    data['cj5_no'] = cj5No;
    data['cj5_totqty'] = cj5Totqty;
    data['cj5_balqty'] = cj5Balqty;
    data['remark'] = remark;
    data['matrl_reserved'] = matrlReserved;
    data['complete'] = complete;
    data['cancel'] = cancel;
    data['deleted'] = deleted;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_user'] = editUser;
    data['edit_date'] = editDate;
    data['row_key'] = rowKey;
    data['comp_code'] = compCode;
    data['__sls_no'] = sSlsNo;
    data['transtamp'] = transtamp;
    data['branch_code'] = branchCode;
    data['trn_status'] = trnStatus;
    data['cust_ref1'] = custRef1;
    data['cust_ref2'] = custRef2;
    data['main_key'] = mainKey;
    data['sub_item'] = subItem;
    data['cust_barcode'] = custBarcode;
    data['cust_sell_price'] = custSellPrice;
    data['completed_remark'] = completedRemark;
    data['completed_user'] = completedUser;
    data['__stk_desc1'] = sStkDesc1;
    data['__stk_desc2'] = sStkDesc2;
    data['__part_no'] = sPartNo;
    data['__uom'] = sUom;
    data['__dbcode'] = sDbcode;
    data['__name'] = sName;
    data['__source_doc_type'] = sSourceDocType;
    data['__source_doc'] = sSourceDoc;
    data['__source_ref'] = sSourceRef;
    data['__source_key'] = sSourceKey;
    data['price_source'] = priceSource;
    data['uom'] = uom;
    data['exist_qty'] = existQty;
    data['unit_price'] = unitPrice;
    data['manu_qty'] = manuQty;
    data['tlmanu_qty'] = tlmanuQty;
    data['dlv_iqty'] = dlvIqty;
    data['matrlreq_closed'] = matrlreqClosed;
    data['lastupload'] = lastupload;
    data['duplicate_key'] = duplicateKey;
    data['validate_failed'] = validateFailed;
    data['frm_store_qty'] = frmStoreQty;
    data['sls_no'] = slsNo;
    data['control_sn'] = controlSn;
    data['use_batch'] = useBatch;
    data['source_doc_type'] = sourceDocType;
    data['source_doc'] = sourceDoc;
    data['source_ref'] = sourceRef;
    data['source_key'] = sourceKey;
    data['withPackList'] = withPackList;
    data['ord_date1'] = ordDate1;
    data['sales_per'] = salesPer;
    return data;
  }
}

// SaveActiveSlsDtlByDbRequest

class SaveActiveSlsDtlByDbRequest {
  String? wsCodeCrypt;
  String? caUid;
  String? caPwd;
  String? userId;
  String? dbcode;
  String? locCode;
  String? stkCode;
  String? stkDesc1;
  String? stkDesc2;
  String? batchNo;
  String? itemQty;
  String? itemUom;
  String? itemPrice;
  String? discAmt;
  String? discRate;
  bool? isOfferItem;
  String? scheduleDeliveryDateString;
  String? key;
  String? isCart;
  String? signatureImage;
  String? signatureImageBase64String;

  SaveActiveSlsDtlByDbRequest(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
      this.userId,
      this.dbcode,
      this.locCode,
      this.stkCode,
      this.stkDesc1,
      this.stkDesc2,
      this.batchNo,
      this.itemQty,
      this.itemUom,
      this.itemPrice,
      this.discAmt,
      this.discRate,
      this.isOfferItem,
      this.scheduleDeliveryDateString,
      this.key,
      this.isCart,
      this.signatureImage,
      this.signatureImageBase64String});

  SaveActiveSlsDtlByDbRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    userId = json['userId'];
    dbcode = json['dbcode'];
    locCode = json['locCode'];
    stkCode = json['stkCode'];
    stkDesc1 = json['stkDesc1'];
    stkDesc2 = json['stkDesc2'];
    batchNo = json['batchNo'];
    itemQty = json['itemQty'];
    itemUom = json['itemUom'];
    itemPrice = json['itemPrice'];
    discAmt = json['discAmt'];
    discRate = json['discRate'];
    isOfferItem = json['isOfferItem'];
    scheduleDeliveryDateString = json['scheduleDeliveryDateString'];
    key = json['key'];
    isCart = json['isCart'];
    signatureImage = json['signatureImage'];
    signatureImageBase64String = json['signatureImageBase64String'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wsCodeCrypt'] = wsCodeCrypt;
    data['caUid'] = caUid;
    data['caPwd'] = caPwd;
    data['userId'] = userId;
    data['dbcode'] = dbcode;
    data['locCode'] = locCode;
    data['stkCode'] = stkCode;
    data['stkDesc1'] = stkDesc1;
    data['stkDesc2'] = stkDesc2;
    data['batchNo'] = batchNo;
    data['itemQty'] = itemQty;
    data['itemUom'] = itemUom;
    data['itemPrice'] = itemPrice;
    data['discAmt'] = discAmt;
    data['discRate'] = discRate;
    data['isOfferItem'] = isOfferItem;
    data['scheduleDeliveryDateString'] = scheduleDeliveryDateString;
    data['key'] = key;
    data['isCart'] = isCart;
    data['signatureImage'] = signatureImage;
    data['signatureImageBase64String'] = signatureImageBase64String;
    return data;
  }
}

// DeleteSlsDtlByDocRefKeyRequest

class DeleteSlsDtlByDocRefKeyRequest {
  String? wsCodeCrypt;
  String? caUid;
  String? caPwd;
  String? userId;
  String? docDoc;
  String? docRef;
  String? key;

  DeleteSlsDtlByDocRefKeyRequest(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
      this.userId,
      this.docDoc,
      this.docRef,
      this.key});

  DeleteSlsDtlByDocRefKeyRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    userId = json['userId'];
    docDoc = json['docDoc'];
    docRef = json['docRef'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wsCodeCrypt'] = wsCodeCrypt;
    data['caUid'] = caUid;
    data['caPwd'] = caPwd;
    data['userId'] = userId;
    data['docDoc'] = docDoc;
    data['docRef'] = docRef;
    data['key'] = key;
    return data;
  }
}

// SaveCartToSalesOrderRequest
class SaveCartToSalesOrderRequest {
  String? wsCodeCrypt;
  String? caUid;
  String? caPwd;
  String? userId;
  String? docDoc;
  String? docRef;
  String? signatureImage;
  String? signatureImageBase64String;

  SaveCartToSalesOrderRequest(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
      this.userId,
      this.docDoc,
      this.docRef,
      this.signatureImage,
      this.signatureImageBase64String});

  SaveCartToSalesOrderRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    userId = json['userId'];
    docDoc = json['docDoc'];
    docRef = json['docRef'];
    signatureImage = json['signatureImage'];
    signatureImageBase64String = json['signatureImageBase64String'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wsCodeCrypt'] = wsCodeCrypt;
    data['caUid'] = caUid;
    data['caPwd'] = caPwd;
    data['userId'] = userId;
    data['docDoc'] = docDoc;
    data['docRef'] = docRef;
    data['signatureImage'] = signatureImage;
    data['signatureImageBase64String'] = signatureImageBase64String;
    return data;
  }
}

class SaveCartToSalesOrderResponse {
  List<SalesOrderTrn>? salesOrderTrn;

  SaveCartToSalesOrderResponse({this.salesOrderTrn});

  SaveCartToSalesOrderResponse.fromJson(Map<String, dynamic> json) {
    if (json['SalesOrderTrn'] != null) {
      salesOrderTrn = List<SalesOrderTrn>.empty(growable: true);
      json['SalesOrderTrn'].forEach((v) {
        salesOrderTrn!.add(SalesOrderTrn.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (salesOrderTrn != null) {
      data['SalesOrderTrn'] =
          salesOrderTrn!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SalesOrderTrn {
  String? docDoc;
  String? docRef;
  String? slsDoc;
  String? slsRef;

  SalesOrderTrn({this.docDoc, this.docRef, this.slsDoc, this.slsRef});

  SalesOrderTrn.fromJson(Map<String, dynamic> json) {
    docDoc = json['doc_doc'];
    docRef = json['doc_ref'];
    slsDoc = json['sls_doc'];
    slsRef = json['sls_ref'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doc_doc'] = docDoc;
    data['doc_ref'] = docRef;
    data['sls_doc'] = slsDoc;
    data['sls_ref'] = slsRef;
    return data;
  }
}

// GetSlsTrnByDateAndDb

class GetSlsTrnByDateAndDbResponse {
  List<SalesOrderHeader>? salesOrderHeader;

  GetSlsTrnByDateAndDbResponse({this.salesOrderHeader});

  GetSlsTrnByDateAndDbResponse.fromJson(Map<String, dynamic> json) {
    if (json['SalesOrderHeader'] != null) {
      salesOrderHeader = List<SalesOrderHeader>.empty(growable: true);
      json['SalesOrderHeader'].forEach((v) {
        salesOrderHeader!.add(SalesOrderHeader.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (salesOrderHeader != null) {
      data['SalesOrderHeader'] =
          salesOrderHeader!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SalesOrderHeader {
  String? iD;
  String? docDoc;
  String? docRef;
  String? slsDoc;
  String? slsRef;
  String? revNo;
  String? ordDate;
  String? ordTime;
  String? wfStatus;
  String? refNo;
  String? leadTime;
  String? validity;
  String? dbcode;
  String? name;
  String? locCode;
  String? areaCode;
  String? currency;
  String? rate;
  String? terms;
  String? salesPer;
  String? branch;
  String? orderBy;
  String? custPoNo;
  String? shipmentTerm;
  String? shipmentTermDetl;
  String? shipMode;
  String? shipTo;
  String? shipName;
  String? shipAdd1;
  String? shipAdd2;
  String? shipAdd3;
  String? shipAdd4;
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
  String? misc18;
  String? misc17;
  String? misc16;
  String? misc15;
  String? misc14;
  String? tlOrdQty;
  String? tlOrdAmt;
  String? tlLocDetlAmt;
  String? tlNettDetlAmt;
  String? tlNettOrdAmt;
  String? tlLocOrdAmt;
  String? tlDiscAmt;
  String? tlLocDiscAmt;
  String? tlSlsTax;
  String? tlLocSlsTax;
  String? tlSerTax;
  String? tlLocSerTax;
  String? tlPaidAmt;
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
  String? pending;
  String? cancel;
  String? posted;
  String? complete;
  String? deleted;
  String? clear;
  String? readOnly;
  String? sDbname;
  String? sDbname2;
  String? sDbshortName;
  String? sDbadd1;
  String? sDbadd2;
  String? sDbadd3;
  String? sDbadd4;
  String? sDbpostcode;
  String? sDbareaCode;
  String? sDbcityName;
  String? sDbstateName;
  String? sDbcountryName;
  String? sDbphoneOff1;
  String? sDbphoneExt1;
  String? sDbphoneOff2;
  String? sDbphoneExt2;
  String? sDbfax;
  String? sDbptc;
  String? sDbeMail;
  String? sDbcrLimit;
  String? sDbcrTerm;
  String? createUser;
  String? createDate;
  String? editDate;
  String? editUser;
  String? compCode;
  String? rowKey;
  String? transtamp;
  String? branchCode;
  String? creditReqApprv;
  String? creditApprvUser;
  String? creditApprvAmt;
  String? creditApprvLog;
  String? trnStatus;
  String? creditBlockReason;
  String? creditBlockInfo;
  String? packed;
  String? subject;
  String? tlPrePickQty;
  String? tlPickedQty;
  String? fullyBilled;
  String? tlBilledAmt;
  String? lastupload;
  String? duplicateKey;
  String? validateFailed;
  String? lastEditedBy;
  String? createdBy;
  String? status;
  String? docNo;
  String? pendingSoNo;
  String? tlOrdQty2;
  String? tlNettOrdAmt2;
  String? shipArea;
  String? creditApprvDate;
  String? shipCode;
  String? custPoDate;

  SalesOrderHeader(
      {this.iD,
      this.docDoc,
      this.docRef,
      this.slsDoc,
      this.slsRef,
      this.revNo,
      this.ordDate,
      this.ordTime,
      this.wfStatus,
      this.refNo,
      this.leadTime,
      this.validity,
      this.dbcode,
      this.name,
      this.locCode,
      this.areaCode,
      this.currency,
      this.rate,
      this.terms,
      this.salesPer,
      this.branch,
      this.orderBy,
      this.custPoNo,
      this.shipmentTerm,
      this.shipmentTermDetl,
      this.shipMode,
      this.shipTo,
      this.shipName,
      this.shipAdd1,
      this.shipAdd2,
      this.shipAdd3,
      this.shipAdd4,
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
      this.misc18,
      this.misc17,
      this.misc16,
      this.misc15,
      this.misc14,
      this.tlOrdQty,
      this.tlOrdAmt,
      this.tlLocDetlAmt,
      this.tlNettDetlAmt,
      this.tlNettOrdAmt,
      this.tlLocOrdAmt,
      this.tlDiscAmt,
      this.tlLocDiscAmt,
      this.tlSlsTax,
      this.tlLocSlsTax,
      this.tlSerTax,
      this.tlLocSerTax,
      this.tlPaidAmt,
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
      this.pending,
      this.cancel,
      this.posted,
      this.complete,
      this.deleted,
      this.clear,
      this.readOnly,
      this.sDbname,
      this.sDbname2,
      this.sDbshortName,
      this.sDbadd1,
      this.sDbadd2,
      this.sDbadd3,
      this.sDbadd4,
      this.sDbpostcode,
      this.sDbareaCode,
      this.sDbcityName,
      this.sDbstateName,
      this.sDbcountryName,
      this.sDbphoneOff1,
      this.sDbphoneExt1,
      this.sDbphoneOff2,
      this.sDbphoneExt2,
      this.sDbfax,
      this.sDbptc,
      this.sDbeMail,
      this.sDbcrLimit,
      this.sDbcrTerm,
      this.createUser,
      this.createDate,
      this.editDate,
      this.editUser,
      this.compCode,
      this.rowKey,
      this.transtamp,
      this.branchCode,
      this.creditReqApprv,
      this.creditApprvUser,
      this.creditApprvAmt,
      this.creditApprvLog,
      this.trnStatus,
      this.creditBlockReason,
      this.creditBlockInfo,
      this.packed,
      this.subject,
      this.tlPrePickQty,
      this.tlPickedQty,
      this.fullyBilled,
      this.tlBilledAmt,
      this.lastupload,
      this.duplicateKey,
      this.validateFailed,
      this.lastEditedBy,
      this.createdBy,
      this.status,
      this.docNo,
      this.pendingSoNo,
      this.tlOrdQty2,
      this.tlNettOrdAmt2,
      this.shipArea,
      this.creditApprvDate,
      this.shipCode,
      this.custPoDate});

  SalesOrderHeader.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    docDoc = json['doc_doc'];
    docRef = json['doc_ref'];
    slsDoc = json['sls_doc'];
    slsRef = json['sls_ref'];
    revNo = json['rev_no'];
    ordDate = json['ord_date'];
    ordTime = json['ord_time'];
    wfStatus = json['wf_status'];
    refNo = json['ref_no'];
    leadTime = json['lead_time'];
    validity = json['validity'];
    dbcode = json['dbcode'];
    name = json['name'];
    locCode = json['loc_code'];
    areaCode = json['area_code'];
    currency = json['currency'];
    rate = json['rate'];
    terms = json['terms'];
    salesPer = json['sales_per'];
    branch = json['branch'];
    orderBy = json['order_by'];
    custPoNo = json['cust_po_no'];
    shipmentTerm = json['shipment_term'];
    shipmentTermDetl = json['shipment_term_detl'];
    shipMode = json['ship_mode'];
    shipTo = json['ship_to'];
    shipName = json['ship_name'];
    shipAdd1 = json['ship_add1'];
    shipAdd2 = json['ship_add2'];
    shipAdd3 = json['ship_add3'];
    shipAdd4 = json['ship_add4'];
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
    misc18 = json['misc18'];
    misc17 = json['misc17'];
    misc16 = json['misc16'];
    misc15 = json['misc15'];
    misc14 = json['misc14'];
    tlOrdQty = json['tl_ord_qty'];
    tlOrdAmt = json['tl_ord_amt'];
    tlLocDetlAmt = json['tl_loc_detl_amt'];
    tlNettDetlAmt = json['tl_nett_detl_amt'];
    tlNettOrdAmt = json['tl_nett_ord_amt'];
    tlLocOrdAmt = json['tl_loc_ord_amt'];
    tlDiscAmt = json['tl_disc_amt'];
    tlLocDiscAmt = json['tl_loc_disc_amt'];
    tlSlsTax = json['tl_sls_tax'];
    tlLocSlsTax = json['tl_loc_sls_tax'];
    tlSerTax = json['tl_ser_tax'];
    tlLocSerTax = json['tl_loc_ser_tax'];
    tlPaidAmt = json['tl_paid_amt'];
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
    pending = json['pending'];
    cancel = json['cancel'];
    posted = json['posted'];
    complete = json['complete'];
    deleted = json['deleted'];
    clear = json['clear'];
    readOnly = json['read_only'];
    sDbname = json['__dbname'];
    sDbname2 = json['__dbname2'];
    sDbshortName = json['__dbshort_name'];
    sDbadd1 = json['__dbadd1'];
    sDbadd2 = json['__dbadd2'];
    sDbadd3 = json['__dbadd3'];
    sDbadd4 = json['__dbadd4'];
    sDbpostcode = json['__dbpostcode'];
    sDbareaCode = json['__dbarea_code'];
    sDbcityName = json['__dbcity_name'];
    sDbstateName = json['__dbstate_name'];
    sDbcountryName = json['__dbcountry_name'];
    sDbphoneOff1 = json['__dbphone_off1'];
    sDbphoneExt1 = json['__dbphone_ext1'];
    sDbphoneOff2 = json['__dbphone_off2'];
    sDbphoneExt2 = json['__dbphone_ext2'];
    sDbfax = json['__dbfax'];
    sDbptc = json['__dbptc'];
    sDbeMail = json['__dbe_mail'];
    sDbcrLimit = json['__dbcr_limit'];
    sDbcrTerm = json['__dbcr_term'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editDate = json['edit_date'];
    editUser = json['edit_user'];
    compCode = json['comp_code'];
    rowKey = json['row_key'];
    transtamp = json['transtamp'];
    branchCode = json['branch_code'];
    creditReqApprv = json['credit_req_apprv'];
    creditApprvUser = json['credit_apprv_user'];
    creditApprvAmt = json['credit_apprv_amt'];
    creditApprvLog = json['credit_apprv_log'];
    trnStatus = json['trn_status'];
    creditBlockReason = json['credit_block_reason'];
    creditBlockInfo = json['credit_block_info'];
    packed = json['packed'];
    subject = json['subject'];
    tlPrePickQty = json['tl_pre_pick_qty'];
    tlPickedQty = json['tl_picked_qty'];
    fullyBilled = json['fully_billed'];
    tlBilledAmt = json['tl_billed_amt'];
    lastupload = json['lastupload'];
    duplicateKey = json['duplicate_key'];
    validateFailed = json['validate_failed'];
    lastEditedBy = json['last_edited_by'];
    createdBy = json['created_by'];
    status = json['status'];
    docNo = json['doc_no'];
    pendingSoNo = json['pending_so_no'];
    tlOrdQty2 = json['tl_ord_qty2'];
    tlNettOrdAmt2 = json['tl_nett_ord_amt2'];
    shipArea = json['ship_area'];
    creditApprvDate = json['credit_apprv_date'];
    shipCode = json['ship_code'];
    custPoDate = json['cust_po_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['doc_doc'] = docDoc;
    data['doc_ref'] = docRef;
    data['sls_doc'] = slsDoc;
    data['sls_ref'] = slsRef;
    data['rev_no'] = revNo;
    data['ord_date'] = ordDate;
    data['ord_time'] = ordTime;
    data['wf_status'] = wfStatus;
    data['ref_no'] = refNo;
    data['lead_time'] = leadTime;
    data['validity'] = validity;
    data['dbcode'] = dbcode;
    data['name'] = name;
    data['loc_code'] = locCode;
    data['area_code'] = areaCode;
    data['currency'] = currency;
    data['rate'] = rate;
    data['terms'] = terms;
    data['sales_per'] = salesPer;
    data['branch'] = branch;
    data['order_by'] = orderBy;
    data['cust_po_no'] = custPoNo;
    data['shipment_term'] = shipmentTerm;
    data['shipment_term_detl'] = shipmentTermDetl;
    data['ship_mode'] = shipMode;
    data['ship_to'] = shipTo;
    data['ship_name'] = shipName;
    data['ship_add1'] = shipAdd1;
    data['ship_add2'] = shipAdd2;
    data['ship_add3'] = shipAdd3;
    data['ship_add4'] = shipAdd4;
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
    data['misc18'] = misc18;
    data['misc17'] = misc17;
    data['misc16'] = misc16;
    data['misc15'] = misc15;
    data['misc14'] = misc14;
    data['tl_ord_qty'] = tlOrdQty;
    data['tl_ord_amt'] = tlOrdAmt;
    data['tl_loc_detl_amt'] = tlLocDetlAmt;
    data['tl_nett_detl_amt'] = tlNettDetlAmt;
    data['tl_nett_ord_amt'] = tlNettOrdAmt;
    data['tl_loc_ord_amt'] = tlLocOrdAmt;
    data['tl_disc_amt'] = tlDiscAmt;
    data['tl_loc_disc_amt'] = tlLocDiscAmt;
    data['tl_sls_tax'] = tlSlsTax;
    data['tl_loc_sls_tax'] = tlLocSlsTax;
    data['tl_ser_tax'] = tlSerTax;
    data['tl_loc_ser_tax'] = tlLocSerTax;
    data['tl_paid_amt'] = tlPaidAmt;
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
    data['pending'] = pending;
    data['cancel'] = cancel;
    data['posted'] = posted;
    data['complete'] = complete;
    data['deleted'] = deleted;
    data['clear'] = clear;
    data['read_only'] = readOnly;
    data['__dbname'] = sDbname;
    data['__dbname2'] = sDbname2;
    data['__dbshort_name'] = sDbshortName;
    data['__dbadd1'] = sDbadd1;
    data['__dbadd2'] = sDbadd2;
    data['__dbadd3'] = sDbadd3;
    data['__dbadd4'] = sDbadd4;
    data['__dbpostcode'] = sDbpostcode;
    data['__dbarea_code'] = sDbareaCode;
    data['__dbcity_name'] = sDbcityName;
    data['__dbstate_name'] = sDbstateName;
    data['__dbcountry_name'] = sDbcountryName;
    data['__dbphone_off1'] = sDbphoneOff1;
    data['__dbphone_ext1'] = sDbphoneExt1;
    data['__dbphone_off2'] = sDbphoneOff2;
    data['__dbphone_ext2'] = sDbphoneExt2;
    data['__dbfax'] = sDbfax;
    data['__dbptc'] = sDbptc;
    data['__dbe_mail'] = sDbeMail;
    data['__dbcr_limit'] = sDbcrLimit;
    data['__dbcr_term'] = sDbcrTerm;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_date'] = editDate;
    data['edit_user'] = editUser;
    data['comp_code'] = compCode;
    data['row_key'] = rowKey;
    data['transtamp'] = transtamp;
    data['branch_code'] = branchCode;
    data['credit_req_apprv'] = creditReqApprv;
    data['credit_apprv_user'] = creditApprvUser;
    data['credit_apprv_amt'] = creditApprvAmt;
    data['credit_apprv_log'] = creditApprvLog;
    data['trn_status'] = trnStatus;
    data['credit_block_reason'] = creditBlockReason;
    data['credit_block_info'] = creditBlockInfo;
    data['packed'] = packed;
    data['subject'] = subject;
    data['tl_pre_pick_qty'] = tlPrePickQty;
    data['tl_picked_qty'] = tlPickedQty;
    data['fully_billed'] = fullyBilled;
    data['tl_billed_amt'] = tlBilledAmt;
    data['lastupload'] = lastupload;
    data['duplicate_key'] = duplicateKey;
    data['validate_failed'] = validateFailed;
    data['last_edited_by'] = lastEditedBy;
    data['created_by'] = createdBy;
    data['status'] = status;
    data['doc_no'] = docNo;
    data['pending_so_no'] = pendingSoNo;
    data['tl_ord_qty2'] = tlOrdQty2;
    data['tl_nett_ord_amt2'] = tlNettOrdAmt2;
    data['ship_area'] = shipArea;
    data['credit_apprv_date'] = creditApprvDate;
    data['ship_code'] = shipCode;
    data['cust_po_date'] = custPoDate;
    return data;
  }
}

// GetSlsDetailByDocNo

class GetSlsDetailByDocNoResponse {
  List<GetSlsDetailByDocNoSalesOrderDetail>? salesOrderDetail;

  GetSlsDetailByDocNoResponse({this.salesOrderDetail});

  GetSlsDetailByDocNoResponse.fromJson(Map<String, dynamic> json) {
    if (json['SalesOrderDetail'] != null) {
      salesOrderDetail =
          List<GetSlsDetailByDocNoSalesOrderDetail>.empty(growable: true);
      json['SalesOrderDetail'].forEach((v) {
        salesOrderDetail!
            .add(GetSlsDetailByDocNoSalesOrderDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (salesOrderDetail != null) {
      data['SalesOrderDetail'] =
          salesOrderDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetSlsDetailByDocNoSalesOrderDetail {
  String? iD;
  String? docDoc;
  String? docRef;
  String? slsDoc;
  String? slsRef;
  String? ordDate;
  String? itemNo;
  String? key;
  String? branch;
  String? locCode;
  String? stkCode;
  String? tempStkCode;
  String? partNo;
  String? batchNo;
  String? batchKey;
  String? stkDesc1;
  String? stkDesc2;
  String? matrix1;
  String? matrix2;
  String? matrix3;
  String? sOutstandingQty;
  String? ordQty;
  String? ordUom;
  String? ordPrice;
  String? nettPrice;
  String? itemQty;
  String? itemPrice;
  String? itemUom;
  String? extraQty;
  String? extraUom;
  String? extraPrice;
  String? uom2Qty;
  String? uom2Uom;
  String? focQty;
  String? focUom;
  String? fillQty;
  String? manufQty;
  String? tlManufQty;
  String? prePickQty;
  String? pickedQty;
  String? priceCode;
  String? allowDisc;
  String? discCode;
  String? discFormula;
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
  String? woQty;
  String? matrlreqQty;
  String? invDoc;
  String? invRef;
  String? invKey;
  String? doRef;
  String? doDoc;
  String? doKey;
  String? quoDoc;
  String? quoKey;
  String? quoRef;
  String? dlvQty;
  String? dlvEqty;
  String? dlvFqty;
  String? billedQty;
  String? poQty;
  String? poDoc;
  String? poRef;
  String? poKey;
  String? projCode;
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
  String? undrMinpc;
  String? stkFormula;
  String? cj5No;
  String? cj5NoKey;
  String? cj5Bgdt;
  String? cj5Enddt;
  String? cj5Totqty;
  String? cj5Balqty;
  String? saleAcct;
  String? saleDept;
  String? remark;
  String? matrlReserved;
  String? complete;
  String? cancel;
  String? deleted;
  String? createUser;
  String? createDate;
  String? editUser;
  String? editDate;
  String? rowKey;
  String? compCode;
  String? sSlsNo;
  String? transtamp;
  String? branchCode;
  String? trnStatus;
  String? custRef1;
  String? custRef2;
  String? mainKey;
  String? subItem;
  String? custBarcode;
  String? custSellPrice;
  String? completedRemark;
  String? completedDate;
  String? completedUser;
  String? sStkDesc1;
  String? sStkDesc2;
  String? sPartNo;
  String? sUom;
  String? sDbcode;
  String? sName;
  String? sSourceDocType;
  String? sSourceDoc;
  String? sSourceRef;
  String? sSourceKey;
  String? priceSource;
  String? offeredItem;
  String? uom;
  String? existQty;
  String? unitPrice;
  String? manuQty;
  String? tlmanuQty;
  String? dlvIqty;
  String? matrlreqClosed;
  String? lastupload;
  String? duplicateKey;
  String? validateFailed;
  String? validateRemark;
  String? lastValidate;
  String? frmStoreQty;
  String? status;
  String? lastEditedBy;
  String? createdBy;
  String? itemQty2;
  String? dlvQty2;
  String? outstandingQty2;
  String? itemPrice2;
  String? nettOrdAmt2;

  GetSlsDetailByDocNoSalesOrderDetail(
      {this.iD,
      this.docDoc,
      this.docRef,
      this.slsDoc,
      this.slsRef,
      this.ordDate,
      this.itemNo,
      this.key,
      this.branch,
      this.locCode,
      this.stkCode,
      this.tempStkCode,
      this.partNo,
      this.batchNo,
      this.batchKey,
      this.stkDesc1,
      this.stkDesc2,
      this.matrix1,
      this.matrix2,
      this.matrix3,
      this.sOutstandingQty,
      this.ordQty,
      this.ordUom,
      this.ordPrice,
      this.nettPrice,
      this.itemQty,
      this.itemPrice,
      this.itemUom,
      this.extraQty,
      this.extraUom,
      this.extraPrice,
      this.uom2Qty,
      this.uom2Uom,
      this.focQty,
      this.focUom,
      this.fillQty,
      this.manufQty,
      this.tlManufQty,
      this.prePickQty,
      this.pickedQty,
      this.priceCode,
      this.allowDisc,
      this.discCode,
      this.discFormula,
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
      this.woQty,
      this.matrlreqQty,
      this.invDoc,
      this.invRef,
      this.invKey,
      this.doRef,
      this.doDoc,
      this.doKey,
      this.quoDoc,
      this.quoKey,
      this.quoRef,
      this.dlvQty,
      this.dlvEqty,
      this.dlvFqty,
      this.billedQty,
      this.poQty,
      this.poDoc,
      this.poRef,
      this.poKey,
      this.projCode,
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
      this.undrMinpc,
      this.stkFormula,
      this.cj5No,
      this.cj5NoKey,
      this.cj5Bgdt,
      this.cj5Enddt,
      this.cj5Totqty,
      this.cj5Balqty,
      this.saleAcct,
      this.saleDept,
      this.remark,
      this.matrlReserved,
      this.complete,
      this.cancel,
      this.deleted,
      this.createUser,
      this.createDate,
      this.editUser,
      this.editDate,
      this.rowKey,
      this.compCode,
      this.sSlsNo,
      this.transtamp,
      this.branchCode,
      this.trnStatus,
      this.custRef1,
      this.custRef2,
      this.mainKey,
      this.subItem,
      this.custBarcode,
      this.custSellPrice,
      this.completedRemark,
      this.completedDate,
      this.completedUser,
      this.sStkDesc1,
      this.sStkDesc2,
      this.sPartNo,
      this.sUom,
      this.sDbcode,
      this.sName,
      this.sSourceDocType,
      this.sSourceDoc,
      this.sSourceRef,
      this.sSourceKey,
      this.priceSource,
      this.offeredItem,
      this.uom,
      this.existQty,
      this.unitPrice,
      this.manuQty,
      this.tlmanuQty,
      this.dlvIqty,
      this.matrlreqClosed,
      this.lastupload,
      this.duplicateKey,
      this.validateFailed,
      this.validateRemark,
      this.lastValidate,
      this.frmStoreQty,
      this.status,
      this.lastEditedBy,
      this.createdBy,
      this.itemQty2,
      this.dlvQty2,
      this.outstandingQty2,
      this.itemPrice2,
      this.nettOrdAmt2});

  GetSlsDetailByDocNoSalesOrderDetail.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    docDoc = json['doc_doc'];
    docRef = json['doc_ref'];
    slsDoc = json['sls_doc'];
    slsRef = json['sls_ref'];
    ordDate = json['ord_date'];
    itemNo = json['item_no'];
    key = json['key'];
    branch = json['branch'];
    locCode = json['loc_code'];
    stkCode = json['stk_code'];
    tempStkCode = json['temp_stk_code'];
    partNo = json['part_no'];
    batchNo = json['batch_no'];
    batchKey = json['batch_key'];
    stkDesc1 = json['stk_desc1'];
    stkDesc2 = json['stk_desc2'];
    matrix1 = json['matrix_1'];
    matrix2 = json['matrix_2'];
    matrix3 = json['matrix_3'];
    sOutstandingQty = json['__outstanding_qty'];
    ordQty = json['ord_qty'];
    ordUom = json['ord_uom'];
    ordPrice = json['ord_price'];
    nettPrice = json['nett_price'];
    itemQty = json['item_qty'];
    itemPrice = json['item_price'];
    itemUom = json['item_uom'];
    extraQty = json['extra_qty'];
    extraUom = json['extra_uom'];
    extraPrice = json['extra_price'];
    uom2Qty = json['uom2_qty'];
    uom2Uom = json['uom2_uom'];
    focQty = json['foc_qty'];
    focUom = json['foc_uom'];
    fillQty = json['fill_qty'];
    manufQty = json['manuf_qty'];
    tlManufQty = json['tl_manuf_qty'];
    prePickQty = json['pre_pick_qty'];
    pickedQty = json['picked_qty'];
    priceCode = json['price_code'];
    allowDisc = json['allow_disc'];
    discCode = json['disc_code'];
    discFormula = json['disc_formula'];
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
    woQty = json['wo_qty'];
    matrlreqQty = json['matrlreq_qty'];
    invDoc = json['inv_doc'];
    invRef = json['inv_ref'];
    invKey = json['inv_key'];
    doRef = json['do_ref'];
    doDoc = json['do_doc'];
    doKey = json['do_key'];
    quoDoc = json['quo_doc'];
    quoKey = json['quo_key'];
    quoRef = json['quo_ref'];
    dlvQty = json['dlv_qty'];
    dlvEqty = json['dlv_eqty'];
    dlvFqty = json['dlv_fqty'];
    billedQty = json['billed_qty'];
    poQty = json['po_qty'];
    poDoc = json['po_doc'];
    poRef = json['po_ref'];
    poKey = json['po_key'];
    projCode = json['proj_code'];
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
    undrMinpc = json['undr_minpc'];
    stkFormula = json['stk_formula'];
    cj5No = json['cj5_no'];
    cj5NoKey = json['cj5_no_key'];
    cj5Bgdt = json['cj5_bgdt'];
    cj5Enddt = json['cj5_enddt'];
    cj5Totqty = json['cj5_totqty'];
    cj5Balqty = json['cj5_balqty'];
    saleAcct = json['sale_acct'];
    saleDept = json['sale_dept'];
    remark = json['remark'];
    matrlReserved = json['matrl_reserved'];
    complete = json['complete'];
    cancel = json['cancel'];
    deleted = json['deleted'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    rowKey = json['row_key'];
    compCode = json['comp_code'];
    sSlsNo = json['__sls_no'];
    transtamp = json['transtamp'];
    branchCode = json['branch_code'];
    trnStatus = json['trn_status'];
    custRef1 = json['cust_ref1'];
    custRef2 = json['cust_ref2'];
    mainKey = json['main_key'];
    subItem = json['sub_item'];
    custBarcode = json['cust_barcode'];
    custSellPrice = json['cust_sell_price'];
    completedRemark = json['completed_remark'];
    completedDate = json['completed_date'];
    completedUser = json['completed_user'];
    sStkDesc1 = json['__stk_desc1'];
    sStkDesc2 = json['__stk_desc2'];
    sPartNo = json['__part_no'];
    sUom = json['__uom'];
    sDbcode = json['__dbcode'];
    sName = json['__name'];
    sSourceDocType = json['__source_doc_type'];
    sSourceDoc = json['__source_doc'];
    sSourceRef = json['__source_ref'];
    sSourceKey = json['__source_key'];
    priceSource = json['price_source'];
    offeredItem = json['offered_item'];
    uom = json['uom'];
    existQty = json['exist_qty'];
    unitPrice = json['unit_price'];
    manuQty = json['manu_qty'];
    tlmanuQty = json['tlmanu_qty'];
    dlvIqty = json['dlv_iqty'];
    matrlreqClosed = json['matrlreq_closed'];
    lastupload = json['lastupload'];
    duplicateKey = json['duplicate_key'];
    validateFailed = json['validate_failed'];
    validateRemark = json['validate_remark'];
    lastValidate = json['last_validate'];
    frmStoreQty = json['frm_store_qty'];
    status = json['status'];
    lastEditedBy = json['last_edited_by'];
    createdBy = json['created_by'];
    itemQty2 = json['item_qty2'];
    dlvQty2 = json['dlv_qty2'];
    outstandingQty2 = json['outstanding_qty2'];
    itemPrice2 = json['item_price2'];
    nettOrdAmt2 = json['nett_ord_amt2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['doc_doc'] = docDoc;
    data['doc_ref'] = docRef;
    data['sls_doc'] = slsDoc;
    data['sls_ref'] = slsRef;
    data['ord_date'] = ordDate;
    data['item_no'] = itemNo;
    data['key'] = key;
    data['branch'] = branch;
    data['loc_code'] = locCode;
    data['stk_code'] = stkCode;
    data['temp_stk_code'] = tempStkCode;
    data['part_no'] = partNo;
    data['batch_no'] = batchNo;
    data['batch_key'] = batchKey;
    data['stk_desc1'] = stkDesc1;
    data['stk_desc2'] = stkDesc2;
    data['matrix_1'] = matrix1;
    data['matrix_2'] = matrix2;
    data['matrix_3'] = matrix3;
    data['__outstanding_qty'] = sOutstandingQty;
    data['ord_qty'] = ordQty;
    data['ord_uom'] = ordUom;
    data['ord_price'] = ordPrice;
    data['nett_price'] = nettPrice;
    data['item_qty'] = itemQty;
    data['item_price'] = itemPrice;
    data['item_uom'] = itemUom;
    data['extra_qty'] = extraQty;
    data['extra_uom'] = extraUom;
    data['extra_price'] = extraPrice;
    data['uom2_qty'] = uom2Qty;
    data['uom2_uom'] = uom2Uom;
    data['foc_qty'] = focQty;
    data['foc_uom'] = focUom;
    data['fill_qty'] = fillQty;
    data['manuf_qty'] = manufQty;
    data['tl_manuf_qty'] = tlManufQty;
    data['pre_pick_qty'] = prePickQty;
    data['picked_qty'] = pickedQty;
    data['price_code'] = priceCode;
    data['allow_disc'] = allowDisc;
    data['disc_code'] = discCode;
    data['disc_formula'] = discFormula;
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
    data['wo_qty'] = woQty;
    data['matrlreq_qty'] = matrlreqQty;
    data['inv_doc'] = invDoc;
    data['inv_ref'] = invRef;
    data['inv_key'] = invKey;
    data['do_ref'] = doRef;
    data['do_doc'] = doDoc;
    data['do_key'] = doKey;
    data['quo_doc'] = quoDoc;
    data['quo_key'] = quoKey;
    data['quo_ref'] = quoRef;
    data['dlv_qty'] = dlvQty;
    data['dlv_eqty'] = dlvEqty;
    data['dlv_fqty'] = dlvFqty;
    data['billed_qty'] = billedQty;
    data['po_qty'] = poQty;
    data['po_doc'] = poDoc;
    data['po_ref'] = poRef;
    data['po_key'] = poKey;
    data['proj_code'] = projCode;
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
    data['undr_minpc'] = undrMinpc;
    data['stk_formula'] = stkFormula;
    data['cj5_no'] = cj5No;
    data['cj5_no_key'] = cj5NoKey;
    data['cj5_bgdt'] = cj5Bgdt;
    data['cj5_enddt'] = cj5Enddt;
    data['cj5_totqty'] = cj5Totqty;
    data['cj5_balqty'] = cj5Balqty;
    data['sale_acct'] = saleAcct;
    data['sale_dept'] = saleDept;
    data['remark'] = remark;
    data['matrl_reserved'] = matrlReserved;
    data['complete'] = complete;
    data['cancel'] = cancel;
    data['deleted'] = deleted;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_user'] = editUser;
    data['edit_date'] = editDate;
    data['row_key'] = rowKey;
    data['comp_code'] = compCode;
    data['__sls_no'] = sSlsNo;
    data['transtamp'] = transtamp;
    data['branch_code'] = branchCode;
    data['trn_status'] = trnStatus;
    data['cust_ref1'] = custRef1;
    data['cust_ref2'] = custRef2;
    data['main_key'] = mainKey;
    data['sub_item'] = subItem;
    data['cust_barcode'] = custBarcode;
    data['cust_sell_price'] = custSellPrice;
    data['completed_remark'] = completedRemark;
    data['completed_date'] = completedDate;
    data['completed_user'] = completedUser;
    data['__stk_desc1'] = sStkDesc1;
    data['__stk_desc2'] = sStkDesc2;
    data['__part_no'] = sPartNo;
    data['__uom'] = sUom;
    data['__dbcode'] = sDbcode;
    data['__name'] = sName;
    data['__source_doc_type'] = sSourceDocType;
    data['__source_doc'] = sSourceDoc;
    data['__source_ref'] = sSourceRef;
    data['__source_key'] = sSourceKey;
    data['price_source'] = priceSource;
    data['offered_item'] = offeredItem;
    data['uom'] = uom;
    data['exist_qty'] = existQty;
    data['unit_price'] = unitPrice;
    data['manu_qty'] = manuQty;
    data['tlmanu_qty'] = tlmanuQty;
    data['dlv_iqty'] = dlvIqty;
    data['matrlreq_closed'] = matrlreqClosed;
    data['lastupload'] = lastupload;
    data['duplicate_key'] = duplicateKey;
    data['validate_failed'] = validateFailed;
    data['validate_remark'] = validateRemark;
    data['last_validate'] = lastValidate;
    data['frm_store_qty'] = frmStoreQty;
    data['status'] = status;
    data['last_edited_by'] = lastEditedBy;
    data['created_by'] = createdBy;
    data['item_qty2'] = itemQty2;
    data['dlv_qty2'] = dlvQty2;
    data['outstanding_qty2'] = outstandingQty2;
    data['item_price2'] = itemPrice2;
    data['nett_ord_amt2'] = nettOrdAmt2;
    return data;
  }
}

// GetActiveSlsTrnByDb

class GetActiveSlsTrnByDbResponse {
  List<GetActiveSlsTrnByDbSalesOrderHeader>? salesOrderHeader;

  GetActiveSlsTrnByDbResponse({this.salesOrderHeader});

  GetActiveSlsTrnByDbResponse.fromJson(Map<String, dynamic> json) {
    if (json['SalesOrderHeader'] != null) {
      salesOrderHeader =
          List<GetActiveSlsTrnByDbSalesOrderHeader>.empty(growable: true);
      json['SalesOrderHeader'].forEach((v) {
        salesOrderHeader!
            .add(GetActiveSlsTrnByDbSalesOrderHeader.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (salesOrderHeader != null) {
      data['SalesOrderHeader'] =
          salesOrderHeader!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetActiveSlsTrnByDbSalesOrderHeader {
  String? iD;
  String? docDoc;
  String? docRef;
  String? slsDoc;
  String? slsRef;
  String? revNo;
  String? ordDate;
  String? ordTime;
  String? wfStatus;
  String? refNo;
  String? leadTime;
  String? validity;
  String? dbcode;
  String? name;
  String? locCode;
  String? areaCode;
  String? currency;
  String? rate;
  String? terms;
  String? branch;
  String? orderBy;
  String? custPoNo;
  String? shipmentTerm;
  String? shipmentTermDetl;
  String? shipMode;
  String? shipTo;
  String? shipName;
  String? shipAdd1;
  String? shipAdd2;
  String? shipAdd3;
  String? shipAdd4;
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
  String? misc18;
  String? misc17;
  String? misc16;
  String? misc15;
  String? misc14;
  String? tlOrdQty;
  String? tlOrdAmt;
  String? tlLocDetlAmt;
  String? tlNettDetlAmt;
  String? tlNettOrdAmt;
  String? tlLocOrdAmt;
  String? tlDiscAmt;
  String? tlLocDiscAmt;
  String? tlSlsTax;
  String? tlLocSlsTax;
  String? tlSerTax;
  String? tlLocSerTax;
  String? tlPaidAmt;
  String? bdiscRate;
  String? bdiscAmt;
  String? transChrg;
  String? transRate;
  String? mfgRate;
  String? mfgTlNettOrdAmt;
  String? mfgTlLocOrdAmt;
  String? hold;
  String? cj5No;
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
  String? pending;
  String? cancel;
  String? posted;
  String? complete;
  String? deleted;
  String? clear;
  String? readOnly;
  String? sDbname;
  String? sDbname2;
  String? sDbshortName;
  String? sDbadd1;
  String? sDbadd2;
  String? sDbadd3;
  String? sDbadd4;
  String? sDbpostcode;
  String? sDbareaCode;
  String? sDbcityName;
  String? sDbstateName;
  String? sDbcountryName;
  String? sDbphoneOff1;
  String? sDbphoneExt1;
  String? sDbphoneOff2;
  String? sDbphoneExt2;
  String? sDbfax;
  String? sDbptc;
  String? sDbeMail;
  String? sDbcrLimit;
  String? sDbcrTerm;
  String? createUser;
  String? createDate;
  String? editDate;
  String? editUser;
  String? compCode;
  String? rowKey;
  String? transtamp;
  String? branchCode;
  String? creditReqApprv;
  String? creditApprvUser;
  String? creditApprvAmt;
  String? creditApprvLog;
  String? trnStatus;
  String? creditBlockReason;
  String? creditBlockInfo;
  String? packed;
  String? subject;
  String? tlPrePickQty;
  String? tlPickedQty;
  String? fullyBilled;
  String? tlBilledAmt;
  String? lastupload;
  String? duplicateKey;
  String? validateFailed;

  GetActiveSlsTrnByDbSalesOrderHeader(
      {this.iD,
      this.docDoc,
      this.docRef,
      this.slsDoc,
      this.slsRef,
      this.revNo,
      this.ordDate,
      this.ordTime,
      this.wfStatus,
      this.refNo,
      this.leadTime,
      this.validity,
      this.dbcode,
      this.name,
      this.locCode,
      this.areaCode,
      this.currency,
      this.rate,
      this.terms,
      this.branch,
      this.orderBy,
      this.custPoNo,
      this.shipmentTerm,
      this.shipmentTermDetl,
      this.shipMode,
      this.shipTo,
      this.shipName,
      this.shipAdd1,
      this.shipAdd2,
      this.shipAdd3,
      this.shipAdd4,
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
      this.misc18,
      this.misc17,
      this.misc16,
      this.misc15,
      this.misc14,
      this.tlOrdQty,
      this.tlOrdAmt,
      this.tlLocDetlAmt,
      this.tlNettDetlAmt,
      this.tlNettOrdAmt,
      this.tlLocOrdAmt,
      this.tlDiscAmt,
      this.tlLocDiscAmt,
      this.tlSlsTax,
      this.tlLocSlsTax,
      this.tlSerTax,
      this.tlLocSerTax,
      this.tlPaidAmt,
      this.bdiscRate,
      this.bdiscAmt,
      this.transChrg,
      this.transRate,
      this.mfgRate,
      this.mfgTlNettOrdAmt,
      this.mfgTlLocOrdAmt,
      this.hold,
      this.cj5No,
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
      this.pending,
      this.cancel,
      this.posted,
      this.complete,
      this.deleted,
      this.clear,
      this.readOnly,
      this.sDbname,
      this.sDbname2,
      this.sDbshortName,
      this.sDbadd1,
      this.sDbadd2,
      this.sDbadd3,
      this.sDbadd4,
      this.sDbpostcode,
      this.sDbareaCode,
      this.sDbcityName,
      this.sDbstateName,
      this.sDbcountryName,
      this.sDbphoneOff1,
      this.sDbphoneExt1,
      this.sDbphoneOff2,
      this.sDbphoneExt2,
      this.sDbfax,
      this.sDbptc,
      this.sDbeMail,
      this.sDbcrLimit,
      this.sDbcrTerm,
      this.createUser,
      this.createDate,
      this.editDate,
      this.editUser,
      this.compCode,
      this.rowKey,
      this.transtamp,
      this.branchCode,
      this.creditReqApprv,
      this.creditApprvUser,
      this.creditApprvAmt,
      this.creditApprvLog,
      this.trnStatus,
      this.creditBlockReason,
      this.creditBlockInfo,
      this.packed,
      this.subject,
      this.tlPrePickQty,
      this.tlPickedQty,
      this.fullyBilled,
      this.tlBilledAmt,
      this.lastupload,
      this.duplicateKey,
      this.validateFailed});

  GetActiveSlsTrnByDbSalesOrderHeader.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    docDoc = json['doc_doc'];
    docRef = json['doc_ref'];
    slsDoc = json['sls_doc'];
    slsRef = json['sls_ref'];
    revNo = json['rev_no'];
    ordDate = json['ord_date'];
    ordTime = json['ord_time'];
    wfStatus = json['wf_status'];
    refNo = json['ref_no'];
    leadTime = json['lead_time'];
    validity = json['validity'];
    dbcode = json['dbcode'];
    name = json['name'];
    locCode = json['loc_code'];
    areaCode = json['area_code'];
    currency = json['currency'];
    rate = json['rate'];
    terms = json['terms'];
    branch = json['branch'];
    orderBy = json['order_by'];
    custPoNo = json['cust_po_no'];
    shipmentTerm = json['shipment_term'];
    shipmentTermDetl = json['shipment_term_detl'];
    shipMode = json['ship_mode'];
    shipTo = json['ship_to'];
    shipName = json['ship_name'];
    shipAdd1 = json['ship_add1'];
    shipAdd2 = json['ship_add2'];
    shipAdd3 = json['ship_add3'];
    shipAdd4 = json['ship_add4'];
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
    misc18 = json['misc18'];
    misc17 = json['misc17'];
    misc16 = json['misc16'];
    misc15 = json['misc15'];
    misc14 = json['misc14'];
    tlOrdQty = json['tl_ord_qty'];
    tlOrdAmt = json['tl_ord_amt'];
    tlLocDetlAmt = json['tl_loc_detl_amt'];
    tlNettDetlAmt = json['tl_nett_detl_amt'];
    tlNettOrdAmt = json['tl_nett_ord_amt'];
    tlLocOrdAmt = json['tl_loc_ord_amt'];
    tlDiscAmt = json['tl_disc_amt'];
    tlLocDiscAmt = json['tl_loc_disc_amt'];
    tlSlsTax = json['tl_sls_tax'];
    tlLocSlsTax = json['tl_loc_sls_tax'];
    tlSerTax = json['tl_ser_tax'];
    tlLocSerTax = json['tl_loc_ser_tax'];
    tlPaidAmt = json['tl_paid_amt'];
    bdiscRate = json['bdisc_rate'];
    bdiscAmt = json['bdisc_amt'];
    transChrg = json['trans_chrg'];
    transRate = json['trans_rate'];
    mfgRate = json['mfg_rate'];
    mfgTlNettOrdAmt = json['mfg_tl_nett_ord_amt'];
    mfgTlLocOrdAmt = json['mfg_tl_loc_ord_amt'];
    hold = json['hold'];
    cj5No = json['cj5_no'];
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
    pending = json['pending'];
    cancel = json['cancel'];
    posted = json['posted'];
    complete = json['complete'];
    deleted = json['deleted'];
    clear = json['clear'];
    readOnly = json['read_only'];
    sDbname = json['__dbname'];
    sDbname2 = json['__dbname2'];
    sDbshortName = json['__dbshort_name'];
    sDbadd1 = json['__dbadd1'];
    sDbadd2 = json['__dbadd2'];
    sDbadd3 = json['__dbadd3'];
    sDbadd4 = json['__dbadd4'];
    sDbpostcode = json['__dbpostcode'];
    sDbareaCode = json['__dbarea_code'];
    sDbcityName = json['__dbcity_name'];
    sDbstateName = json['__dbstate_name'];
    sDbcountryName = json['__dbcountry_name'];
    sDbphoneOff1 = json['__dbphone_off1'];
    sDbphoneExt1 = json['__dbphone_ext1'];
    sDbphoneOff2 = json['__dbphone_off2'];
    sDbphoneExt2 = json['__dbphone_ext2'];
    sDbfax = json['__dbfax'];
    sDbptc = json['__dbptc'];
    sDbeMail = json['__dbe_mail'];
    sDbcrLimit = json['__dbcr_limit'];
    sDbcrTerm = json['__dbcr_term'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editDate = json['edit_date'];
    editUser = json['edit_user'];
    compCode = json['comp_code'];
    rowKey = json['row_key'];
    transtamp = json['transtamp'];
    branchCode = json['branch_code'];
    creditReqApprv = json['credit_req_apprv'];
    creditApprvUser = json['credit_apprv_user'];
    creditApprvAmt = json['credit_apprv_amt'];
    creditApprvLog = json['credit_apprv_log'];
    trnStatus = json['trn_status'];
    creditBlockReason = json['credit_block_reason'];
    creditBlockInfo = json['credit_block_info'];
    packed = json['packed'];
    subject = json['subject'];
    tlPrePickQty = json['tl_pre_pick_qty'];
    tlPickedQty = json['tl_picked_qty'];
    fullyBilled = json['fully_billed'];
    tlBilledAmt = json['tl_billed_amt'];
    lastupload = json['lastupload'];
    duplicateKey = json['duplicate_key'];
    validateFailed = json['validate_failed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['doc_doc'] = docDoc;
    data['doc_ref'] = docRef;
    data['sls_doc'] = slsDoc;
    data['sls_ref'] = slsRef;
    data['rev_no'] = revNo;
    data['ord_date'] = ordDate;
    data['ord_time'] = ordTime;
    data['wf_status'] = wfStatus;
    data['ref_no'] = refNo;
    data['lead_time'] = leadTime;
    data['validity'] = validity;
    data['dbcode'] = dbcode;
    data['name'] = name;
    data['loc_code'] = locCode;
    data['area_code'] = areaCode;
    data['currency'] = currency;
    data['rate'] = rate;
    data['terms'] = terms;
    data['branch'] = branch;
    data['order_by'] = orderBy;
    data['cust_po_no'] = custPoNo;
    data['shipment_term'] = shipmentTerm;
    data['shipment_term_detl'] = shipmentTermDetl;
    data['ship_mode'] = shipMode;
    data['ship_to'] = shipTo;
    data['ship_name'] = shipName;
    data['ship_add1'] = shipAdd1;
    data['ship_add2'] = shipAdd2;
    data['ship_add3'] = shipAdd3;
    data['ship_add4'] = shipAdd4;
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
    data['misc18'] = misc18;
    data['misc17'] = misc17;
    data['misc16'] = misc16;
    data['misc15'] = misc15;
    data['misc14'] = misc14;
    data['tl_ord_qty'] = tlOrdQty;
    data['tl_ord_amt'] = tlOrdAmt;
    data['tl_loc_detl_amt'] = tlLocDetlAmt;
    data['tl_nett_detl_amt'] = tlNettDetlAmt;
    data['tl_nett_ord_amt'] = tlNettOrdAmt;
    data['tl_loc_ord_amt'] = tlLocOrdAmt;
    data['tl_disc_amt'] = tlDiscAmt;
    data['tl_loc_disc_amt'] = tlLocDiscAmt;
    data['tl_sls_tax'] = tlSlsTax;
    data['tl_loc_sls_tax'] = tlLocSlsTax;
    data['tl_ser_tax'] = tlSerTax;
    data['tl_loc_ser_tax'] = tlLocSerTax;
    data['tl_paid_amt'] = tlPaidAmt;
    data['bdisc_rate'] = bdiscRate;
    data['bdisc_amt'] = bdiscAmt;
    data['trans_chrg'] = transChrg;
    data['trans_rate'] = transRate;
    data['mfg_rate'] = mfgRate;
    data['mfg_tl_nett_ord_amt'] = mfgTlNettOrdAmt;
    data['mfg_tl_loc_ord_amt'] = mfgTlLocOrdAmt;
    data['hold'] = hold;
    data['cj5_no'] = cj5No;
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
    data['pending'] = pending;
    data['cancel'] = cancel;
    data['posted'] = posted;
    data['complete'] = complete;
    data['deleted'] = deleted;
    data['clear'] = clear;
    data['read_only'] = readOnly;
    data['__dbname'] = sDbname;
    data['__dbname2'] = sDbname2;
    data['__dbshort_name'] = sDbshortName;
    data['__dbadd1'] = sDbadd1;
    data['__dbadd2'] = sDbadd2;
    data['__dbadd3'] = sDbadd3;
    data['__dbadd4'] = sDbadd4;
    data['__dbpostcode'] = sDbpostcode;
    data['__dbarea_code'] = sDbareaCode;
    data['__dbcity_name'] = sDbcityName;
    data['__dbstate_name'] = sDbstateName;
    data['__dbcountry_name'] = sDbcountryName;
    data['__dbphone_off1'] = sDbphoneOff1;
    data['__dbphone_ext1'] = sDbphoneExt1;
    data['__dbphone_off2'] = sDbphoneOff2;
    data['__dbphone_ext2'] = sDbphoneExt2;
    data['__dbfax'] = sDbfax;
    data['__dbptc'] = sDbptc;
    data['__dbe_mail'] = sDbeMail;
    data['__dbcr_limit'] = sDbcrLimit;
    data['__dbcr_term'] = sDbcrTerm;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_date'] = editDate;
    data['edit_user'] = editUser;
    data['comp_code'] = compCode;
    data['row_key'] = rowKey;
    data['transtamp'] = transtamp;
    data['branch_code'] = branchCode;
    data['credit_req_apprv'] = creditReqApprv;
    data['credit_apprv_user'] = creditApprvUser;
    data['credit_apprv_amt'] = creditApprvAmt;
    data['credit_apprv_log'] = creditApprvLog;
    data['trn_status'] = trnStatus;
    data['credit_block_reason'] = creditBlockReason;
    data['credit_block_info'] = creditBlockInfo;
    data['packed'] = packed;
    data['subject'] = subject;
    data['tl_pre_pick_qty'] = tlPrePickQty;
    data['tl_picked_qty'] = tlPickedQty;
    data['fully_billed'] = fullyBilled;
    data['tl_billed_amt'] = tlBilledAmt;
    data['lastupload'] = lastupload;
    data['duplicate_key'] = duplicateKey;
    data['validate_failed'] = validateFailed;
    return data;
  }
}

// GetSalesOrderPdf
class GetSalesOrderPDFResponse {
  List<PDF>? pDF;

  GetSalesOrderPDFResponse({this.pDF});

  GetSalesOrderPDFResponse.fromJson(Map<String, dynamic> json) {
    if (json['PDF'] != null) {
      pDF = List<PDF>.empty(growable: true);
      json['PDF'].forEach((v) {
        pDF!.add(PDF.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pDF != null) {
      data['PDF'] = pDF!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PDF {
  String? fileName;

  PDF({this.fileName});

  PDF.fromJson(Map<String, dynamic> json) {
    fileName = json['file_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file_name'] = fileName;
    return data;
  }
}

class GetCustomerCreditLimitResponse {
  List<ArCtrl>? arCtrl;

  GetCustomerCreditLimitResponse({this.arCtrl});

  GetCustomerCreditLimitResponse.fromJson(Map<String, dynamic> json) {
    if (json['ArCtrl'] != null) {
      arCtrl = List<ArCtrl>.empty(growable: true);
      json['ArCtrl'].forEach((v) {
        arCtrl!.add(ArCtrl.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (arCtrl != null) {
      data['ArCtrl'] = arCtrl!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ArCtrl {
  String? dbcode;
  String? currency;
  String? crLimit;
  String? crTerm;
  String? crTermType;
  String? flexiDays;
  String? balance;
  String? amount;
  String? excessAmt;
  String? firstdueInvoice;
  String? firstduedate;
  String? dueDate;
  String? dueDay;
  String? isproceed;
  String? failedType;
  String? ordAmt;
  String? invAmt;
  String? accAmt;
  String? agedays;
  String? agemthdays;
  String? overduedays;
  String? overduemths;
  String? overdueflexidays;
  String? overduefleximths;
  String? lastTrndt;

  ArCtrl(
      {this.dbcode,
      this.currency,
      this.crLimit,
      this.crTerm,
      this.crTermType,
      this.flexiDays,
      this.balance,
      this.amount,
      this.excessAmt,
      this.firstdueInvoice,
      this.firstduedate,
      this.dueDate,
      this.dueDay,
      this.isproceed,
      this.failedType,
      this.ordAmt,
      this.invAmt,
      this.accAmt,
      this.agedays,
      this.agemthdays,
      this.overduedays,
      this.overduemths,
      this.overdueflexidays,
      this.overduefleximths,
      this.lastTrndt});

  ArCtrl.fromJson(Map<String, dynamic> json) {
    dbcode = json['dbcode'];
    currency = json['currency'];
    crLimit = json['cr_limit'];
    crTerm = json['cr_term'];
    crTermType = json['cr_term_type'];
    flexiDays = json['flexi_days'];
    balance = json['balance'];
    amount = json['amount'];
    excessAmt = json['excess_amt'];
    firstdueInvoice = json['firstdueInvoice'];
    firstduedate = json['firstduedate'];
    dueDate = json['due_date'];
    dueDay = json['due_day'];
    isproceed = json['isproceed'];
    failedType = json['failed_type'];
    ordAmt = json['ord_amt'];
    invAmt = json['inv_amt'];
    accAmt = json['acc_amt'];
    agedays = json['agedays'];
    agemthdays = json['agemthdays'];
    overduedays = json['overduedays'];
    overduemths = json['overduemths'];
    overdueflexidays = json['overdueflexidays'];
    overduefleximths = json['overduefleximths'];
    lastTrndt = json['last_trndt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dbcode'] = dbcode;
    data['currency'] = currency;
    data['cr_limit'] = crLimit;
    data['cr_term'] = crTerm;
    data['cr_term_type'] = crTermType;
    data['flexi_days'] = flexiDays;
    data['balance'] = balance;
    data['amount'] = amount;
    data['excess_amt'] = excessAmt;
    data['firstdueInvoice'] = firstdueInvoice;
    data['firstduedate'] = firstduedate;
    data['due_date'] = dueDate;
    data['due_day'] = dueDay;
    data['isproceed'] = isproceed;
    data['failed_type'] = failedType;
    data['ord_amt'] = ordAmt;
    data['inv_amt'] = invAmt;
    data['acc_amt'] = accAmt;
    data['agedays'] = agedays;
    data['agemthdays'] = agemthdays;
    data['overduedays'] = overduedays;
    data['overduemths'] = overduemths;
    data['overdueflexidays'] = overdueflexidays;
    data['overduefleximths'] = overduefleximths;
    data['last_trndt'] = lastTrndt;
    return data;
  }
}

// GetPurchaseHistoryStock
class GetPurchaseHistoryForStockResponse {
  List<SalesInvoiceDetail>? salesInvoiceDetail;

  GetPurchaseHistoryForStockResponse({this.salesInvoiceDetail});

  GetPurchaseHistoryForStockResponse.fromJson(Map<String, dynamic> json) {
    if (json['SalesInvoiceDetail'] != null) {
      salesInvoiceDetail = List<SalesInvoiceDetail>.empty(growable: true);
      json['SalesInvoiceDetail'].forEach((v) {
        salesInvoiceDetail!.add(SalesInvoiceDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (salesInvoiceDetail != null) {
      data['SalesInvoiceDetail'] =
          salesInvoiceDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SalesInvoiceDetail {
  String? iD;
  String? docType;
  String? docDoc;
  String? docRef;
  String? invDoc;
  String? invRef;
  String? invDate;
  String? itemNo;
  String? key;
  String? branch;
  String? locCode;
  String? onbehalfLocCode;
  String? stkCode;
  String? partNo;
  String? stkDesc1;
  String? stkDesc2;
  String? costSourceDocType;
  String? costSourceDoc;
  String? costSourceRef;
  String? costSourceKey;
  String? sourceClass;
  String? sourceDocType;
  String? sourceDoc;
  String? sourceRef;
  String? sourceKey;
  String? matrix1;
  String? matrix2;
  String? grossWeight;
  String? netWeight;
  String? m3;
  String? packingNo;
  String? invPrice;
  String? invQty;
  String? invUom;
  String? nettPrice;
  String? itemQty;
  String? itemPrice;
  String? itemUom;
  String? extraQty;
  String? extraUom;
  String? extraPrice;
  String? uom2Qty;
  String? uom2Uom;
  String? focQty;
  String? focUom;
  String? priceCode;
  String? allowDisc;
  String? discCode;
  String? discRate;
  String? discFormula;
  String? multiDisc;
  String? discAmt;
  String? locDiscAmt;
  String? discIamt;
  String? taxCode;
  String? taxRate;
  String? taxAmt;
  String? gstRoundAdj;
  String? priceIncludeGst;
  String? serTax;
  String? locSerTax;
  String? subjectSlsTax;
  String? slsTax;
  String? locSlsTax;
  String? slsCommRate;
  String? slsComm;
  String? locSlsComm;
  String? invAmt;
  String? nettInvAmt;
  String? locInvAmt;
  String? locNettInvAmt;
  String? locRoundAdj;
  String? gstAmt;
  String? mfgUnitPrice;
  String? mfgNettInvAmt;
  String? mfgLocInvAmt;
  String? grossProfit;
  String? unitCost;
  String? gstByMargin;
  String? batchNo;
  String? bExpDate;
  String? batchKey;
  String? projCode;
  String? misc7;
  String? misc8;
  String? misc9;
  String? misc10;
  String? misc11;
  String? misc12;
  String? extMisc1;
  String? extMisc2;
  String? extMisc3;
  String? extMisc4;
  String? extMisc5;
  String? extMisc6;
  String? extMisc7;
  String? extMisc8;
  String? extMisc9;
  String? extMisc10;
  String? extMisc11;
  String? extMisc12;
  String? extMisc13;
  String? extMisc14;
  String? extMisc15;
  String? updtSpric;
  String? undrMinpc;
  String? stkFormula;
  String? cj5No;
  String? cj5NoKey;
  String? cj5Bgdt;
  String? cj5Enddt;
  String? cj5Totqty;
  String? cj5Balqty;
  String? promotion;
  String? memberNo;
  String? hold;
  String? pointEarn;
  String? pointUsed;
  String? saleAcct;
  String? saleDept;
  String? slsDoc;
  String? slsRef;
  String? slsKey;
  String? packingDocType;
  String? packingDoc;
  String? packingRef;
  String? packingKey;
  String? custPoNo;
  String? custPoDate;
  String? doDoc;
  String? doRef;
  String? doKey;
  String? shortDesc;
  String? menuNo;
  String? orderNo;
  String? salesPer;
  String? prnCount;
  String? remark;
  String? onbehalfStatus;
  String? cancel;
  String? deleted;
  String? createUser;
  String? createDate;
  String? editUser;
  String? editDate;
  String? compCode;
  String? branchCode;
  String? rowKey;
  String? transtamp;
  String? sInvDate;
  String? sFormulae;
  String? sRate;
  String? trnStatus;
  String? sSlsAcct;
  String? sSlsDept;
  String? sSlsDesc;
  String? sAcctDesc;
  String? sQty;
  String? stkType;
  String? stkDoc;
  String? stkRef;
  String? stkKey;
  String? rtnQty;
  String? custBarcode;
  String? custSellPrice;
  String? custRef1;
  String? custRef2;
  String? mainKey;
  String? subItem;
  String? piType;
  String? piDoc;
  String? piRef;
  String? piKey;
  String? matrix3;
  String? custMinSellPrice;
  String? actionLog;
  String? sentEdiUser;
  String? sentEdiDate;
  String? slsCommCode;
  String? trnRemark;
  String? isdeposit;
  String? warranty;
  String? priceSource;
  String? sForexTax;
  String? uom;
  String? unitPrice;
  String? cnDoc;
  String? cnRef;
  String? cnKey;
  String? complete;
  String? lastupload;
  String? duplicateKey;
  String? validateFailed;
  String? validateRemark;
  String? lastValidate;
  String? dbcode;

  SalesInvoiceDetail(
      {this.iD,
      this.docType,
      this.docDoc,
      this.docRef,
      this.invDoc,
      this.invRef,
      this.invDate,
      this.itemNo,
      this.key,
      this.branch,
      this.locCode,
      this.onbehalfLocCode,
      this.stkCode,
      this.partNo,
      this.stkDesc1,
      this.stkDesc2,
      this.costSourceDocType,
      this.costSourceDoc,
      this.costSourceRef,
      this.costSourceKey,
      this.sourceClass,
      this.sourceDocType,
      this.sourceDoc,
      this.sourceRef,
      this.sourceKey,
      this.matrix1,
      this.matrix2,
      this.grossWeight,
      this.netWeight,
      this.m3,
      this.packingNo,
      this.invPrice,
      this.invQty,
      this.invUom,
      this.nettPrice,
      this.itemQty,
      this.itemPrice,
      this.itemUom,
      this.extraQty,
      this.extraUom,
      this.extraPrice,
      this.uom2Qty,
      this.uom2Uom,
      this.focQty,
      this.focUom,
      this.priceCode,
      this.allowDisc,
      this.discCode,
      this.discRate,
      this.discFormula,
      this.multiDisc,
      this.discAmt,
      this.locDiscAmt,
      this.discIamt,
      this.taxCode,
      this.taxRate,
      this.taxAmt,
      this.gstRoundAdj,
      this.priceIncludeGst,
      this.serTax,
      this.locSerTax,
      this.subjectSlsTax,
      this.slsTax,
      this.locSlsTax,
      this.slsCommRate,
      this.slsComm,
      this.locSlsComm,
      this.invAmt,
      this.nettInvAmt,
      this.locInvAmt,
      this.locNettInvAmt,
      this.locRoundAdj,
      this.gstAmt,
      this.mfgUnitPrice,
      this.mfgNettInvAmt,
      this.mfgLocInvAmt,
      this.grossProfit,
      this.unitCost,
      this.gstByMargin,
      this.batchNo,
      this.bExpDate,
      this.batchKey,
      this.projCode,
      this.misc7,
      this.misc8,
      this.misc9,
      this.misc10,
      this.misc11,
      this.misc12,
      this.extMisc1,
      this.extMisc2,
      this.extMisc3,
      this.extMisc4,
      this.extMisc5,
      this.extMisc6,
      this.extMisc7,
      this.extMisc8,
      this.extMisc9,
      this.extMisc10,
      this.extMisc11,
      this.extMisc12,
      this.extMisc13,
      this.extMisc14,
      this.extMisc15,
      this.updtSpric,
      this.undrMinpc,
      this.stkFormula,
      this.cj5No,
      this.cj5NoKey,
      this.cj5Bgdt,
      this.cj5Enddt,
      this.cj5Totqty,
      this.cj5Balqty,
      this.promotion,
      this.memberNo,
      this.hold,
      this.pointEarn,
      this.pointUsed,
      this.saleAcct,
      this.saleDept,
      this.slsDoc,
      this.slsRef,
      this.slsKey,
      this.packingDocType,
      this.packingDoc,
      this.packingRef,
      this.packingKey,
      this.custPoNo,
      this.custPoDate,
      this.doDoc,
      this.doRef,
      this.doKey,
      this.shortDesc,
      this.menuNo,
      this.orderNo,
      this.salesPer,
      this.prnCount,
      this.remark,
      this.onbehalfStatus,
      this.cancel,
      this.deleted,
      this.createUser,
      this.createDate,
      this.editUser,
      this.editDate,
      this.compCode,
      this.branchCode,
      this.rowKey,
      this.transtamp,
      this.sInvDate,
      this.sFormulae,
      this.sRate,
      this.trnStatus,
      this.sSlsAcct,
      this.sSlsDept,
      this.sSlsDesc,
      this.sAcctDesc,
      this.sQty,
      this.stkType,
      this.stkDoc,
      this.stkRef,
      this.stkKey,
      this.rtnQty,
      this.custBarcode,
      this.custSellPrice,
      this.custRef1,
      this.custRef2,
      this.mainKey,
      this.subItem,
      this.piType,
      this.piDoc,
      this.piRef,
      this.piKey,
      this.matrix3,
      this.custMinSellPrice,
      this.actionLog,
      this.sentEdiUser,
      this.sentEdiDate,
      this.slsCommCode,
      this.trnRemark,
      this.isdeposit,
      this.warranty,
      this.priceSource,
      this.sForexTax,
      this.uom,
      this.unitPrice,
      this.cnDoc,
      this.cnRef,
      this.cnKey,
      this.complete,
      this.lastupload,
      this.duplicateKey,
      this.validateFailed,
      this.validateRemark,
      this.lastValidate,
      this.dbcode});

  SalesInvoiceDetail.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    docType = json['doc_type'];
    docDoc = json['doc_doc'];
    docRef = json['doc_ref'];
    invDoc = json['inv_doc'];
    invRef = json['inv_ref'];
    invDate = json['inv_date'];
    itemNo = json['item_no'];
    key = json['key'];
    branch = json['branch'];
    locCode = json['loc_code'];
    onbehalfLocCode = json['onbehalf_loc_code'];
    stkCode = json['stk_code'];
    partNo = json['part_no'];
    stkDesc1 = json['stk_desc1'];
    stkDesc2 = json['stk_desc2'];
    costSourceDocType = json['cost_source_doc_type'];
    costSourceDoc = json['cost_source_doc'];
    costSourceRef = json['cost_source_ref'];
    costSourceKey = json['cost_source_key'];
    sourceClass = json['source_class'];
    sourceDocType = json['source_doc_type'];
    sourceDoc = json['source_doc'];
    sourceRef = json['source_ref'];
    sourceKey = json['source_key'];
    matrix1 = json['matrix_1'];
    matrix2 = json['matrix_2'];
    grossWeight = json['gross_weight'];
    netWeight = json['net_weight'];
    m3 = json['m3'];
    packingNo = json['packing_no'];
    invPrice = json['inv_price'];
    invQty = json['inv_qty'];
    invUom = json['inv_uom'];
    nettPrice = json['nett_price'];
    itemQty = json['item_qty'];
    itemPrice = json['item_price'];
    itemUom = json['item_uom'];
    extraQty = json['extra_qty'];
    extraUom = json['extra_uom'];
    extraPrice = json['extra_price'];
    uom2Qty = json['uom2_qty'];
    uom2Uom = json['uom2_uom'];
    focQty = json['foc_qty'];
    focUom = json['foc_uom'];
    priceCode = json['price_code'];
    allowDisc = json['allow_disc'];
    discCode = json['disc_code'];
    discRate = json['disc_rate'];
    discFormula = json['disc_formula'];
    multiDisc = json['multi_disc'];
    discAmt = json['disc_amt'];
    locDiscAmt = json['loc_disc_amt'];
    discIamt = json['disc_iamt'];
    taxCode = json['tax_code'];
    taxRate = json['tax_rate'];
    taxAmt = json['tax_amt'];
    gstRoundAdj = json['gst_round_adj'];
    priceIncludeGst = json['price_include_gst'];
    serTax = json['ser_tax'];
    locSerTax = json['loc_ser_tax'];
    subjectSlsTax = json['subject_sls_tax'];
    slsTax = json['sls_tax'];
    locSlsTax = json['loc_sls_tax'];
    slsCommRate = json['sls_comm_rate'];
    slsComm = json['sls_comm'];
    locSlsComm = json['loc_sls_comm'];
    invAmt = json['inv_amt'];
    nettInvAmt = json['nett_inv_amt'];
    locInvAmt = json['loc_inv_amt'];
    locNettInvAmt = json['loc_nett_inv_amt'];
    locRoundAdj = json['loc_round_adj'];
    gstAmt = json['gst_amt'];
    mfgUnitPrice = json['mfg_unit_price'];
    mfgNettInvAmt = json['mfg_nett_inv_amt'];
    mfgLocInvAmt = json['mfg_loc_inv_amt'];
    grossProfit = json['gross_profit'];
    unitCost = json['unit_cost'];
    gstByMargin = json['gst_by_margin'];
    batchNo = json['batch_no'];
    bExpDate = json['b_exp_date'];
    batchKey = json['batch_key'];
    projCode = json['proj_code'];
    misc7 = json['misc7'];
    misc8 = json['misc8'];
    misc9 = json['misc9'];
    misc10 = json['misc10'];
    misc11 = json['misc11'];
    misc12 = json['misc12'];
    extMisc1 = json['ext_misc1'];
    extMisc2 = json['ext_misc2'];
    extMisc3 = json['ext_misc3'];
    extMisc4 = json['ext_misc4'];
    extMisc5 = json['ext_misc5'];
    extMisc6 = json['ext_misc6'];
    extMisc7 = json['ext_misc7'];
    extMisc8 = json['ext_misc8'];
    extMisc9 = json['ext_misc9'];
    extMisc10 = json['ext_misc10'];
    extMisc11 = json['ext_misc11'];
    extMisc12 = json['ext_misc12'];
    extMisc13 = json['ext_misc13'];
    extMisc14 = json['ext_misc14'];
    extMisc15 = json['ext_misc15'];
    updtSpric = json['updt_spric'];
    undrMinpc = json['undr_minpc'];
    stkFormula = json['stk_formula'];
    cj5No = json['cj5_no'];
    cj5NoKey = json['cj5_no_key'];
    cj5Bgdt = json['cj5_bgdt'];
    cj5Enddt = json['cj5_enddt'];
    cj5Totqty = json['cj5_totqty'];
    cj5Balqty = json['cj5_balqty'];
    promotion = json['promotion'];
    memberNo = json['member_no'];
    hold = json['hold'];
    pointEarn = json['point_earn'];
    pointUsed = json['point_used'];
    saleAcct = json['sale_acct'];
    saleDept = json['sale_dept'];
    slsDoc = json['sls_doc'];
    slsRef = json['sls_ref'];
    slsKey = json['sls_key'];
    packingDocType = json['packing_doc_type'];
    packingDoc = json['packing_doc'];
    packingRef = json['packing_ref'];
    packingKey = json['packing_key'];
    custPoNo = json['cust_po_no'];
    custPoDate = json['cust_po_date'];
    doDoc = json['do_doc'];
    doRef = json['do_ref'];
    doKey = json['do_key'];
    shortDesc = json['short_desc'];
    menuNo = json['menu_no'];
    orderNo = json['order_no'];
    salesPer = json['sales_per'];
    prnCount = json['prn_count'];
    remark = json['remark'];
    onbehalfStatus = json['onbehalf_status'];
    cancel = json['cancel'];
    deleted = json['deleted'];
    createUser = json['create_user'];
    createDate = json['create_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    compCode = json['comp_code'];
    branchCode = json['branch_code'];
    rowKey = json['row_key'];
    transtamp = json['transtamp'];
    sInvDate = json['__inv_date'];
    sFormulae = json['__formulae'];
    sRate = json['__rate'];
    trnStatus = json['trn_status'];
    sSlsAcct = json['__sls_acct'];
    sSlsDept = json['__sls_dept'];
    sSlsDesc = json['__sls_desc'];
    sAcctDesc = json['__acct_desc'];
    sQty = json['__qty'];
    stkType = json['stk_type'];
    stkDoc = json['stk_doc'];
    stkRef = json['stk_ref'];
    stkKey = json['stk_key'];
    rtnQty = json['rtn_qty'];
    custBarcode = json['cust_barcode'];
    custSellPrice = json['cust_sell_price'];
    custRef1 = json['cust_ref1'];
    custRef2 = json['cust_ref2'];
    mainKey = json['main_key'];
    subItem = json['sub_item'];
    piType = json['pi_type'];
    piDoc = json['pi_doc'];
    piRef = json['pi_ref'];
    piKey = json['pi_key'];
    matrix3 = json['matrix_3'];
    custMinSellPrice = json['cust_min_sell_price'];
    actionLog = json['action_log'];
    sentEdiUser = json['sent_edi_user'];
    sentEdiDate = json['sent_edi_date'];
    slsCommCode = json['sls_comm_code'];
    trnRemark = json['trn_remark'];
    isdeposit = json['isdeposit'];
    warranty = json['warranty'];
    priceSource = json['price_source'];
    sForexTax = json['__forex_tax'];
    uom = json['uom'];
    unitPrice = json['unit_price'];
    cnDoc = json['cn_doc'];
    cnRef = json['cn_ref'];
    cnKey = json['cn_key'];
    complete = json['complete'];
    lastupload = json['lastupload'];
    duplicateKey = json['duplicate_key'];
    validateFailed = json['validate_failed'];
    validateRemark = json['validate_remark'];
    lastValidate = json['last_validate'];
    dbcode = json['dbcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['doc_type'] = docType;
    data['doc_doc'] = docDoc;
    data['doc_ref'] = docRef;
    data['inv_doc'] = invDoc;
    data['inv_ref'] = invRef;
    data['inv_date'] = invDate;
    data['item_no'] = itemNo;
    data['key'] = key;
    data['branch'] = branch;
    data['loc_code'] = locCode;
    data['onbehalf_loc_code'] = onbehalfLocCode;
    data['stk_code'] = stkCode;
    data['part_no'] = partNo;
    data['stk_desc1'] = stkDesc1;
    data['stk_desc2'] = stkDesc2;
    data['cost_source_doc_type'] = costSourceDocType;
    data['cost_source_doc'] = costSourceDoc;
    data['cost_source_ref'] = costSourceRef;
    data['cost_source_key'] = costSourceKey;
    data['source_class'] = sourceClass;
    data['source_doc_type'] = sourceDocType;
    data['source_doc'] = sourceDoc;
    data['source_ref'] = sourceRef;
    data['source_key'] = sourceKey;
    data['matrix_1'] = matrix1;
    data['matrix_2'] = matrix2;
    data['gross_weight'] = grossWeight;
    data['net_weight'] = netWeight;
    data['m3'] = m3;
    data['packing_no'] = packingNo;
    data['inv_price'] = invPrice;
    data['inv_qty'] = invQty;
    data['inv_uom'] = invUom;
    data['nett_price'] = nettPrice;
    data['item_qty'] = itemQty;
    data['item_price'] = itemPrice;
    data['item_uom'] = itemUom;
    data['extra_qty'] = extraQty;
    data['extra_uom'] = extraUom;
    data['extra_price'] = extraPrice;
    data['uom2_qty'] = uom2Qty;
    data['uom2_uom'] = uom2Uom;
    data['foc_qty'] = focQty;
    data['foc_uom'] = focUom;
    data['price_code'] = priceCode;
    data['allow_disc'] = allowDisc;
    data['disc_code'] = discCode;
    data['disc_rate'] = discRate;
    data['disc_formula'] = discFormula;
    data['multi_disc'] = multiDisc;
    data['disc_amt'] = discAmt;
    data['loc_disc_amt'] = locDiscAmt;
    data['disc_iamt'] = discIamt;
    data['tax_code'] = taxCode;
    data['tax_rate'] = taxRate;
    data['tax_amt'] = taxAmt;
    data['gst_round_adj'] = gstRoundAdj;
    data['price_include_gst'] = priceIncludeGst;
    data['ser_tax'] = serTax;
    data['loc_ser_tax'] = locSerTax;
    data['subject_sls_tax'] = subjectSlsTax;
    data['sls_tax'] = slsTax;
    data['loc_sls_tax'] = locSlsTax;
    data['sls_comm_rate'] = slsCommRate;
    data['sls_comm'] = slsComm;
    data['loc_sls_comm'] = locSlsComm;
    data['inv_amt'] = invAmt;
    data['nett_inv_amt'] = nettInvAmt;
    data['loc_inv_amt'] = locInvAmt;
    data['loc_nett_inv_amt'] = locNettInvAmt;
    data['loc_round_adj'] = locRoundAdj;
    data['gst_amt'] = gstAmt;
    data['mfg_unit_price'] = mfgUnitPrice;
    data['mfg_nett_inv_amt'] = mfgNettInvAmt;
    data['mfg_loc_inv_amt'] = mfgLocInvAmt;
    data['gross_profit'] = grossProfit;
    data['unit_cost'] = unitCost;
    data['gst_by_margin'] = gstByMargin;
    data['batch_no'] = batchNo;
    data['b_exp_date'] = bExpDate;
    data['batch_key'] = batchKey;
    data['proj_code'] = projCode;
    data['misc7'] = misc7;
    data['misc8'] = misc8;
    data['misc9'] = misc9;
    data['misc10'] = misc10;
    data['misc11'] = misc11;
    data['misc12'] = misc12;
    data['ext_misc1'] = extMisc1;
    data['ext_misc2'] = extMisc2;
    data['ext_misc3'] = extMisc3;
    data['ext_misc4'] = extMisc4;
    data['ext_misc5'] = extMisc5;
    data['ext_misc6'] = extMisc6;
    data['ext_misc7'] = extMisc7;
    data['ext_misc8'] = extMisc8;
    data['ext_misc9'] = extMisc9;
    data['ext_misc10'] = extMisc10;
    data['ext_misc11'] = extMisc11;
    data['ext_misc12'] = extMisc12;
    data['ext_misc13'] = extMisc13;
    data['ext_misc14'] = extMisc14;
    data['ext_misc15'] = extMisc15;
    data['updt_spric'] = updtSpric;
    data['undr_minpc'] = undrMinpc;
    data['stk_formula'] = stkFormula;
    data['cj5_no'] = cj5No;
    data['cj5_no_key'] = cj5NoKey;
    data['cj5_bgdt'] = cj5Bgdt;
    data['cj5_enddt'] = cj5Enddt;
    data['cj5_totqty'] = cj5Totqty;
    data['cj5_balqty'] = cj5Balqty;
    data['promotion'] = promotion;
    data['member_no'] = memberNo;
    data['hold'] = hold;
    data['point_earn'] = pointEarn;
    data['point_used'] = pointUsed;
    data['sale_acct'] = saleAcct;
    data['sale_dept'] = saleDept;
    data['sls_doc'] = slsDoc;
    data['sls_ref'] = slsRef;
    data['sls_key'] = slsKey;
    data['packing_doc_type'] = packingDocType;
    data['packing_doc'] = packingDoc;
    data['packing_ref'] = packingRef;
    data['packing_key'] = packingKey;
    data['cust_po_no'] = custPoNo;
    data['cust_po_date'] = custPoDate;
    data['do_doc'] = doDoc;
    data['do_ref'] = doRef;
    data['do_key'] = doKey;
    data['short_desc'] = shortDesc;
    data['menu_no'] = menuNo;
    data['order_no'] = orderNo;
    data['sales_per'] = salesPer;
    data['prn_count'] = prnCount;
    data['remark'] = remark;
    data['onbehalf_status'] = onbehalfStatus;
    data['cancel'] = cancel;
    data['deleted'] = deleted;
    data['create_user'] = createUser;
    data['create_date'] = createDate;
    data['edit_user'] = editUser;
    data['edit_date'] = editDate;
    data['comp_code'] = compCode;
    data['branch_code'] = branchCode;
    data['row_key'] = rowKey;
    data['transtamp'] = transtamp;
    data['__inv_date'] = sInvDate;
    data['__formulae'] = sFormulae;
    data['__rate'] = sRate;
    data['trn_status'] = trnStatus;
    data['__sls_acct'] = sSlsAcct;
    data['__sls_dept'] = sSlsDept;
    data['__sls_desc'] = sSlsDesc;
    data['__acct_desc'] = sAcctDesc;
    data['__qty'] = sQty;
    data['stk_type'] = stkType;
    data['stk_doc'] = stkDoc;
    data['stk_ref'] = stkRef;
    data['stk_key'] = stkKey;
    data['rtn_qty'] = rtnQty;
    data['cust_barcode'] = custBarcode;
    data['cust_sell_price'] = custSellPrice;
    data['cust_ref1'] = custRef1;
    data['cust_ref2'] = custRef2;
    data['main_key'] = mainKey;
    data['sub_item'] = subItem;
    data['pi_type'] = piType;
    data['pi_doc'] = piDoc;
    data['pi_ref'] = piRef;
    data['pi_key'] = piKey;
    data['matrix_3'] = matrix3;
    data['cust_min_sell_price'] = custMinSellPrice;
    data['action_log'] = actionLog;
    data['sent_edi_user'] = sentEdiUser;
    data['sent_edi_date'] = sentEdiDate;
    data['sls_comm_code'] = slsCommCode;
    data['trn_remark'] = trnRemark;
    data['isdeposit'] = isdeposit;
    data['warranty'] = warranty;
    data['price_source'] = priceSource;
    data['__forex_tax'] = sForexTax;
    data['uom'] = uom;
    data['unit_price'] = unitPrice;
    data['cn_doc'] = cnDoc;
    data['cn_ref'] = cnRef;
    data['cn_key'] = cnKey;
    data['complete'] = complete;
    data['lastupload'] = lastupload;
    data['duplicate_key'] = duplicateKey;
    data['validate_failed'] = validateFailed;
    data['validate_remark'] = validateRemark;
    data['last_validate'] = lastValidate;
    data['dbcode'] = dbcode;
    return data;
  }
}

class UpdateSalesOrderScheduleDeliveryDateRequest {
  String? wsCodeCrypt;
  String? caUid;
  String? caPwd;
  String? userId;
  String? docDoc;
  String? docRef;
  String? key;
  String? scheduleDeliveryDateString;

  UpdateSalesOrderScheduleDeliveryDateRequest(
      {this.wsCodeCrypt,
      this.caUid,
      this.caPwd,
      this.userId,
      this.docDoc,
      this.docRef,
      this.key,
      this.scheduleDeliveryDateString});

  UpdateSalesOrderScheduleDeliveryDateRequest.fromJson(
      Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    userId = json['userId'];
    docDoc = json['docDoc'];
    docRef = json['docRef'];
    key = json['key'];
    scheduleDeliveryDateString = json['scheduleDeliveryDateString'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wsCodeCrypt'] = wsCodeCrypt;
    data['caUid'] = caUid;
    data['caPwd'] = caPwd;
    data['userId'] = userId;
    data['docDoc'] = docDoc;
    data['docRef'] = docRef;
    data['key'] = key;
    data['scheduleDeliveryDateString'] = scheduleDeliveryDateString;
    return data;
  }
}
