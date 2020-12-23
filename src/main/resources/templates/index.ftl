<!DOCTYPE html>
<html lang="en">
<#include "./include/include.ftl">
<title>Qu管理平台-首页</title>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">Qu管理平台</div>
        <ul class="layui-nav layui-layout-right" lay-filter="personal">
            <img id="userImg" src="${ctx}${currentUser.photoPath!'/static/common/image/charon.png'}" class="layui-nav-img" layadmin-event>
            <li class="layui-nav-item">
                <a href="javascript:void(0);">
                    <span id="currentUsername">${currentUser.username}</span>
                </a>
                <dl class="layui-nav-child">
                    <dd>
                        <a href="javascript:void(0);" lay-id="personal-basic-info" lay-href="${ctx}/user/personalBasicInfoPage">基本资料</a>
                    </dd>
                    <dd>
                        <a href="javascript:void(0);" lay-id="safe-setting" lay-href="${ctx}/user/safeSettingPage">安全设置</a>
                    </dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="${ctx}/logout">退出</a></li>
            <li class="layui-nav-item">
                <div id="choose-color"></div>
            </li>
        </ul>
    </div>
    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree" lay-filter="menu-tree">
                <#include '/include/menuInclude.ftl'>
            </ul>
        </div>
    </div>

    <!-- 页面标签 -->
    <div class="layui-body">
        <div class="layui-tab" lay-filter="main-tab" lay-allowclose="true">
            <ul class="layui-tab-title">
            </ul>
            <div class="layui-tab-content">
            </div>
        </div>
    </div>

</div>
<link>
<link rel="stylesheet" href="${ctx}/static/index.css"/>
<script>
    layui.use(['element', 'upload'], function () {
        let element = layui.element;
        let upload = layui.upload;
        let tabLayFilter = 'main-tab';
        let classLayuiThis = 'layui-this';
        // 监听菜单导航点击
        element.on('nav(menu-tree)', function (elem) {
            addTab(elem);
        });
        // 监听右上角个人导航点击
        element.on('nav(personal)', function (elem) {
            addTab(elem);
        });
        // 监听选项卡切换
        element.on('tab(' + tabLayFilter + ')', function () {
            let layId = $(this).attr("lay-id");
            $(".layui-nav-item ." + classLayuiThis).removeClass(classLayuiThis);
            $(".layui-nav-item a[lay-id=" + layId + "]").parent().addClass(classLayuiThis);
        });
        // 监听选项卡删除
        element.on('tabDelete(' + tabLayFilter + ')', function () {
            let layId = $(this).parent().attr("lay-id");
            $(".layui-nav-item a[lay-id=" + layId + "]").parent().removeClass(classLayuiThis);
        });

        // 默认选中侧边栏第一个菜单
        $(".layui-side .layui-nav-child a[lay-id]:first").click();

        // 上传头像
        $("#userImg").click(function () {
            top.layer.open({
                type: 2,
                title: '上传头像',
                content: ctx + "/user/uploadUserImgPage",
                area: ['40%', '40%']
            });
        });

        function addTab(elem) {
            let layId = elem.attr("lay-id");
            if (!layId) {
                return;
            }
            // 增加一个tab
            let layHref = elem.attr("lay-href");
            if ($(".layui-tab li[lay-id=" + layId + "]").length === 0) {
                element.tabAdd(tabLayFilter, {
                    title: elem.text(),
                    content: '<iframe src="' + layHref + '" frameborder="0" id="iframe-body-' + layId + '" style="width: 100%;height: 100%;"></iframe>',
                    id: layId
                });
            } else {
                document.getElementById("iframe-body-" + layId).contentWindow.location.reload(true);
            }
            element.tabChange(tabLayFilter, layId);
        }
    });
</script>
</body>
</html>
