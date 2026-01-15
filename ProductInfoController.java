package jmu.ccz.fs.controller;

import jmu.ccz.fs.pojo.ProductInfo;
import jmu.ccz.fs.pojo.vo.ProductVo;
import jmu.ccz.fs.service.ProductInfoService;
import jmu.ccz.fs.utils.FileNameUtil;
import com.github.pagehelper.PageInfo;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.Date;

@Controller
@RequestMapping("/prod")
public class ProductInfoController {

    public static final int PAGE_SIZE = 5;
    public String saveFileName = "";

    @Autowired
    public ProductInfoService pservice;

    //分页显示
    @RequestMapping("/split")
    public String split(
            @RequestParam(value = "page", defaultValue = "1")
                    Integer page, Model model) {
        PageInfo info = pservice.splitPage(page, PAGE_SIZE);
        model.addAttribute("pb", info);

        return "product";

    }

    @RequestMapping("/split1")
    public String split1(
            @RequestParam(value = "page", defaultValue = "1")
            Integer page, Model model) {
        PageInfo info = pservice.splitPage(page, PAGE_SIZE);
        model.addAttribute("pb", info);

        return "product1";

    }


    @ResponseBody
    @RequestMapping("/ajaxsplit")
    public void ajaxsplit(ProductVo vo, HttpSession session) {
        PageInfo info = pservice.splitPageVo(vo, PAGE_SIZE);
        session.setAttribute("pb", info);
        saveFileName = "";
        return ;
    }


    @ResponseBody
    @RequestMapping(value = "/dajaxsplit",produces = "text/html;charset=UTF-8")
    public Object dajaxsplit(ProductVo vo, HttpSession session) {
        PageInfo info = pservice.splitPageVo(vo, PAGE_SIZE);
        session.setAttribute("pb", info);
        saveFileName = "";

        String s=session.getAttribute("msg").toString();
        JSONObject object=new JSONObject();
        object.put("msg",s);
        return object.toString();
    }
    @RequestMapping("/delete")
    public String delete(Integer pid, HttpSession session) {
        int num = pservice.delete(pid);
        if (num > 0)
            session.setAttribute("msg", "删除成功！");
        else
            session.setAttribute("msg", "删除失败！");

        //增删改后用重定向跳转
        return "forward:/prod/dajaxsplit.action";
    }

    @RequestMapping("/deleteBatch")
    public String deleteBatch(String pids, HttpSession session) {
        String []ps=pids.split(",");
        try {
            int num = pservice.deleteBatch(ps);
            if (num > 0)
                session.setAttribute("msg", "删除成功！");
            else
                session.setAttribute("msg", "删除失败！");
        } catch (Exception e) {

            session.setAttribute("msg","商品不可删除！");
        }

        //增删改后用重定向跳转
        return "forward:/prod/dajaxsplit.action";
    }
    @ResponseBody
    @RequestMapping("/ajaxImg")
    public Object ajaxImg(MultipartFile pimage,HttpServletRequest request){
            //要进行文件上传操作
            //取文件名
            saveFileName = FileNameUtil.getUUIDFileName() + FileNameUtil.getFileType(pimage.getOriginalFilename());
            //取路径
            try {
                String path = request.getServletContext().getRealPath("/image_big");
                //转存
                pimage.transferTo(new File(path + File.separator + saveFileName));
            } catch (Exception e) {
                e.printStackTrace();
            }

            //为了在客户端显示图片，要将存储的文件名回传下去，由于是自定义的上传插件，所以此处要手工处理JSON
            JSONObject object = new JSONObject();
            object.put("imgurl",saveFileName);
        return object.toString();
    }
    @RequestMapping("/one")
    public String one(Integer pid,Integer page, Model model) {
        ProductInfo info = pservice.getById(pid);
        model.addAttribute("prod", info);
        model.addAttribute("page",page);
        return "update";
    }
    //执行增加操作
    @RequestMapping("/save")
    public String save(ProductInfo info, HttpServletRequest request) {

        info.setpImage(saveFileName);
        info.setpDate(new Date());

        int num = -1;
        try {
            num = pservice.save(info);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (num > 0)
            request.getSession().setAttribute("msg", "增加成功！");
        else
            request.getSession().setAttribute("msg", "增加失败!");

        saveFileName="";
        return "redirect:/prod/split.action";
    }

    //更新操作
    @RequestMapping("/update")
    public String update(ProductInfo info,Integer page,HttpServletRequest request) {

        //因为是修改，所以要判断有没有点文件上传的铵钮
        if(!saveFileName.equals("")){
            info.setpImage(saveFileName);
        }

        boolean flag = false;

        if (info.getpDate() != null) {
            if (info.getpDate().getTime() > System.currentTimeMillis()) {
                //日期不正常了，则置为空，底层做更新处理时不做更改
                info.setpDate(null);
                flag=true;
            }
        }
        int num = -1;
        try {
            num = pservice.update(info);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (num > 0) {
            if (flag) {
                request.getSession().setAttribute("msg", "日期不能大于当前日期");
            } else {
                request.getSession().setAttribute("msg", "更新成功！");
            }
        } else {
            request.getSession().setAttribute("msg", "更新失败");
        }
        saveFileName="";
        return "redirect:/prod/split.action?page="+page;
    }



}