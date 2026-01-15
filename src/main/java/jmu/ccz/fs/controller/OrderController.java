package jmu.ccz.fs.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jmu.ccz.fs.pojo.CartShop;
import jmu.ccz.fs.pojo.Customer;
import jmu.ccz.fs.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private CartService cartService;

    @RequestMapping("/addToCart")
    public String addToCart(Integer pId,
                            Integer quantity,
                            HttpSession session) {

        Customer customer = (Customer) session.getAttribute("customer");
        Integer uid = customer.getcId();
        System.out.println("UID=" + uid + ", PID=" + pId + ", QUANTITY=" + quantity);


        boolean success = cartService.addToCart(uid, pId, quantity);

        session.setAttribute("msg", success ? "加入购物车成功！" : "库存不足，加入失败！");

        return "product1";
    }

    @RequestMapping("/list")
    public String list(@RequestParam(value = "page", defaultValue = "1") Integer page,
                       HttpSession session,
                       Model model) {

        int pageSize = 12;
        PageHelper.startPage(page, pageSize);

        List<CartShop> list = cartService.getAllCart();
        PageInfo<CartShop> pb = new PageInfo<>(list);

        model.addAttribute("pb", pb);
        return "carshop";

        model.deletAttribute("pb", pb);
        return "carshop";
    }
}
