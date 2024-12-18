package com.waimai.controller.admin;

import com.waimai.dto.SetmealDTO;
import com.waimai.dto.SetmealPageQueryDTO;
import com.waimai.result.PageResult;
import com.waimai.result.R;
import com.waimai.service.SetmealService;
import com.waimai.vo.SetmealVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/admin/setmeal")
@Slf4j
@Api(tags = "套餐管理接口")
public class SetmealController {
    @Autowired
    private SetmealService setmealService;

    /**
     * 新增套餐
     *
     * @param setmealDTO 套餐数据
     * @return success
     */
    @PostMapping
    @ApiOperation("新增套餐")
    @CacheEvict(cacheNames = "setmealCache", allEntries = true)
    public R<String> save(@RequestBody SetmealDTO setmealDTO) {
        log.info("新增套餐:{}", setmealDTO);
        setmealService.saveWithDish(setmealDTO);
        return R.success("套餐添加成功");
    }

    /**
     * 套餐分页查询
     *
     * @param setmealPageQueryDTO 套餐名称，分类id，售卖状态，页数，每页大小
     * @return PageResult 套餐数据
     */
    @GetMapping("/page")
    @ApiOperation("套餐分页查询")
    public R<PageResult> page(SetmealPageQueryDTO setmealPageQueryDTO) {
        log.info("套餐分页查询:{}", setmealPageQueryDTO);
        PageResult pageResult = setmealService.pageQuery(setmealPageQueryDTO);
        return R.success(pageResult);
    }

    /**
     * 批量删除的套餐
     *
     * @param ids 批量删除的套餐id
     * @return success
     */
    @DeleteMapping
    @ApiOperation("批量删除的套餐")
    @CacheEvict(cacheNames = "setmealCache", allEntries = true)
    public R<String> delete(@RequestParam List<Long> ids) {
        log.info("批量删除:{}", ids);
        setmealService.deleteBatch(ids);
        return R.success("删除成功");
    }

    /**
     * id查询套餐
     *
     * @param id 套餐id
     * @return setmealVO 回显修改套餐的数据
     */
    @GetMapping("/{id}")
    @ApiOperation("id查询套餐接口")
    public R<SetmealVO> getById(@PathVariable Long id) {
        log.info("id查询套餐接口:{}", id);
        SetmealVO setmealVO = setmealService.getById(id);
        return R.success(setmealVO);
    }

    /**
     * 修改套餐
     *
     * @param setmealDTO 修改的套餐信息
     * @return success
     */
    @PutMapping
    @ApiOperation("修改套餐")
    @CacheEvict(cacheNames = "setmealCache", allEntries = true)
    public R<String> update(@RequestBody SetmealDTO setmealDTO) {
        log.info("修改套餐:{}", setmealDTO);
        setmealService.update(setmealDTO);
        return R.success("套餐修改成功");
    }

    /**
     * 套餐 启用禁用
     *
     * @param status 套餐状态
     * @param id     套餐id
     * @return success
     */
    @PostMapping("/status/{status}")
    @ApiOperation("套餐 启用禁用")
    @CacheEvict(cacheNames = "setmealCache", allEntries = true)
    public R<String> startOrStop(@PathVariable Integer status, String ids) {
        log.info("套餐 启用禁用:{}", status);
        setmealService.startOrStop(status, ids);
        return R.success("状态修改成功");
    }


}
