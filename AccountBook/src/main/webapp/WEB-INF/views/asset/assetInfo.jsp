<%@page import="java.util.ArrayList"%>
<%@page import="com.modifyk.accountbook.asset.AssetVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<AssetVO> assetList = (List<AssetVO>)request.getAttribute("assetList");
	List<String> group = new ArrayList<>();
	
	for(int i = 0; i < assetList.size(); i++) {
		if(!group.contains(assetList.get(i).getAstgroup())) {
			group.add(assetList.get(i).getAstgroup());
		}
	}
	%>
	<table>
		<%
		for(int i = 0; i < group.size(); i++) {
			%>
			<tr>
				<td>
					<%= group.get(i) %>
				</td>
			</tr>
			<%
			for(int j = 0; j < assetList.size(); j++) {
			%>
				<%
				if(group.get(i).equals(assetList.get(j).getAstgroup())) {
				%>
					<tr>
						<td style="border: 1px solid lightgray; border-radius: 10px; padding: 20px; width: 200px;">
							<%= assetList.get(j).getAstname() %>
						</td>
					</tr>
				<%				
				}
			}
		}
		%>
	</table>
	<%
%>
