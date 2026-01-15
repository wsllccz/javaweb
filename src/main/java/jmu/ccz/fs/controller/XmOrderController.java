package jmu.ccz.fs.controller;

import jmu.ccz.fs.pojo.XmOrder;
import jmu.ccz.fs.service.XmOrderService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/xmorder")
public class XmOrderController {

    @Autowired
    private XmOrderService xmOrderService;


    @RequestMapping("/list")
    public String list(@RequestParam(value = "page", defaultValue = "1") Integer page,
                       HttpSession session,
                       Model model) {



        int pageSize = 5; // 每页显示数量
        PageHelper.startPage(page, pageSize);

        List<XmOrder> list = xmOrderService.getAllOrders();
        PageInfo<XmOrder> pb = new PageInfo<>(list);

        model.addAttribute("pb", pb);
        return "xmorder";




    }
}
