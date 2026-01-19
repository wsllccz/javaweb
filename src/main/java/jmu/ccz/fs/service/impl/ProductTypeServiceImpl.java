package jmu.ccz.fs.service.impl;


import jmu.ccz.fs.mapper.ProductTypeMapper;
import jmu.ccz.fs.pojo.ProductType;
import jmu.ccz.fs.pojo.ProductTypeExample;
import jmu.ccz.fs.service.ProductTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("ProductTypeServiceImpl")
public class ProductTypeServiceImpl implements ProductTypeService {
    //必有数据访问层的mapper对象

    @Autowired
    private ProductTypeMapper typeMapper;



    @Override
    public List<ProductType> getAllType() {
        return typeMapper.selectByExample(new ProductTypeExample());
    }4




}
