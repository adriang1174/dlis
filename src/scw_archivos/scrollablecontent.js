// JavaScript Document
/******************************************
* Scrollable content script III- (Modified from II) © Dynamic Drive (www.dynamicdrive.com)
* Visit http://www.dynamicdrive.com/ for full source code
* This notice must stay intact for use
******************************************/

function SCWindow(name,width,height){
  this.name = name
  this.objname = name
  this.width = width
  this.height = height
  this.contentwidth = this.width - 4
  //specify speed of scroll (greater=faster)
  this.speed = 5
}

SCWindow.prototype.initialize = function(){
    var id = this.name + "content"
    var id2 = this.name + "content2"
    this.crossobj = document.getElementById? document.getElementById(id2) : document.all[id2]
    this.contentbox = document.getElementById? document.getElementById(id) : document.all[id]
    this.contentheight=this.crossobj.offsetHeight
    this.contentbox.style.height = this.contentheight + "px"
    this.limit = this.height-this.contentheight
}

SCWindow.prototype.movedown = function (){
  var thisthis = this
  var topint = parseInt(this.crossobj.style.top)
  if (topint>=this.limit){
    this.crossobj.style.top=topint-this.speed+"px"
    this.movedownvar=setTimeout(function(){thisthis.movedown()},30)
  }
}

SCWindow.prototype.moveup = function (){
  var thisthis = this
  var topint = parseInt(this.crossobj.style.top)
  if (topint<0){
    this.crossobj.style.top=topint+this.speed+"px"
    this.moveupvar=setTimeout(function(){thisthis.moveup()},30)
  }
}

SCWindow.prototype.pagedown = function (){
  var thisthis = this
  var topint = parseInt(this.crossobj.style.top)
  if (topint>=this.limit){
    val = topint -(this.height - 10)
    if (val<this.limit){val=this.limit}
    this.crossobj.style.top=val+"px"
  }
}

SCWindow.prototype.pageup = function (){
  var thisthis = this
  var topint = parseInt(this.crossobj.style.top)
  if (topint<0){
    var val = (topint+this.height) - 10
    if(val > 0){val = 0}
    this.crossobj.style.top=val+"px"
  }
}

SCWindow.prototype.stop = function (){
  clearTimeout(this.moveupvar)
  clearTimeout(this.movedownvar)
}

SCWindow.prototype.control = function(cont){
  this.stop()
  switch (cont) {
    case "up"     : this.moveup(); break;
    case "down"   : this.movedown(); break;
    case "pgup"   : this.pageup(); break;
    case "pgdn"   : this.pagedown(); break;
    case "play"   : this.movedown(); break;
    case "reverse": this.moveup();
  }
}

SCWindow.prototype.startblock = function (contentstyle){
  var s = ""
  if(contentstyle){s = contentstyle}
  document.write('<div class="scwd1" id="' + this.name + 'container" style="width: ' + this.width + 'px; height: ' + this.height + 'px;">')
  document.write('<div class="scwd2" id="' + this.name + 'content2" style="width: ' + this.width + 'px; left: 0pt; top: 0px;">')
  document.write('<div class="scwd3" id="' + this.name + 'content" style="width: ' + this.contentwidth + 'px; clip: rect(0pt, 0pt, ' + this.width + 'px, ' + this.height + 'px);' + s + '">')
}

SCWindow.prototype.endblock = function (){
  document.write('</div></div></div>')
}

SCWindow.prototype.makecontrols = function (upimage,downimage){
  document.write('<div class="scwscrollcontrol" id="' + this.name + 'scroll">')
  document.write('<a class="scwbuttons" href="#" onClick="return false" onmouseover="' + this.objname + '.control(\'up\')" onmouseout="' + this.objname + '.stop()">')
  if(upimage){document.write('<img src="' + upimage + '" border="0" alt="/\\ ">')}else{document.write('/\\ ')}
  document.write('<a class="scwbuttons" href="#" onClick="return false" onmouseover="' + this.objname + '.control(\'down\')" onmouseout="' + this.objname + '.stop()">')
  if(downimage){document.write('<img src="' + downimage + '" border="0">')}else{document.write('\\/')}
  document.write('</a></div>')
}

SCWindow.prototype.makepagecontrols = function (upimage,downimage){
  document.write('<div class="scwpagecontrol" id="' + this.name + 'page">')
  document.write('<a class="scwbuttons" href="javascript: ' + this.objname + '.control(\'pgup\')">')
  if(upimage){document.write('<img src="' + upimage + '" border="0">')}else{document.write('//\\\\ ')}
  document.write('</a><a class="scwbuttons" href="javascript: ' + this.objname + '.control(\'pgdn\')">')
  if(downimage){document.write('<img src="' + downimage + '" border="0">')}else{document.write('\\\\//')}
  document.write('</a></div>')

}

SCWindow.prototype.makeplaycontrols = function (stopimage,playimage,reverseimage){
  document.write('<div class="scwplaycontrol" id="' + this.name + 'play">')
  document.write('<a class="scwbuttons" href="javascript: ' + this.objname + '.control(\'reverse\')">')
  if(reverseimage){document.write('<img src="' + reverseimage + '" border="0">')}else{document.write('< ')}
  document.write('</a><a class="scwbuttons" href="javascript: ' + this.objname + '.stop()">')
  if(stopimage){document.write('<img src="' + stopimage + '" border="0">')}else{document.write('0')}
  document.write('</a><a class="scwbuttons" href="javascript: ' + this.objname + '.control(\'play\')">')
  if(playimage){document.write('<img src="' + playimage + '" border="0">')}else{document.write(' >')}
  document.write('</a></div>')

}
