package com.qcz.qmplatform.module.system.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.qcz.qmplatform.common.utils.StringUtils;
import com.qcz.qmplatform.module.system.domain.Role;
import com.qcz.qmplatform.module.system.domain.RolePermission;
import com.qcz.qmplatform.module.system.mapper.RoleMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author quchangzhong
 * @since 2020-09-03
 */
@Service
public class RoleService extends ServiceImpl<RoleMapper, Role> {

    @Autowired
    private RolePermissionService rolePermissionService;

    public List<Role> getRoleList(Role role) {
        QueryWrapper<Role> wrapper = new QueryWrapper<>();
        String roleName = role.getRoleName();
        wrapper.like(StringUtils.isNotBlank(roleName), "role_name", roleName);
        return list(wrapper);
    }

    public boolean addRoleOne(Role role) {
        role.setRoleId(StringUtils.uuid());
        return save(role);
    }

    public boolean updateRoleOne(Role role) {
        return updateById(role);
    }

    public boolean deleteRole(List<String> roleIds) {
        return removeByIds(roleIds);
    }

    public boolean saveRoleOne(Role role) {
        if (StringUtils.isBlank(role.getRoleId())) {
            return addRoleOne(role);
        }
        return updateRoleOne(role);
    }

    public boolean saveRolePermission(String roleId, List<String> permissionIds) {
        QueryWrapper<RolePermission> wrapper = new QueryWrapper<>();
        wrapper.eq("role_id", roleId);
        rolePermissionService.remove(wrapper);

        List<RolePermission> saveRolePermissions = new ArrayList<>();
        for (String permissionId : permissionIds) {
            RolePermission rolePermission = new RolePermission();
            rolePermission.setRoleId(roleId);
            rolePermission.setPermissionId(permissionId);
            saveRolePermissions.add(rolePermission);
        }
        return rolePermissionService.saveBatch(saveRolePermissions, saveRolePermissions.size());
    }

    public List<String> getRolePermission(String roleId) {
        return baseMapper.getPermissionIdsByRoleId(roleId);
    }
}
