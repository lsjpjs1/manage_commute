<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8"); 
	
		String sym[] = {"ꃃꂽꃓꂿꃰꂴꃌꂳꃦꃥꃆꃁꄍꄉꄺꄖ","ⅠⅡⅢⅣⅤ","①②③④⑤⑥⑦⑧⑨⑩⑪⑫⑬⑭⑮⑯⑰⑱⑲⑳\u3251\u3252\u3253\u3254\u3255\u3256\u3257\u3258\u3259\u325A\u325B\u325C\u325D\u325E\u325F\u32B1\u32B2\u32B3\u32B4\u32B5\u32B6\u32B7\u32B8\u32B9\u32BA\u32BB\u32BC\u32BD\u32BE\u32BF","➊➋➌➍➎➏➐➑➒➓","㉠㉡㉢㉣㉤㉥㉦㉧㉨㉩","㉮㉯㉰㉱㉲㉳㉴㉵㉶㉷","⑴⑵⑶⑷⑸⑹⑺⑻⑼⑽","☞〜‘’“”±∃『』｢｣≪≫◀▶◁▷¶☆【】〔〕Ⅹ"};
						
	%>
		<HTML>
		
		<HEAD>
			<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
			<TITLE>부호 목록</TITLE>
			<STYLE type="text/css"> 
			<!--
			    BODY  { font-family:바탕; 
			            font-size:14px;
			            color:#3C3C3C;
			            background-color:#FFFAFA;
			          }
			          
                TABLE { width:100%; 
                        margin: 0px; 
                        padding: 0px; 
                        border-collapse: collapse;
                        border-width:1px; 
                        background-color:#FFFFFF;
                      }
                      
                TD    { 
                        padding:5px; 
                        border-style:solid;
                        border-width:1px;
                        border-color:#E0E0E0;
                        font-size:14px;
                        background-color:#FFFAFA;
                      }
				
				INPUT { width:30px; 
				        height:30px; 
				        font-family:한컴돋움; 
				        font-size:18px; 
				        color:#008080; 
				      }
			--> 
			</STYLE>		
		</HEAD>
		
		
		
		<BODY>
		
			
					    <FORM method="post" name = "symForm">
						    <%
							for(int i=0 ; i<sym[2].length() ; i++) {
								if(i<20){
							%>
								<INPUT type="button" name="sym"  onclick="javascript:sendSymbol('<%=sym[2].charAt(i)%>')" value="<%=sym[2].charAt(i)%>">
							<%
								}else{
						    %>
						    	<!--  <button type="button" name="sym" style="font-family:바탕;" onclick="javascript:sendSymbol('<%=sym[2].charAt(i)%>')"  value="<%=sym[2].charAt(i)%>"></button>-->
						    	<INPUT type="button" name="sym" style="font-family:바탕;" onclick="javascript:sendSymbol('<%=sym[2].charAt(i)%>')" value="<%=sym[2].charAt(i)%>">
						    <%
								}
							}
						    %>>
    					</FORM>
					<%=sym[2] %>>
		</BODY>
		</HTML>
	
		