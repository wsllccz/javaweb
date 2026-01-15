package jmu.ccz.fs.mapper;

import jmu.ccz.fs.pojo.ProductInfo;
import jmu.ccz.fs.pojo.ProductInfoExample;
import jmu.ccz.fs.pojo.vo.ProductVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProductInfoMapper {
    int countByExample(ProductInfoExample example);

    int deleteByExample(ProductInfoExample example);

    int deleteByPrimaryKey(Integer pId);
    int deleteByPrimaryKey1(Integer aId);
    int insert(ProductInfo record);

    int insertSelective(ProductInfo record);

    List<ProductInfo> selectByExample(ProductInfoExample example);

    ProductInfo selectByPrimaryKey(Integer pId);

    int updateByExampleSelective(@Param("record") ProductInfo record, @Param("example") ProductInfoExample example);

    int updateByExample(@Param("record") ProductInfo record, @Param("example") ProductInfoExample example);

    int updateByPrimaryKeySelective(ProductInfo record);

    int updateByPrimaryKey(ProductInfo record);

    int reduceStock(@Param("pid") Integer pid,
                    @Param("num") Integer num);

    //实现多条件查询
    public List<ProductInfo> selectConditionSplitPage(ProductVo vo);

    //批量删除
    public int deleteBatch(String[] pids);
}