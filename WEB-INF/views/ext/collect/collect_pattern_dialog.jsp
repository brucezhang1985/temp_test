<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="f" uri="http://www.jspxcms.com/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>广元阳光舞校管理平台</title>
<jsp:include page="/WEB-INF/views/commons/head.jsp"></jsp:include>
<style type="text/css">
html,body{height:100%;}
</style>
<script type="text/javascript">
var pd = window.opener.document;
var isFirst = true;
$(function() {
	<c:if test="${!empty areaId}">
  $("#areaPattern").val($("#${areaId}Pattern",pd).val());
  $("#areaReg").prop("checked", $("#${areaId}Reg",pd).prop("checked"));
  </c:if>
  <c:if test="${!empty itemId}">
  $("#itemPattern").val($("#${itemId}Pattern",pd).val());
  $("#itemReg").prop("checked", $("#${itemId}Reg",pd).prop("checked"));
  </c:if>
  <c:if test="${!empty filterId}">
  $("#filter").val($("#${filterId}",pd).val());
  </c:if>
	urlsChange();
});
function urlsChange() {
	$("#url").val($("#urls").val());
	fetchUrl();
}
function filterText(filter) {
  var source = $("#source").val();
  $.post("filter_text.do",{
    source: source,
    filter: filter
  },function(data) {
    $("#source").val(data);
  });
}
function findText(search,isFirst,isReg) {
  var source = $("#source").val();
  $.post("find_text.do",{
    source: source,
    search: search,
    isFirst: isFirst,
    isReg: isReg
  },function(data) {
    $("#source").val(data);
  });
}
function fetchUrl() {
	var url = $("#url").val();
	if($.trim(url) == "") {
		return;
	}
  $.post("fetch_url.do",{
    url: $("#url").val(),
    userAgent: "${userAgent}",
	  charset: "${charset}"
  },function(data) {
    $("#source").val(data);
  });
}
function submit() {
	<c:if test="${!empty areaId}">
  $("#${areaId}Pattern",pd).val($("#areaPattern").val());
  $("#${areaId}Reg",pd).prop("checked", $("#areaReg").prop("checked"));
  $("#_chk_${areaId}Reg",pd).val($("#areaReg").prop("checked"));
  </c:if>
  <c:if test="${!empty itemId}">
  $("#${itemId}Pattern",pd).val($("#itemPattern").val());
  $("#${itemId}Reg",pd).prop("checked", $("#itemReg").prop("checked"));
  $("#_chk_${itemId}Reg",pd).val($("#itemReg").prop("checked"));
  </c:if>
  <c:if test="${!empty filterId}">
  $("#${filterId}",pd).val($("#filter").val());
  </c:if>
  window.close();
}
</script>
</head>
<body>
<table width="100%" height="100%" style="" cellpadding="0" cellspacing="0" border="0">
  <tr>
    <td height="60" colspan="2" style="padding:0 2px;">
      <div>
	      <select id="urls" style="width:800px;" onchange="urlsChange();">
          <c:forEach var="url" items="${urls}">
	        <option>${url}</option>
	        </c:forEach>
	      </select>
      </div>
      <div>
        <input id="url" type="text" style="width:800px;"/>
        <input type="button" value="<s:message code='fetch'/>" onclick="fetchUrl();"/>
      </div>
    </td>
  </tr>
  <tr>
    <td width="50%" height="100%" valign="top" style="padding:0 2px;">
      <textarea id="source" spellcheck="false" wrap="off" style="width:98%;height:550px;"></textarea>
    </td>
    <td width="50%" valign="top">
      <c:if test="${!empty areaId}">      
			<script type="text/javascript">
			isFirst = false;
			</script>
      <div style="margin-top:10px;"><s:message code="collect.areaHtml"/>:</div>
      <div style="margin-top:5px;">
        <textarea id="areaPattern" spellcheck="false" wrap="off" style="width:95%;height:80px;"></textarea>
      </div>
      <div style="margin-top:5px;">
        <label><input type="checkbox" id="areaReg" name="areaReg"/><s:message code="collect.isReg"/></label>
        <input type="button" value="<s:message code='collect.match'/>" onclick="findText($('#areaPattern').val(),true,$('#areaReg').prop('checked'));"/>
      </div>
      </c:if>
      <div style="margin-top:10px;"><s:message code="collect.itemHtml"/>:</div>
      <div style="margin-top:5px;">
        <textarea id="itemPattern" spellcheck="false" wrap="off" style="width:95%;height:80px;"></textarea>
      </div>
      <div style="margin-top:5px;">
        <label><input type="checkbox" id="itemReg" name="itemReg"/><s:message code="collect.isReg"/></label>
        <input type="button" value="<s:message code='collect.match'/>" onclick="findText($('#itemPattern').val(),isFirst,$('#itemReg').prop('checked'));"/>
      </div>
      <c:if test="${!empty filterId}">
      <div style="margin-top:10px;"><s:message code="collect.filter"/>:</div>
      <div style="margin-top:5px;">
        <textarea id="filter" spellcheck="false" wrap="off" style="width:95%;height:80px;"></textarea>
      </div>
      <div style="margin-top:5px;">
        <input type="button" value="<s:message code='filter'/>" onclick="filterText($('#filter').val());"/>
      </div>
      </c:if>
      <div style="margin-top:10px;">
        <input type="button" value="<s:message code='ok'/>" onclick="submit();"/> &nbsp;
      </div>
    </td>
  </tr>
</table>
</body>
</html>