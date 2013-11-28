<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="uiComponents" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>
<%--@elvariable id="acl" type="java.lang.String"--%>

<template:addResources type="css" resources="jquery.fancybox.css"/>
<template:addResources type="css" resources="jahia.fancybox-form.css"/>
<template:addResources type="javascript" resources="jquery.min.js,jquery-ui.min.js,jquery.fancybox.js"/>
<c:set var="boundComponent"
       value="${uiComponents:getBindedComponent(currentNode, renderContext, 'j:bindedComponent')}"/>

<c:if test="${empty boundComponent && !renderContext.liveMode}">
    <fmt:message key="syndicate.label.notBounded"/>
</c:if>

<c:if test="${not empty boundComponent}">
    <template:addResources type="inlinejavascript">
        <script type="text/javascript">
            $(document).ready(function () {
                $("#embed-link-${currentNode.identifier}").fancybox({
                    'centerOnScroll': true,
                    'overlayOpacity': 0.6,
                    'arrows': false,
                    'afterShow': function (selectedArray, selectedIndex, selectedOpts) {
                        $("#embed-popup-${currentNode.identifier} textarea").select();
                    }
                });
            });
        </script>
    </template:addResources>

    <c:url value='${url.server}${url.base}${boundComponent.path}.default.html.ajax' var="content_url"/>
    <c:set var="height" value=""/>
    <c:set var="width" value=""/>
    <c:if test="${not empty currentNode.properties['j:height']}">
        <c:set var="height">height="${currentNode.properties['j:height'].string}"</c:set>
    </c:if>
    <c:if test="${not empty currentNode.properties['j:width']}">
        <c:set var="width">width="${currentNode.properties['j:width'].string}"</c:set>
    </c:if>

    <fmt:message key="syndicate.label.integrate.content" var="label">
        <fmt:param value="${boundComponent.displayableName}"/>
    </fmt:message>
    <span>${label}: <a id="embed-link-${currentNode.identifier}" href="#embed-popup-${currentNode.identifier}"><fmt:message key="syndicate.label.generate.content"/></a></span>

    <div style="display: none">
        <div id="embed-popup-${currentNode.identifier}">
            <h3><fmt:message key="syndicate.label.integrate"/> :</h3>
            <textarea rows="4" cols="50"><iframe src="${content_url}" <c:out value="${height} ${width}" escapeXml="false"/>></iframe></textarea>
        </div>
    </div>
</c:if>