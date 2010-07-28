<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<portlet:defineObjects />

<p style="color:green"><c:out value="${requestScope.message}"/></p>

<script type="text/javascript">
    var editPageUrl = '<portlet:actionURL/>';
    var viewPageUrl = '<portlet:actionURL portletMode="view"/>';
    var isViewVideoViewPortlet = false;
    function onVideoViewPortletFormPost(){
        var frm = document.getElementById('videoViewPortletFrm');
        if(isNaN(frm.videoWidth.value) || isNaN(frm.videoHeight.value)){
            alert("Video width/height is not a number!");
            return false;
        }
        if(isViewVideoViewPortlet){
            frm.action = viewPageUrl;
        }
        return true;
    }

    function setDefaultWidthHeightVideoViewPortlet(){
        var frm = document.getElementById('videoViewPortletFrm');
        frm.videoWidth.value = '425';
        frm.videoHeight.value = '300';
    }
</script>

<form id="videoViewPortletFrm"
        action="<portlet:actionURL/>"
        method="post"
        onsubmit="onVideoViewPortletFormPost();">
    <label for="videoUrl">Video Url: </label> <br/>
    <input type="text" name="videoUrl" value='<c:out value="${requestScope.videoUrl}"/>' size="79"><br/>
    <label for="videoUrl">Video Width: </label> <br/>
    <input type="text" name="videoWidth" value='<c:out value="${requestScope.videoWidth}"/>' size="4"><br/>
    <label for="videoUrl">Video Height: </label> <br/>
    <input type="text" name="videoHeight" value='<c:out value="${requestScope.videoHeight}"/>' size="4"><br/>
    <a href="javascript:setDefaultWidthHeightVideoViewPortlet();">Enter default width and height</a><br/>
    <input type="submit" value="Change!" onclick="isViewVideoViewPortlet=false;"/>
    <input type="submit" value="Change and go to View!" onclick="isViewVideoViewPortlet=true;"/>
</form>
