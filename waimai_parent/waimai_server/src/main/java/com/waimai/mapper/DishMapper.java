package com.waimai.mapper;

import com.github.pagehelper.Page;
import com.waimai.annotation.AutoFill;
import com.waimai.constant.AutoFillConstant;
import com.waimai.dto.DishPageQueryDTO;
import com.waimai.entity.Dish;
import com.waimai.vo.DishItemVO;
import com.waimai.vo.DishVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface DishMapper {

    //根据分类id查询对应的菜品数量
    Long cuntByCategoryId(Long id);

    //插入数据到菜品表
    @AutoFill(type = AutoFillConstant.INSERT)
    void insert(Dish dish);

    //菜品信息分页查询
    Page<DishVO> PageQuery(DishPageQueryDTO dishPageQueryDTO);

    //根据id查询所有菜品
    Dish selectById(Long dishId);

    //根据id删除菜品
    void deleteById(Long dishId);

    //根据id查询菜品和关联的口味
    DishVO getByIdWithFlavor(Long id);

    //更新菜品数据
    @AutoFill(type = AutoFillConstant.UPDATE)
    void update(Dish dish);

    //根据分类id,状态码，菜品名 查询菜品信息
    List<Dish> list(Dish dish);

    //根据套餐id查询菜品
    List<Dish> getBySetmealId(Long setmealId);


    //动态条件查询菜品和口味
    List<DishVO> listWithFlavor(Dish dish);

    //根据套餐id查询菜品选项
    List<DishItemVO> getDishItemBySetmealId(Long setmealId);

    /**
     * 根据条件统计菜品数量
     * @param map
     * @return
     */
    Integer countByMap(Map map);
}
