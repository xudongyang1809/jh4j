package com.nisco.${model.packageName}.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.nisco.${model.packageName}.entity.${model.className}Entity;
import com.nisco.dms.entity.Page;

/**
 * @desc “此代码是自动生成，请继续优化注释”
 * @author ${model.createUserName?if_exists}
 * @version 1.0.0
 * @date ${model.createTime}
 * @Copyright: 江苏金恒信息科技股份有限公司
 */
@Repository
public class ${model.className}Dao {
	@Autowired
	private SqlSession sqlSession;
	
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
		List<${model.className}Entity> list = new ArrayList<${model.className}Entity>();
		if (page != null) {
			list = sqlSession.selectList("${model.className}Dao.findAll", keywords, new RowBounds(page.getPageBeginCount(), page.getNumPerPage()));
			page.setTotalCount(getCount(keywords));
		} else {
			list = sqlSession.selectList("${model.className}Dao.findAll", keywords);
		}
		return list;
	}
	
	/**
	 * @desc 根据条件查询数量
	 * @author ${model.createUserName?if_exists}
	 * @date ${model.createTime}
	 * @param keywords
	 * @return
	 * @throws Exception
	 */
	public int getCount(Map<String, Object> keywords) throws Exception {
		return sqlSession.selectOne("${model.className}Dao.getCount", keywords);
	}
	
	/**
	 * @desc 创建
	 * @author ${model.createUserName?if_exists}
	 * @date ${model.createTime}
	 * @param ${model.blockCode}
	 * @return
	 * @throws Exception
	 */
	public int create(${model.className}Entity ${model.blockCode}) throws Exception {
		return sqlSession.insert("${model.className}Dao.create", ${model.blockCode});
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
		return sqlSession.selectOne("${model.className}Dao.findOneById", id);
	}
	
	/**
	 * @desc 更新
	 * @author ${model.createUserName?if_exists}
	 * @date ${model.createTime}
	 * @param ${model.blockCode}
	 * @return
	 * @throws Exception
	 */
	public int update(${model.className}Entity ${model.blockCode}) throws Exception {
		return sqlSession.update("${model.className}Dao.update", ${model.blockCode});
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
		return sqlSession.delete("${model.className}Dao.delete", id);
	}
}