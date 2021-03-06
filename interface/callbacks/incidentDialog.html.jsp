<%@page contentType="text/html; charset=UTF-8"%>
<%@include file="../../framework/includes/packageInitialization.jspf"%>
<%
    if (context == null) {
        ResponseHelper.sendUnauthorizedResponse(response);
    } else {
        String id = request.getParameter("id");
        String templateId = request.getParameter("templateId");
        BridgeConnector connector = new KsrBridgeConnector(context, templateId);
        Map<String, String> parameters = new java.util.HashMap<String, String>();
        parameters.put("Submitter", context.getUserName());
        parameters.put("Incident Id", id);
        Record incidentRecord = connector.retrieve("Activity Incident", "By Incident Id", parameters);
        parameters.clear();
        parameters.put("Incident Id", id);
        String[] attributes = new String[]{"Source", "Type", "Created At" };
        RecordList workInfoRecords = connector.search("Activity Incident Work Info", "By Incident Id", parameters, attributes);
        out.clear();
%>
<div class="sourceDetails" title="Incident Details">
    <div class="header">
        <div class="id"><%= id%></div>
        <div class="close"></div>
        <div class="clear"></div>
    </div>
    <div class="info">
        <div class="label">Status</div>
        <div class="value"><%= incidentRecord.get("Status")%></div>
        <div class="clear"></div>
        <div class="label">Status Reason</div>
        <div class="value"><%= incidentRecord.get("Status Reason")%></div>
        <div class="clear"></div>
        <div class="label">Created At</div>
        <div class="value dateTime"><%= incidentRecord.get("Created At")%></div>
        <div class="clear"></div>
        <div class="label">Updated At</div>
        <div class="value dateTime"><%= incidentRecord.get("Created At")%></div>
        <div class="clear"></div><div class="label">Summary</div>
        <div class="value"><%= incidentRecord.get("Summary")%></div>
        <div class="clear"></div>
    </div>
    <div class="workLog">
        <% CycleHelper zebraCycle = new CycleHelper(new String[]{"odd", "even"});%>
        <% for (Record workInfo : workInfoRecords) { %>
        <div class="workInfo <%= zebraCycle.cycle()%>">
            <div class="label">Source</div>
            <div class="value"><%= workInfo.get("Source")%></div>
            <div class="clear"></div>
            <div class="label">Type</div>
            <div class="value"><%= workInfo.get("Type")%></div>
            <div class="clear"></div>
        </div>
        <% } %>
    </div>
</div>
<%
    }
%>