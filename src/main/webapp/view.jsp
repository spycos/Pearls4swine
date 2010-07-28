<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<portlet:defineObjects />

<c:choose>
      <c:when test="${not empty errors}">
         <ul style="color:red">
             <c:forEach items="${errors}" var="error">
                 <li><c:out value="${error}"/></li>
             </c:forEach>
        </ul>
      </c:when>
      <c:otherwise>
          <script
            type="text/javascript"
            src='<%=response.encodeURL(request.getContextPath()+"/flowplayer/flowplayer-3.0.5.js")%>'>
          </script>
          <%-- For the div#id we are using the URL. This being an instanciable portlet, could be used multiple times. --%>
          <script type="text/javascript">
            /* Parameters:
             1. div id (we are using the URL in this case)
             2. The flow player .swf URL as string
             3. JSON object for configuring parameters */
            $f('${requestScope.divId}',
                '<%=response.encodeURL(request.getContextPath()+"/flowplayer/flowplayer-3.0.5.swf")%>',
                {
                    clip:{
                        url: '${requestScope.videoUrl}',
                        autoPlay: false
                    }
                });
          </script>

          <div
            <%--href='${requestScope.videoUrl}'--%>
            style='display:block;width:<c:out value="${requestScope.videoWidth}"/>px;height:<c:out value="${requestScope.videoHeight}"/>px;'
            id='${requestScope.divId}'>
          </div>
      </c:otherwise>
</c:choose>