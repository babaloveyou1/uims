var mygrid=null;$(function(){mygrid=new dhtmlXGridObject("gridbox");mygrid.setImagePath("codebase/grid_imgs/");mygrid.setHeader("<div style='text-align:center;'>车次&nbsp;&nbsp;</div>,<div style='text-align:center;'>查询区间</div>,#cspan,#cspan,<div style='text-align:center;'>余票信息</div>,#cspan,#cspan,#cspan,#cspan,#cspan,#cspan,#cspan,#cspan,#cspan,#cspan,<div style='text-align:center;'>购票&nbsp;&nbsp;</div>");mygrid.attachHeader("#rspan,发站,到站,历时,商务座,特等座,一等座,二等座,高级软卧,软卧,硬卧,软座,硬座,无座,其他,#rspan");mygrid.setInitWidths("62,96,96,50,50,50,50,50,64,49,49,49,49,49,49,62");mygrid.setColAlign("center,center,center,center,center,center,center,center,center,center,center,center,center,center,center,center");mygrid.setColTypes("ro,ro,ro,ro,ro,ro,ro,ro,ro,ro,ro,ro,ro,ro,ro,ro");mygrid.init();mygrid.enableAlterCss("even","uneven");mygrid.setSkin("light");mygrid.parse(new Array(),"jsarray");dhtmlxError.catchError("parse",function(a,b,data){renameButton("research_u");$("#submitQuery").click(sendQueryFunc);if(canBuyStudentTicket=="Y"){stu_renameButton("research_u");$("#stu_submitQuery").attr("disabled",false);}});$("#submitQuery").click(sendQueryFunc);$("#stu_submitQuery").click(sendQueryFunc);if(isStudentTicketDateValid()){canBuyStudentTicket="Y";$("#stu_submitQuery").attr("disabled",false);}else{canBuyStudentTicket="N";stu_invalidQueryButton();}slidediv("#click1","#show1");$("#seatType").change(function(){$("#seatNum").val("0");});var tip="<span>1、目前，网站办理车次以“C”、“D”、“G”、“Z”、“T”、“K”、“L”、“A”、“Y”开头的以及1000至7598的旅客列车售票业务。</span>"+"<br><span>2、简码为车站简拼前两位或三位，简拼超过三位使用前两位加最后一位，例如上海虹桥SHQ。</span>";if(typeof(resignOldNum)=="undefined"){}else{tip+="<br><span>3、改签车票时，不能变更出发地、目的地、票种和身份信息。</span>";}$("#tip").append(tip);$("#seatNum").change(function(){var currentSelected=$(this).find("option:selected");if(currentSelected.val()!=0){addSeatTypeAndNum("#seatType","#seatNum","#seatAddResult");}});$("#trainCodeText").change(function(event){$("#seatAddResult").empty();});if($(":checkbox[name='trainClassArr']").length>0){$(":checkbox[name='trainClassArr']").each(function(index,dom){$(dom).click(function(){$("#seatAddResult").empty();$("#seatNum").val("0");});});}});String.prototype.replaceAll=function(s1,s2){return this.replace(new RegExp(s1,"gm"),s2);};