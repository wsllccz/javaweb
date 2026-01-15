package jmu.ccz.fs.pojo;

import java.util.Date;

public class XmOrder {

    private String oid;
    private Integer uid;
    private Integer addressId;
    private Double totalprice;
    private String remarks;
    private String status;
    private Date odate;   // ← 数据库字段 odate

    public String getOid() {
        return oid;
    }

    public void setOid(String oid) {
        this.oid = oid;
    }



    public Integer getAddressId() {
        return addressId;
    }
    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public void setAddressId(Integer addressId) {
        this.addressId = addressId;
    }

    public Double getTotalprice() {
        return totalprice;
    }

    public void setTotalprice(Double totalprice) {
        this.totalprice = totalprice;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    // ⭐⭐⭐ 关键就在这里 ⭐⭐⭐
    public Date getOdate() {
        return odate;
    }

    public void setOdate(Date odate) {
        this.odate = odate;
    }
}
