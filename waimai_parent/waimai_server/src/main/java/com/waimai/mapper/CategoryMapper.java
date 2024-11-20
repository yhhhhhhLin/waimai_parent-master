package com.waimai.mapper;


import com.github.pagehelper.Page;
import com.waimai.annotation.AutoFill;
import com.waimai.constant.AutoFillConstant;
import com.waimai.dto.CategoryPageQueryDTO;
import com.waimai.entity.Category;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * @author linzz
 */
@Mapper
public interface CategoryMapper {

    //新增分类
    @AutoFill(type = AutoFillConstant.INSERT)
    void insert(Category category);

    //分类信息分页查询
    Page<Category> pageQuery(CategoryPageQueryDTO categoryPageQueryDTO);

    //删除分类
    void deleteById(Long id);

    @AutoFill(type = AutoFillConstant.UPDATE)
    //修改分类
    void update(Category category);

    //根据类型查询分类
    List<Category> list(Integer type);
}
