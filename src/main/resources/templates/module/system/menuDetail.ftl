<!DOCTYPE html>
<html lang="en">
<#include "/include/include.ftl">
<style>
    .layui-form-item label {
        width: 100px;
    }

    .layui-form-item .layui-input-block {
        margin-left: 130px;
    }
</style>
<body class="detail-body">
<div class="layui-fluid">
    <form class="layui-form detail-form" action="javascript:void(0);" lay-filter="menu-form">
        <input type="hidden" name="permissionId">
        <div class="layui-form-item">
            <label class="layui-form-label required">菜单/按钮名称</label>
            <div class="layui-input-block">
                <input type="text" name="permissionName" lay-verify="required" placeholder="请输入菜单/按钮名称" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">权限类型</label>
            <div class="layui-input-block">
                <select id="permissionType" name="permissionType" disabled>
                    <option value="1">菜单</option>
                    <option value="2">按钮</option>
                </select>
            </div>
        </div>
        <div id="display" class="layui-form-item layui-hide">
            <label class="layui-form-label">是否显示</label>
            <div class="layui-input-block">
                <select name="display">
                    <option value="1">是</option>
                    <option value="0">否</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">所属上级</label>
            <div class="layui-input-block">
                <div id="parentId" name="parentId"></div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">权限码</label>
            <div class="layui-input-block">
                <input type="text" name="code" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">图标</label>
            <div class="layui-input-block">
                <input type="text" name="icon" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">URL</label>
            <div class="layui-input-block">
                <input type="text" name="linkUrl" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">排序</label>
            <div class="layui-input-block">
                <input type="number" name="iorder" class="layui-input">
            </div>
        </div>
        <div class="detail-operator">
            <button type="submit" class="layui-btn layui-btn-normal" lay-submit lay-filter="menu-submit">保存</button>
            <button type="submit" class="layui-btn layui-btn-primary" onclick="closeCurrentIframe()">取消</button>
        </div>
    </form>
</div>
<script type="text/javascript">
    let id = "${RequestParameters["id"]}";
    layui.use(['form', 'layer', 'xmSelect'], function () {
        let form = layui.form;
        let layer = layui.layer;
        let xmSelect = layui.xmSelect;
        // 表单数据校验
        form.verify({});

        let detail = {};
        if (id) {
            CommonUtil.getSync(ctx + '/menu/getPermissionOne/' + id, {}, function (result) {
                form.val('menu-form', result.data);
                detail = result.data;
                if (detail.permissionType === 1) {
                    $("#display").removeClass("layui-hide");
                }
            })
        } else {
            // 新增时放开类型禁用
            $("#permissionType").removeAttr("disabled");
            form.render('select');
        }

        // 上级权限数据加载
        let parentIdSelect = xmSelect.render({
            el: '#parentId',
            radio: true,
            clickClose: true,//选中关闭
            tree: {
                strict: false,
                show: true,
                showLine: false,
                clickExpand: false
            },
            height: 'auto',
            prop: {
                value: 'id',
                children: 'childes'
            },
            data: []
        })
        CommonUtil.getAjax(ctx + '/menu/getMenuTree', {
            permissionType: 1,
            permissionId: id
        }, function (result) {
            parentIdSelect.update({
                initValue: [detail.parentId],
                data: result.data
            })
        })

        form.on('submit(menu-submit)', function (data) {
            layer.load(2);
            let parentIds = parentIdSelect.getValue();
            if (parentIds.length > 0) {
                data.field.parentId = parentIds[0].id;
            }
            CommonUtil.postOrPut(id, ctx + '/menu/' + (id ? 'updatePermission' : 'addPermission'), data.field, function (result) {
                top.layer.closeAll();
                LayerUtil.respMsg(result, Msg.SAVE_SUCCESS, Msg.SAVE_FAILURE, () => {
                    reloadParentTable();
                })
            });
            return false;
        });

    });
</script>
</body>
</html>
