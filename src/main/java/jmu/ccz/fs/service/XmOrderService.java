package jmu.ccz.fs.service;

import jmu.ccz.fs.pojo.XmOrder;
import java.util.List;

public interface XmOrderService {

    /**
     * 新增订单
     */
    boolean addOrder(XmOrder order);



    /**
     * 查询所有订单
     */

    List<XmOrder> getAllOrders();
}
