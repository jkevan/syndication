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

<template:addResources type="css" resources="01web.css,codemirror/codemirror.css,jquery.fancybox.css,syndication.css"/>
<template:addResources type="javascript" resources="jquery.min.js,jquery-ui.min.js,jquery.fancybox.js,codemirror/lib/codemirror.js"/>

<template:addResources type="javascript" resources="codemirror/mode/xml/xml.js"/>
<template:addResources type="javascript" resources="codemirror/mode/javascript/javascript.js"/>
<template:addResources type="javascript" resources="codemirror/mode/css/css.js"/>
<template:addResources type="javascript" resources="codemirror/mode/htmlmixed/htmlmixed.js"/>

<template:addResources type="javascript" resources="syndication.js" var="syndication_lib"/>

<c:set var="boundComponent"
       value="${uiComponents:getBindedComponent(currentNode, renderContext, 'j:bindedComponent')}"/>

<c:if test="${empty boundComponent && !renderContext.liveMode}">
    <fmt:message key="syndication.label.notBounded"/>
</c:if>

<c:if test="${not empty boundComponent}">
    <c:url value='${url.server}${url.base}${boundComponent.path}.html.ajax' var="content_url"/>
    <c:set var="height" value=""/>
    <c:set var="width" value=""/>
    <c:set var="noFrame" value=""/>
    <c:if test="${not empty currentNode.properties['height']}">
        <c:set var="height"> ,height: '${currentNode.properties['height'].string}'</c:set>
    </c:if>
    <c:if test="${not empty currentNode.properties['width']}">
        <c:set var="width"> ,width: '${currentNode.properties['width'].string}'</c:set>
    </c:if>
    <c:if test="${currentNode.properties['noFrame'].boolean}">
        <c:set var="noFrame"> ,noFrame: true</c:set>
    </c:if>

    <span>
        <a id="embed-link-${currentNode.identifier}" href="#embed-popup-${currentNode.identifier}">
            ${currentNode.displayableName}
        </a>
    </span>

    <div>
        <div id="embed-popup-${currentNode.identifier}" class="syndication">
            <h4><fmt:message key="syndication.popup.title"/> :</h4>

<textarea><script type="text/javascript" src="${url.server}<c:out value="${syndication_lib}"/>"></script>
<script type="text/javascript">
    Jahia.Syndication({
        url: '${content_url}'<c:if test="${not empty height}"><c:out value="${height}"/></c:if> <c:if test="${not empty width}"><c:out value="${width}"/></c:if> <c:if test="${not empty noFrame}"><c:out value="${noFrame}"/></c:if>
    });
</script></textarea>

        </div>
    </div>

    <script type="text/javascript">


        $(document).ready(function () {
            var textarea = CodeMirror.fromTextArea(
                    $("#embed-popup-${currentNode.identifier}").find("textarea").get(0), {
                        mode: "htmlmixed",
                        lineWrapping: true,
                        showCursorWhenSelecting: true,
                        readOnly:true
                    });

            $("#embed-popup-${currentNode.identifier}").hide();
            $("#embed-link-${currentNode.identifier}").fancybox({
                'centerOnScroll': true,
                'overlayOpacity': 0.6,
                'arrows': false,
                'afterShow': function (selectedArray, selectedIndex, selectedOpts) {
                    textarea.execCommand("selectAll");
                }
            });
        });
    </script>
</c:if>