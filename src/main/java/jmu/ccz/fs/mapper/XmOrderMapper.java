package jmu.ccz.fs.mapper;

import jmu.ccz.fs.pojo.XmOrder;
import java.util.List;

public interface XmOrderMapper {




    int insert(XmOrder order);

    List<XmOrder> selectAll();

}
