<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<!--
     @desc “此代码是自动生成，请继续优化注释”
	 @author ${model.createUserName?if_exists}
	 @version 1.0.0
	 @date ${model.createTime}
	 @Copyright: 江苏金恒信息科技股份有限公司
 -->
<mapper namespace="${daoName}">
	<!-- 查询所有记录 过滤公司别 -->
	<select id="findAll" parameterType="map" resultType="${model.className}">
		select 
			${selectContent}${model.blockCode?if_exists}
		from ${model.tableName}
		<where>
			<if test="currentCompany != null and currentCompany != ''">
				and companyId = ${currentCompany}
			</if>
			${lookupCondition}
		</where>
   		order by createDateTime desc
	</select>
	
	<!-- 查询所有记录 过滤公司别 -->
	<select id="getCount" resultType="int" parameterType="map">
		select count(id) from ${model.tableName}
		<where>
			<if test="currentCompany != null and currentCompany != ''">
				and companyId = ${currentCompany}
			</if>
			${lookupCondition}
		</where>
	</select>
	
	<!-- 根据ID查询记录 -->
	<select id="findOneById" parameterType="String" resultType="${model.className}">
		select 
			${findOneContent}
		from ${model.tableName}
		where id = ${id}
	</select>
	
	<!-- 添加记录 -->
	<insert id="create" parameterType="${model.className}">
		${insertSql}
	</insert>
	
	<!-- 修改记录 -->
	<update id="update" parameterType="${model.className}">
		update ${model.tableName}
		<set>
			${updateContent}
			<if test="updateUser != null">
				updateUserId = ${r"#{updateUser.id}"},
			</if>
			<if test="updateDateTime != null and updateDateTime != ''">
				updateDateTime = ${r"#{updateDateTime}"},
			</if>
			<if test="intIsActive != null and intIsActive != ''">
				intIsActive = ${r"#{intIsActive}"},
			</if>
			<if test="intIsDelete != null and intIsDelete != ''">
				intIsDelete = ${r"#{intIsDelete}"}
			</if>
		</set>
		<where>
			id = ${id}
		</where>
	</update>
	
	<!-- 删除记录 -->
	<delete id="delete" parameterType="String">
		delete from ${model.tableName} where id = ${id}
	</delete>
</mapper>