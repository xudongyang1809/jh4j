package com.nisco.${model.packageName}.service;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.nisco.${model.packageName}.entity.${model.className}Entity;
import com.nisco.${model.packageName}.dao.${model.className}Dao;
import com.nisco.dms.entity.Page;

/**
 * @desc “此代码是自动生成，请继续优化注释”
 * @author ${model.createUserName?if_exists}
 * @version 1.0.0
 * @date ${model.createTime}
 * @Copyright: 江苏金恒信息科技股份有限公司
 */
@Service
public class ${model.className}Service {
	@Autowired
	private ${model.className}Dao ${model.className?uncap_first}Dao;
	
	/**
	 * @desc 根据条件查询数据并进行分页
	 * @author ${model.createUserName?if_exists}
	 * @date ${model.createTime}
	 * @param page
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<${model.className}Entity> findAll(Page page, Map<String, Object> keywords) throws Exception {
		return ${model.className?uncap_first}Dao.findAll(page, keywords);
	}
	
	/**
	 * @desc 创建
	 * @author ${model.createUserName?if_exists}
	 * @date ${model.createTime}
	 * @param ${model.blockCode}
	 * @return
	 * @throws Exception
	 */
	public int create(${model.className}Entity ${model.className?uncap_first}) throws Exception {
		return ${model.className?uncap_first}Dao.create(${model.className?uncap_first});
	}

	/**
	 * @desc 根据主键Id查询一条数据
	 * @author ${model.createUserName?if_exists}
	 * @date ${model.createTime}
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public ${model.className}Entity findOneById(String id) throws Exception {
		return ${model.className?uncap_first}Dao.findOneById(id);
	}
	
	/**
	 * @desc 更新
	 * @author ${model.createUserName?if_exists}
	 * @date ${model.createTime}
	 * @param ${model.blockCode}
	 * @return
	 * @throws Exception
	 */
	public int update(${model.className}Entity ${model.className?uncap_first}) throws Exception {
		return ${model.className?uncap_first}Dao.update(${model.className?uncap_first});
	}
	
	/**
	 * @desc 根据主键Id删除一条数据
	 * @author ${model.createUserName?if_exists}
	 * @date ${model.createTime}
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public int delete(String id) throws Exception {
		return ${model.className?uncap_first}Dao.delete(id);
	}
}