package com.nisco.${model.packageName}.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nisco.${model.packageName}.entity.${model.className}Entity;
import com.nisco.${model.packageName}.service.${model.className}Service;
import com.nisco.dms.util.ControllerUtil;
import com.nisco.dms.util.DateTools;
import com.nisco.dms.util.UUIDUtil;
import com.nisco.dms.entity.AjaxObject;
import com.nisco.dms.entity.Page;

/**
 * @desc “此代码是自动生成，请继续优化注释”
 * @author ${model.createUserName?if_exists}
 * @version 1.0.0
 * @date ${model.createTime}
 * @Copyright: 江苏金恒信息科技股份有限公司
 */
@Controller
@RequestMapping(value = "/${model.className?uncap_first}")
public class ${model.className}Controller {
	private Logger logger = Logger.getLogger(${model.className}Controller.class);
	
	private static final String LIST = "${model.className?uncap_first}/list";
	private static final String CREATE = "${model.className?uncap_first}/create";
	private static final String UPDATE = "${model.className?uncap_first}/update";
	
	@Autowired
	private ${model.className}Service ${model.className?uncap_first}Service;
	
	private static String moduleListNavId = "";
	
    /**
	 * 根据条件查询数据并获取业务列表界面
	 * @author：${model.createUserName?if_exists}
	 * @date: ${model.createTime?if_exists}
	 * @param page
	 * @param ${model.className?uncap_first}
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/list")
	public String list(Page page, ${model.className}Entity ${model.className?uncap_first}, Model model, HttpServletRequest request) {
		Map<String,Object> keyMap = new HashMap<String, Object>();
		try {
			moduleListNavId = ControllerUtil.navId(moduleListNavId, (String) request.getParameter("moduleListNavId"));
			ControllerUtil controllerUtil = new ControllerUtil();
			keyMap.put("currentCompany", controllerUtil.currentCompany().getId());
			${lookupCondition}
			model.addAttribute("list", ${model.className?uncap_first}Service.findAll(page, keyMap));
			model.addAttribute("${model.className?uncap_first}", ${model.className?uncap_first});
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage(), e);
		}
		return LIST;
	}
	
	/**
	 * <p>打开新增画面</p>
	 * @author：${model.createUserName?if_exists}
	 * @date: ${model.createTime}
	 * @return
	 */
	@RequestMapping(value = "/preCreate")
	<#if isHasAttach?if_exists=="1">
	public String preCreate(Model model) {
		model.addAttribute("id", UUIDUtil.getUUID());
		return CREATE;
	}
	</#if>
	<#if isHasAttach?if_exists=="0">
	public String preCreate() {
		return CREATE;
	}
	</#if>
	
	/**
	 * <p>新增</p>
	 * @author：${model.createUserName?if_exists}
	 * @date:${model.createTime}
	 * @param ${model.className?uncap_first}
	 * @return
	 */
	@RequestMapping(value = "/create")
	public @ResponseBody String create(${model.className}Entity ${model.className?uncap_first}) {
		AjaxObject ajaxObject = new AjaxObject();
		ControllerUtil controller = new ControllerUtil();
		try {
			<#if isHasAttach?if_exists=="0">
			${model.className?uncap_first}.setId(UUIDUtil.getUUID());
			</#if>
			${model.className?uncap_first}.setCompany(controller.currentCompany());
			${model.className?uncap_first}.setCreateUser(controller.currentUser());
			${model.className?uncap_first}.setCreateDateTime(DateTools.getFullNowDateTime());
			if (${model.className?uncap_first}Service.create(${model.className?uncap_first}) == 1) {
				ajaxObject.setMessage("添加成功");	
			} else {
				ajaxObject.setCallbackType("");
				ajaxObject.setStatusCode(AjaxObject.STATUS_CODE_FAILURE);
				ajaxObject.setMessage("添加失败");
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage(), e);
			ajaxObject.setCallbackType("");
			ajaxObject.setStatusCode(AjaxObject.STATUS_CODE_FAILURE);
			ajaxObject.setMessage("系统错误，添加失败");
		}
		ajaxObject.setNavTabId(moduleListNavId);
		return ajaxObject.toString();
	}
	
	/**
	 * <p>弹出修改界面</p>
	 * @author：${model.createUserName?if_exists}
	 * @date: ${model.createTime}
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/preUpdate/{id}")
	public String preUpdate(Model model, @PathVariable(value = "id") String id) {
		try {
			model.addAttribute("${model.className?uncap_first}", ${model.className?uncap_first}Service.findOneById(id));
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage(), e);
		}
		return UPDATE;
	}
	
	/**
	 * <p>修改 </p>
	 * @author：${model.createUserName?if_exists}
	 * @date: ${model.createTime}
	 * @param pmTeam
	 * @return
	 */
	@RequestMapping(value = "/update")
	public @ResponseBody String update(${model.className}Entity ${model.className?uncap_first}) {
		AjaxObject ajaxObject = new AjaxObject();
		try {
			ControllerUtil controllerUtil = new ControllerUtil();
			${model.className?uncap_first}.setUpdateUser(controllerUtil.currentUser());
			${model.className?uncap_first}.setUpdateDateTime(DateTools.getFullNowDateTime());
			if (${model.className?uncap_first}Service.update(${model.className?uncap_first}) == 1) {
				ajaxObject.setMessage("修改成功");
			} else {
				ajaxObject.setCallbackType("");
				ajaxObject.setStatusCode(AjaxObject.STATUS_CODE_FAILURE);
				ajaxObject.setMessage("修改失败");
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage(), e);
			ajaxObject.setCallbackType("");
			ajaxObject.setStatusCode(AjaxObject.STATUS_CODE_FAILURE);
			ajaxObject.setMessage("系统错误，修改失败");
		}
		ajaxObject.setNavTabId(moduleListNavId);
		return ajaxObject.toString();
	}
	
	/**
	 * <p>删除 </p>
	 * @author：${model.createUserName?if_exists}
	 * @date: ${model.createTime}
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/delete/{id}")
	public @ResponseBody String delete(@PathVariable(value = "id") String id) {
		AjaxObject ajaxObject = new AjaxObject();
		try {
			if (${model.className?uncap_first}Service.delete(id) == 1) {
				ajaxObject.setMessage("删除成功");
			} else {
				ajaxObject.setStatusCode(AjaxObject.STATUS_CODE_FAILURE);
				ajaxObject.setMessage("删除失败");			
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage(), e);
			ajaxObject.setStatusCode(AjaxObject.STATUS_CODE_FAILURE);
			ajaxObject.setMessage("系统错误，删除失败");
		}
		ajaxObject.setCallbackType("");
		ajaxObject.setNavTabId(moduleListNavId);
		return ajaxObject.toString();
	}
}