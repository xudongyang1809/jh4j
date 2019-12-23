package com.nisco.${model.packageName}.entity;

<#if model.packageName != 'dms'>
import com.nisco.dms.entity.CoreEntity;
</#if>
/**
 * @desc “此代码是自动生成，请继续优化注释”
 * @author ${model.createUserName?if_exists}
 * @version 1.0.0
 * @Date ${model.createTime}
 * @Copyright: 江苏金恒信息科技股份有限公司
 */
public class ${model.className} extends CoreEntity {
${model.blockCode}
}