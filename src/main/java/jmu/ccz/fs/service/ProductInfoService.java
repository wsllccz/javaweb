package jmu.ccz.fs.service;

import jmu.ccz.fs.pojo.ProductInfo;
import jmu.ccz.fs.pojo.vo.ProductVo;
import com.github.pagehelper.PageInfo;


import java.util.List;


public interface ProductInfoService {
    //查所有
    public List<ProductInfo> getAll();
    //根据主键查商品
    public ProductInfo getById(Integer pid);
    //增加
    public int save(ProductInfo info);
    //删除
    public int delete(Integer pid);
    //修改
    public int update(ProductInfo info);
    //分页
    public PageInfo splitPage(int page, int pageSize);
//多条件分页查询
    public PageInfo<ProductInfo> splitPageVo(ProductVo vo, int pageSize);
    //批量删除
    public int deleteBatch(String[] pids);



}
